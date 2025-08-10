
package npu

import chisel3._
import chisel3.util._


/** 4×4 Outer-Product Accumulating DummyMesh
  *   ‣ 매 cycle: C += a ⊗ bᵀ
  *   ‣ 4 쌍 누적 후 4 cycle 동안 행(row) 별로 결과 스트림 출력
  */

/** ------------------------------------------------------------
  *  Outer-Product Accumulating DummyMesh (4 × 4, 행렬 OS 출력)
  *    • 매 사이클 a·bᵀ 을 누적 (총 4쌍)
  *    • 누적이 끝나면 4 사이클 동안 C 행(row)을 순차 출력
  *    • io.d 는 **등록(reg)** 단 한 단계 뒤에 나가므로
  *      combinational-loop 경로가 존재하지 않는다
  * ----------------------------------------------------------- */



import chisel3._
import chisel3.util._

class DummyMesh(rows: Int, dataW: Int) extends Module {
  private val rowBits = rows * dataW
  // 결과값의 데이터 폭은 입력 데이터 폭의 2배 + 행의 수에 대한 log 값
  // (누적 덧셈으로 인한 비트 수 증가 고려)
  //private val cDataW = 2 * dataW + log2Ceil(rows)
  private val cDataW = dataW // + log2Ceil(rows)

  val io = IO(new Bundle {
    // a는 열벡터, b는 행벡터로 간주됨
    val a = Flipped(Decoupled(UInt(rowBits.W)))
    val b = Flipped(Decoupled(UInt(rowBits.W)))
    // d는 결과 행렬 C의 각 행을 순서대로 출력
    val d = Decoupled(UInt(rowBits.W))
  })

  // --- 상태 정의 ---
  val sIdle :: sAccumulate :: sOutput :: Nil = Enum(3)
  val stateReg = RegInit(sIdle)

  // --- 레지스터 ---
  // 결과 행렬 C를 저장할 레지스터
  val cMat = Reg(Vec(rows, Vec(rows, UInt(cDataW.W))))
  // 누적 횟수 카운터 (k)
  val kCnt = Reg(UInt(log2Ceil(rows + 1).W))
  // 출력 행 카운터
  val oCnt = Reg(UInt(log2Ceil(rows + 1).W))

  // --- 기본(Default) 출력 값 설정 ---
  io.a.ready := false.B
  io.b.ready := false.B
  io.d.valid := false.B
  io.d.bits  := 0.U

  // 입력 벡터 타입 변환
  val aVec = io.a.bits.asTypeOf(Vec(rows, UInt(dataW.W)))
  val bVec = io.b.bits.asTypeOf(Vec(rows, UInt(dataW.W)))

  // --- 상태 머신 (FSM) 로직 ---
  switch(stateReg) {
    is(sIdle) {
      // IDLE 상태: 초기화 및 입력 대기
      io.a.ready := true.B
      io.b.ready := true.B

      when(io.a.fire && io.b.fire) {
        // 첫 번째 유효한 입력이 들어오면 ACCUMULATE 상태로 전환
        stateReg := sAccumulate
        // 첫 번째 외적 계산 (누적이 아니므로 바로 대입)
        for (i <- 0 until rows) {
          for (j <- 0 until rows) {
            cMat(i)(j) := aVec(i) * bVec(j)
            //printf("%d ", cMat(i)(j))
          }
          //printf("\n")
        }
        kCnt := 1.U // 이미 한 번 계산했으므로 카운터는 1부터 시작
      }
    }

    is(sAccumulate) {
      // ACCUMULATE 상태: rows(4) 만큼 외적을 누적
      io.a.ready := true.B
      io.b.ready := true.B

      when(io.a.fire && io.b.fire) {
        // cMat = cMat + a * b^T
        for (i <- 0 until rows) {
          for (j <- 0 until rows) {
            cMat(i)(j) := cMat(i)(j) + aVec(i) * bVec(j)
            //printf("%d ", cMat(i)(j))
          }
          //printf("\n")
        }
        //printf("\n")
        kCnt := kCnt + 1.U
      }

      when(kCnt === rows.U ) {
        // 누적이 완료되면 OUTPUT 상태로 전환
        stateReg := sOutput
        oCnt := 0.U // 출력 카운터 초기화
      }
    }

    is(sOutput) {
      // OUTPUT 상태: 결과 행렬 C를 한 행씩 출력
      io.d.valid := true.B
      io.d.bits  := cMat(oCnt).asTypeOf(UInt(rowBits.W))
      //printf(p"[out] =${cMat(oCnt)}\n")

      when(io.d.fire) {
        // 수신 측이 데이터를 받았을 때만 다음 행으로 이동
        oCnt := oCnt + 1.U
        when(oCnt === (rows - 1).U) {
          // 마지막 행까지 출력이 완료되면 IDLE 상태로 복귀
          stateReg := sIdle
        }
      }
    }
  }
}

