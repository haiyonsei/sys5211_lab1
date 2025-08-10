// src/test/scala/adder/AdderSpec.scala
package adder

import chisel3._
import chiseltest._
import org.scalatest.freespec.AnyFreeSpec

class AdderSpec extends AnyFreeSpec with ChiselScalatestTester {
  "Adder adds correctly" in {
    test(new Adder(8)) { dut =>
      val vec = Seq(
        (0x00, 0x00),
        (0x03, 0x05),
        (0x0F, 0x01),
        (0xAA, 0x11)
      )

      vec.foreach { case (a, b) =>
        dut.io.a.poke(a.U)
        dut.io.b.poke(b.U)
        dut.clock.step()
        dut.io.y.expect((a + b & 0xFF).U)
      }
    }
  }
}

