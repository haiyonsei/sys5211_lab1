// src/main/scala/npu/ExecuteController.scal
package npu

import chisel3._
import chisel3.util._

class SpReadIO(entries: Int, wBits: Int)  extends Bundle {
  val req  = Decoupled(UInt(log2Ceil(entries).W))
  val resp = Flipped(Valid(UInt(wBits.W)))
}
class SpWriteIO(entries: Int, wBits: Int) extends Bundle {
  val en   = Output(Bool())
  val addr = Output(UInt(log2Ceil(entries).W))
  val data = Output(UInt(wBits.W))
}

class MeshIO(wBits: Int, rows: Int) extends Bundle {
  val a = Decoupled(UInt(wBits.W))
  val b = Decoupled(UInt(wBits.W))
  val d = Flipped(Decoupled(UInt(wBits.W)))     
}

class NpuCmd(addrW: Int) extends Bundle {
  val aBase = UInt(addrW.W)
  val bBase = UInt(addrW.W)
  val cBase = UInt(addrW.W)
  val start = Bool()
}

/* ══════════════════════════════════════════════════════
 * EDUCATIONAL EXECUTE-CONTROLLER
 * • Output-Stationary
 * • Private scratch-pad is “row-addressed”
 * • One scratch-pad row  = DIM (=blockSize) elements
 * • Bank clash solved by per-operand 1-row buffer
 * ═════════════════════════════════════════════════════ */
class NpuExecuteController(
    blockSize : Int = 4,   
    spBanks   : Int = 4,
    spEntries : Int = 1024,
    dataW     : Int = 16,
    addrW     : Int = 16) extends Module {

  private val spWidth = blockSize * dataW 

  /* ---- IO ---- */
  val io = IO(new Bundle {
    val cmd  = Flipped(Decoupled(new NpuCmd(addrW)))
    val spR  = Vec(spBanks, new SpReadIO(spEntries, spWidth))
    val spW  = Vec(spBanks, new SpWriteIO(spEntries, spWidth))
    val mesh = new MeshIO(spWidth, blockSize)
    val busy = Output(Bool())
    val done = Output(Bool())
  })

  /* ---- helpers ---- */
  @inline private def bank(addr: UInt) = addr(log2Ceil(spBanks) - 1, 0)
  @inline private def row (addr: UInt) = addr >> log2Ceil(spBanks)

  /* ---- default wires ---- */
  io.spR.foreach   { r => r.req.valid := false.B; r.req.bits := 0.U }
  io.spW.foreach   { w => w.en  := false.B; w.addr := 0.U; w.data := 0.U }
  io.mesh.a.valid := false.B;   io.mesh.b.valid := false.B
  io.mesh.a.bits  := 0.U;       io.mesh.b.bits  := 0.U
  io.mesh.d.ready := true.B
  io.cmd.ready    := false.B
  io.done         := false.B

  /* ---- FSM ---- */
  object S extends ChiselEnum { val idle, run, finish = Value }
  import S._
  val state = RegInit(idle)
  io.busy := state === run

  /* ---- loop indices (row granularity) ---- */
  val aRow = Reg(UInt(log2Ceil(blockSize).W))
  val bRow = Reg(UInt(log2Ceil(blockSize).W))
  val cRow = Reg(UInt(log2Ceil(blockSize).W))

  /* ---- base addresses ---- */
  val aBase = Reg(UInt(addrW.W))
  val bBase = Reg(UInt(addrW.W))
  val cBase = Reg(UInt(addrW.W))

  /* ---- per-operand 1-row buffers ---- */
  val aBufValid = RegInit(false.B)
  val bBufValid = RegInit(false.B)
  val aBufData  = Reg(UInt(spWidth.W))
  val bBufData  = Reg(UInt(spWidth.W))
  
  /* ---- Add state to track issued-but-not-yet-received reads ---- */
  val aReadIssued = RegInit(false.B)
  val bReadIssued = RegInit(false.B)

  /* ======================================================= */
  /* MAIN FSM                                                */
  /* ======================================================= */
  switch(state) {

    is(idle) {
      io.cmd.ready := true.B
      when(io.cmd.fire) {
        aBase := io.cmd.bits.aBase
        bBase := io.cmd.bits.bBase
        cBase := io.cmd.bits.cBase
        aRow  := 0.U;  bRow := 0.U;  cRow := 0.U
        aBufValid   := false.B
        bBufValid   := false.B
        aReadIssued := false.B
        bReadIssued := false.B
        state := run
      }
    }

    is(run) {
      /* S0 */
      val aAddr   = aBase + aRow
      val bAddr   = bBase + bRow
      val clash   = bank(aAddr) === bank(bAddr)

      val aPort = io.spR(bank(aAddr))
      val bPort = io.spR(bank(bAddr))
      
      val a_fire = !aBufValid && !aReadIssued && aPort.req.ready
      when(a_fire) {
        aPort.req.valid := true.B
        aPort.req.bits  := row(aAddr)
        aReadIssued     := true.B
      }
      
      when(!bBufValid && !bReadIssued && bPort.req.ready && !(clash)) {
        bPort.req.valid := true.B
        bPort.req.bits  := row(bAddr)
        bReadIssued     := true.B
      }

      /* S1 */
      when(aPort.resp.valid && aReadIssued) {
        aBufData    := aPort.resp.bits
        aBufValid   := true.B
        aReadIssued := false.B 
        aRow        := aRow + 1.U
      }
      
      when(bPort.resp.valid && bReadIssued) {
        bBufData    := bPort.resp.bits
        bBufValid   := true.B
        bReadIssued := false.B 
        bRow        := bRow + 1.U
      }

      /* S2 */
      when(aBufValid && bBufValid &&
           io.mesh.a.ready && io.mesh.b.ready) {

        io.mesh.a.valid := true.B; io.mesh.a.bits := aBufData
        io.mesh.b.valid := true.B; io.mesh.b.bits := bBufData
        aBufValid := false.B;      bBufValid := false.B

        val aVec = aBufData.asTypeOf(Vec(blockSize, UInt(dataW.W)))
        val bVec = bBufData.asTypeOf(Vec(blockSize, UInt(dataW.W)))
        printf(p"[FEED] aRow=${aRow-1.U}  A=${aVec}\n")
        printf(p"[FEED] bRow=${bRow-1.U}  B=${bVec}\n")
      }

      /* S3 */
      val cAddr = cBase + cRow
      when(io.mesh.d.valid) {
        val w = io.spW(bank(cAddr))
        w.en   := true.B
        w.addr := row(cAddr)
        w.data := io.mesh.d.bits

        val cVec = io.mesh.d.bits.asTypeOf(Vec(blockSize, UInt(dataW.W)))
        printf(p"[WRITE] cRow=${cRow}  C=${cVec}\n")

        cRow := cRow + 1.U
        when(cRow === (blockSize - 1).U) { state := finish }
      }
    }

    is(finish) {
      io.done := true.B
      when(!io.cmd.bits.start) { state := idle }
    }
  }
}