/* ---------- Top-level wrapper (controller + SRAM + mesh) ---------- */
class NpuExeTop(
    blockSize : Int = 4,     // DIM
    spBanks   : Int = 4,
    spEntries : Int = 256,
    dataW     : Int = 16,
    addrW     : Int = 16) extends Module {

  /* row width */
  private val spWidth = blockSize * dataW

  /* sub-modules */
  val dut  = Module(new NpuExecuteController(
                 blockSize, spBanks, spEntries, dataW, addrW))
  val mesh = Module(new DummyMesh(blockSize, dataW))

  /* ---------- Scratch-pad banks ---------- */
  case class BankIo() {
    val mem     = SyncReadMem(spEntries, UInt(spWidth.W))
    val respReg = RegInit(0.U.asTypeOf(Valid(UInt(spWidth.W))))
  }
  val banks = Seq.fill(spBanks)(BankIo())

  /* read path */
  for ((b, idx) <- banks.zipWithIndex) {
    val rd  = dut.io.spR(idx)
    rd.req.ready := true.B
    val doRead   = rd.req.fire
    val rdData   = b.mem.read(rd.req.bits, doRead)

    b.respReg.valid := RegNext(doRead, init = false.B)
    b.respReg.bits  := rdData //RegNext(rdData, init = 0.U)
    //b.respReg.bits  := rdData //, init = 0.U)
    rd.resp <> b.respReg
  }

  /* write path */
  for ((b, idx) <- banks.zipWithIndex) {
    val wr = dut.io.spW(idx)
    when(wr.en) { b.mem.write(wr.addr, wr.data) }
  }

  /* connect mesh */
  dut.io.mesh <> mesh.io

  /* ---------- external IO ---------- */
  val io = IO(new Bundle {
    val cmd  = Flipped(dut.io.cmd.cloneType)
    val done = Output(Bool())

    /* scratch-pad init / peek */
    val init = new Bundle {
      val en   = Input(Bool())
      val bank = Input(UInt(log2Ceil(spBanks).W))
      val addr = Input(UInt(log2Ceil(spEntries).W))
      val data = Input(UInt(spWidth.W))
    }
    val peek = new Bundle {
      val bank = Input(UInt(log2Ceil(spBanks).W))
      val addr = Input(UInt(log2Ceil(spEntries).W))
      val data = Output(UInt(spWidth.W))
    }
  })

  /* command pass-through */
  dut.io.cmd <> io.cmd
  io.done    := dut.io.done

  /* ---------- scratch-pad init ---------- */
  when(io.init.en) {
    // choose the right bank with a hardware mux
    for (idx <- 0 until spBanks) {
      when(io.init.bank === idx.U) {
        banks(idx).mem.write(io.init.addr, io.init.data)
      }
    }
  }

  /* ---------- scratch-pad peek ---------- */
  /*
  val peekWire = WireDefault(0.U(spWidth.W))
  for (idx <- 0 until spBanks) {
    when(io.peek.bank === idx.U) {
      printf("peek %d\n", io.peek.addr)
      peekWire := banks(idx).mem.read(io.peek.addr, false.B)
    }
  }
  io.peek.data := peekWire
  */
  /* ---------- scratch-pad peek (FIX) ---------- */
  // 1) 각 bank에서 enable을 켜고 동기 read
  // 2) 1-cycle 뒤의 데이터를 골라서 io.peek.data로 전달
  val peekDatas = Wire(Vec(spBanks, UInt(spWidth.W)))
  for ((b, idx) <- banks.zipWithIndex) {
    val en   = io.peek.bank === idx.U
    val rdat = b.mem.read(io.peek.addr, en)      // ★ en을 true로 걸어줘야 함
    peekDatas(idx) := rdat// RegNext(rdat, 0.U)          // ★ 동기 read → 다음 사이클에 유효
  }
  io.peek.data := peekDatas(io.peek.bank)

}
