
package npu

import chisel3.stage.ChiselGeneratorAnnotation
import circt.stage.ChiselStage

object EmitVerilog extends App {
    (new chisel3.stage.ChiselStage).emitVerilog(new NpuExeTop(
          blockSize = 4, spBanks = 4, spEntries = 256, dataW = 16, addrW = 16), args)
}
