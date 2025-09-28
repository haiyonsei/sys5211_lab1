// src/main/scala/adder/Adder.scala
package adder

import chisel3._

class Adder(width: Int = 8) extends Module {
  val io = IO(new Bundle {
    val a = Input(UInt(width.W))
    val b = Input(UInt(width.W))
    val y = Output(UInt(width.W))
  })
  io.y := io.a + io.b
}


