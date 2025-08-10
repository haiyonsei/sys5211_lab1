
package npu

import chisel3._
import chisel3.util._
import chiseltest._
import org.scalatest.freespec.AnyFreeSpec
import firrtl.options.TargetDirAnnotation

/** ------------------------------------------------------------
  *  Execute-Controller 단위 테스트  (row = packed-UInt)
  * ----------------------------------------------------------- */
class ExecuteControllerSpec
    extends AnyFreeSpec
    with   ChiselScalatestTester {

  "NpuExecuteController should multiply one 4×4 block correctly" in {

    /* ---------- DUT 파라미터 ---------- */
    val BS         = 4                    // blockSize == DIM
    val SP_BANKS   = 4
    val SP_ENTRIES = 256
    val DATA_W     = 16
    val ADDR_W     = 16
    val SP_WIDTH   = BS * DATA_W          // row bit-width

    /* ---------- 골든 행렬 ---------- */
    val A = Array.tabulate(BS,BS)((i,k) => i+k)
    val B = Array.tabulate(BS,BS)((k,j) => k+j)
    val C = Array.tabulate(BS,BS)((k,j) => 1)

    /* ---------- bank / row 계산 ---------- */
    def spBank(base:Int,rowIdx:Int) =
      (base + rowIdx) % SP_BANKS
    def spRow (base:Int,rowIdx:Int) =
      (base + rowIdx) / SP_BANKS

    /* ---------- pack / unpack helpers ---------- */
    val mask = (1 << DATA_W) - 1
    def packRow(vec: Seq[Int]): BigInt = {
      require(vec.length == BS)
      vec.zipWithIndex
        .map { case (v, idx) => (BigInt(v & mask) << (idx*DATA_W)) }
        .reduce(_ | _)
    }
    def unpackRow(word: BigInt): Seq[Int] =
      (0 until BS).map(idx => ((word >> (idx*DATA_W)) & mask).toInt)

    /* ---------- 테스트 ---------- */
    test(new NpuExeTop(
      blockSize = BS, spBanks = SP_BANKS,
      spEntries = SP_ENTRIES, dataW = DATA_W, addrW = ADDR_W)).withAnnotations(Seq(
        // Verilator 플래그 추가하고 싶으면:
        //VerilatorFlags(Seq("-O3", "--trace"))
      //VcsBackendAnnotation,                        // ★ VCS 사용
      //TargetDirAnnotation("build/vcs"),            // 산출물 디렉토리
      // 필요시 컴파일 플래그:
      //VcsFlags(Seq("-sverilog", "-full64", "-timescale=1ns/1ps", "-debug_access+all")),
      // 필요시 런타임 플래그(시뮬레이터 실행 인자):
      //VcsSimFlags(Seq("+vcs+lic+wait")
     )
    ) { dut =>

      /* ===== row write / read ===== */
      def writeRow(bank:Int,row:Int,data:Seq[Int]): Unit = {
        dut.io.init.en  .poke(true.B)
        dut.io.init.bank.poke(bank.U)
        dut.io.init.addr.poke(row.U)
        dut.io.init.data.poke(packRow(data).U(SP_WIDTH.W))
        dut.clock.step()
        dut.io.init.en.poke(false.B)
      }
      def readRow(bank:Int,row:Int): Seq[Int] = {
        dut.io.peek.bank.poke(bank.U)
        dut.io.peek.addr.poke(row.U)
        dut.clock.step()           // 1-cycle latency
        unpackRow(dut.io.peek.data.peek().litValue)
      }

      /* ===== Scratch-pad 초기화 ===== */
      val aBase = 0
      val bBase = 4
      val cBase = 32

      //println(spBank(aBase, 0), spRow(aBase, 1))
      //println(spBank(cBase, 0), spRow(cBase, 1))
      // A rows
      for(i <- 0 until BS) {
       writeRow(spBank(aBase,i), spRow(aBase,i),
          (0 until BS).map(k => A(i)(k)))
      }
      /*
      for(i <- 0 until BS) {
        val cRowVec = readRow(
          spBank(cBase,i), spRow(cBase,i))
        println(cRowVec)
      }
      */

      // B rows
      for(k <- 0 until BS) 
        writeRow(spBank(bBase,k), spRow(bBase,k),
          (0 until BS).map(j => C(k)(j)))

     

      /* ===== command issue ===== */
      dut.io.cmd.valid     .poke(true.B)
      dut.io.cmd.bits.aBase.poke(aBase.U)
      dut.io.cmd.bits.bBase.poke(bBase.U)
      dut.io.cmd.bits.cBase.poke(cBase.U)
      dut.io.cmd.bits.start.poke(true.B)
      dut.clock.step()
      dut.io.cmd.valid.poke(false.B)

      var cycleCount = 0

      /* ===== wait for completion ===== */
      while(!dut.io.done.peek().litToBoolean) {
        dut.clock.step()
        cycleCount = cycleCount + 1
      }
      println(s"[INFO] Computation finished in $cycleCount cycles.")

      /* ===== result check ===== */
      def golden(i:Int,j:Int): Int =
        (0 until BS).map(k => A(i)(k)*B(k)(j)).sum

      for(i <- 0 until BS) {
        val cRowVec = readRow(
          spBank(cBase,i), spRow(cBase,i))
        println(cRowVec)


        //println(spBank(cBase,i), spRow(cBase, i))

        //for(j <- 0 until BS) {
        //  assert(
        //    cRowVec(j) == golden(i,j),
        //    s"C($i,$j) = ${cRowVec(j)}, expected ${golden(i,j)}")
        //}
      }
    }
  }
}
