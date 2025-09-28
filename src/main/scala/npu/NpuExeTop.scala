package npu
import chisel3._
import chisel3.util._

class DummyMesh(rows: Int, dataW: Int) extends Module {
  private val rowBits = rows * dataW
  private val cDataW = dataW

  val io = IO(new Bundle {
    val a = Flipped(Decoupled(UInt(rowBits.W)))
    val b = Flipped(Decoupled(UInt(rowBits.W)))
    val d = Decoupled(UInt(rowBits.W))
  })

  val sIdle :: sAccumulate :: sOutput :: Nil = Enum(3)
  val stateReg = RegInit(sIdle)

  val cMat = Reg(Vec(rows, Vec(rows, UInt(cDataW.W))))
  val kCnt = Reg(UInt(log2Ceil(rows + 1).W))
  val oCnt = Reg(UInt(log2Ceil(rows + 1).W))

  io.a.ready := false.B
  io.b.ready := false.B
  io.d.valid := false.B
  io.d.bits  := 0.U

  val aVec = io.a.bits.asTypeOf(Vec(rows, UInt(dataW.W)))
  val bVec = io.b.bits.asTypeOf(Vec(rows, UInt(dataW.W)))

  switch(stateReg) {
    is(sIdle) {
      io.a.ready := true.B
      io.b.ready := true.B

      when(io.a.fire && io.b.fire) {
        stateReg := sAccumulate
        for (i <- 0 until rows) {
          for (j <- 0 until rows) {
            cMat(i)(j) := aVec(i) * bVec(j)
          }
        }
        kCnt := 1.U
      }
    }

    is(sAccumulate) {
      io.a.ready := true.B
      io.b.ready := true.B

      when(io.a.fire && io.b.fire) {
        for (i <- 0 until rows) {
          for (j <- 0 until rows) {
            cMat(i)(j) := cMat(i)(j) + aVec(i) * bVec(j)
          }
        }
        kCnt := kCnt + 1.U
      }

      when(kCnt === rows.U ) {
        stateReg := sOutput
        oCnt := 0.U
      }
    }

    is(sOutput) {
      io.d.valid := true.B
      io.d.bits  := cMat(oCnt).asTypeOf(UInt(rowBits.W))

      when(io.d.fire) {
        oCnt := oCnt + 1.U
        when(oCnt === (rows - 1).U) {
          stateReg := sIdle
        }
      }
    }
  }
}

class NpuExeTop(
    blockSize : Int = 4,
    spBanks   : Int = 4,
    spEntries : Int = 256,
    dataW     : Int = 16,
    addrW     : Int = 16) extends Module {

  private val spWidth = blockSize * dataW

  val dut  = Module(new NpuExecuteController(
                 blockSize, spBanks, spEntries, dataW, addrW))
  val mesh = Module(new DummyMesh(blockSize, dataW))

  case class BankIo() {
    val mem     = SyncReadMem(spEntries, UInt(spWidth.W))
    val respReg = RegInit(0.U.asTypeOf(Valid(UInt(spWidth.W))))
  }
  val banks = Seq.fill(spBanks)(BankIo())

  for ((b, idx) <- banks.zipWithIndex) {
    val rd  = dut.io.spR(idx)
    rd.req.ready := true.B
    val doRead   = rd.req.fire
    val rdData   = b.mem.read(rd.req.bits, doRead)

    b.respReg.valid := RegNext(doRead, init = false.B)
    b.respReg.bits  := rdData
    rd.resp <> b.respReg
  }

  for ((b, idx) <- banks.zipWithIndex) {
    val wr = dut.io.spW(idx)
    when(wr.en) { b.mem.write(wr.addr, wr.data) }
  }

  dut.io.mesh <> mesh.io

  val io = IO(new Bundle {
    val cmd  = Flipped(dut.io.cmd.cloneType)
    val done = Output(Bool())

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

  dut.io.cmd <> io.cmd
  io.done    := dut.io.done

  when(io.init.en) {
    for (idx <- 0 until spBanks) {
      when(io.init.bank === idx.U) {
        banks(idx).mem.write(io.init.addr, io.init.data)
      }
    }
  }

  val peekDatas = Wire(Vec(spBanks, UInt(spWidth.W)))
  for ((b, idx) <- banks.zipWithIndex) {
    val en   = io.peek.bank === idx.U
    val rdat = b.mem.read(io.peek.addr, en)
    peekDatas(idx) := rdat
  }
  io.peek.data := peekDatas(io.peek.bank)

}
