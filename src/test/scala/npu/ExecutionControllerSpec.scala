
package npu

import chisel3._
import chisel3.util._
import chiseltest._
import org.scalatest.freespec.AnyFreeSpec
import firrtl.options.TargetDirAnnotation

class ExecuteControllerSpec
    extends AnyFreeSpec
    with   ChiselScalatestTester {

  "NpuExecuteController should multiply one 4×4 block correctly" in {

    val BS         = 4
    val SP_BANKS   = 4
    val SP_ENTRIES = 256
    val DATA_W     = 16
    val ADDR_W     = 16
    val SP_WIDTH   = BS * DATA_W

    val A = Array.tabulate(BS,BS)((i,k) => i+k)
    val B = Array.tabulate(BS,BS)((k,j) => k+j)
    val C = Array.tabulate(BS,BS)((k,j) => 1)

    def spBank(base:Int,rowIdx:Int) =
      (base + rowIdx) % SP_BANKS
    def spRow (base:Int,rowIdx:Int) =
      (base + rowIdx) / SP_BANKS

    val mask = (1 << DATA_W) - 1
    def packRow(vec: Seq[Int]): BigInt = {
      require(vec.length == BS)
      vec.zipWithIndex
        .map { case (v, idx) => (BigInt(v & mask) << (idx*DATA_W)) }
        .reduce(_ | _)
    }
    def unpackRow(word: BigInt): Seq[Int] =
      (0 until BS).map(idx => ((word >> (idx*DATA_W)) & mask).toInt)

    test(new NpuExeTop(
      blockSize = BS, spBanks = SP_BANKS,
      spEntries = SP_ENTRIES, dataW = DATA_W, addrW = ADDR_W)).withAnnotations(Seq(
     )
    ) { dut =>

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
        dut.clock.step()
        unpackRow(dut.io.peek.data.peek().litValue)
      }

      val aBase = 0
      val bBase = 4
      val cBase = 32

      for(i <- 0 until BS) {
       writeRow(spBank(aBase,i), spRow(aBase,i),
          (0 until BS).map(k => A(i)(k)))
      }

      for(k <- 0 until BS) 
        writeRow(spBank(bBase,k), spRow(bBase,k),
          (0 until BS).map(j => C(k)(j)))

     

      dut.io.cmd.valid     .poke(true.B)
      dut.io.cmd.bits.aBase.poke(aBase.U)
      dut.io.cmd.bits.bBase.poke(bBase.U)
      dut.io.cmd.bits.cBase.poke(cBase.U)
      dut.io.cmd.bits.start.poke(true.B)
      dut.clock.step()
      dut.io.cmd.valid.poke(false.B)

      var cycleCount = 0

      while(!dut.io.done.peek().litToBoolean) {
        dut.clock.step()
        cycleCount = cycleCount + 1
      }
      println(s"[INFO] Computation finished in $cycleCount cycles.")

      def golden(i:Int,j:Int): Int =
        (0 until BS).map(k => A(i)(k)*B(k)(j)).sum

      for(i <- 0 until BS) {
        val cRowVec = readRow(
          spBank(cBase,i), spRow(cBase,i))
        println(cRowVec)
      }
    }
  }
}
