
package npu

import chisel3.stage.ChiselGeneratorAnnotation
import circt.stage.ChiselStage

// Verilog를 뽑고 싶을 때 편리한 object
object EmitVerilog extends App {
    (new chisel3.stage.ChiselStage).emitVerilog(new NpuExeTop(
          blockSize = 4, spBanks = 4, spEntries = 256, dataW = 16, addrW = 16), args)
}


/*
package npu

import chisel3.stage.ChiselGeneratorAnnotation
import circt.stage.ChiselStage

object EmitVerilog extends App {
  (new ChiselStage).execute(
    Array(
      "--target", "systemverilog",       // CIRCT 백엔드로 SV 생성
      "--target-dir", "generated",
      "--split-verilog",
      "--disable-all-randomization"      // 재현성 원하면 유지, 아니면 제거
      // 필요시 추가: "--preserve-aggregate=1"
    ),
    Seq(
      ChiselGeneratorAnnotation(() =>
        new NpuExeTop(
          blockSize = 4, spBanks = 4, spEntries = 256, dataW = 16, addrW = 16
        )
      )
    )
  )
}

*/
