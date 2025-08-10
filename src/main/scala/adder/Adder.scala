// src/main/scala/adder/Adder.scala
package adder

import chisel3._
//import circt.stage.ChiselStage

class Adder(width: Int = 8) extends Module {
  val io = IO(new Bundle {
    val a = Input(UInt(width.W))
    val b = Input(UInt(width.W))
    val y = Output(UInt(width.W))
  })
  io.y := io.a + io.b
}



// Verilog를 뽑고 싶을 때 편리한 object
/*
object GenerateVerilog extends App {
  (new chisel3.stage.ChiselStage)
    .emitVerilog(new Adder(8), Array("--target-dir", "generated"))
}
*/


