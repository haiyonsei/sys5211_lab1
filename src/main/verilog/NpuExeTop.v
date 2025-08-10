
module DummyMesh(
  input         clock,
  input         reset,
  output        io_a_ready, // @[src/main/scala/npu/NpuExeTop.scala 33:14]
  input         io_a_valid, // @[src/main/scala/npu/NpuExeTop.scala 33:14]
  input  [63:0] io_a_bits, // @[src/main/scala/npu/NpuExeTop.scala 33:14]
  output        io_b_ready, // @[src/main/scala/npu/NpuExeTop.scala 33:14]
  input         io_b_valid, // @[src/main/scala/npu/NpuExeTop.scala 33:14]
  input  [63:0] io_b_bits, // @[src/main/scala/npu/NpuExeTop.scala 33:14]
  output        io_d_valid, // @[src/main/scala/npu/NpuExeTop.scala 33:14]
  output [63:0] io_d_bits // @[src/main/scala/npu/NpuExeTop.scala 33:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] stateReg; // @[src/main/scala/npu/NpuExeTop.scala 43:25]
  reg [15:0] cMat_0_0; // @[src/main/scala/npu/NpuExeTop.scala 47:17]
  reg [15:0] cMat_0_1; // @[src/main/scala/npu/NpuExeTop.scala 47:17]
  reg [15:0] cMat_0_2; // @[src/main/scala/npu/NpuExeTop.scala 47:17]
  reg [15:0] cMat_0_3; // @[src/main/scala/npu/NpuExeTop.scala 47:17]
  reg [15:0] cMat_1_0; // @[src/main/scala/npu/NpuExeTop.scala 47:17]
  reg [15:0] cMat_1_1; // @[src/main/scala/npu/NpuExeTop.scala 47:17]
  reg [15:0] cMat_1_2; // @[src/main/scala/npu/NpuExeTop.scala 47:17]
  reg [15:0] cMat_1_3; // @[src/main/scala/npu/NpuExeTop.scala 47:17]
  reg [15:0] cMat_2_0; // @[src/main/scala/npu/NpuExeTop.scala 47:17]
  reg [15:0] cMat_2_1; // @[src/main/scala/npu/NpuExeTop.scala 47:17]
  reg [15:0] cMat_2_2; // @[src/main/scala/npu/NpuExeTop.scala 47:17]
  reg [15:0] cMat_2_3; // @[src/main/scala/npu/NpuExeTop.scala 47:17]
  reg [15:0] cMat_3_0; // @[src/main/scala/npu/NpuExeTop.scala 47:17]
  reg [15:0] cMat_3_1; // @[src/main/scala/npu/NpuExeTop.scala 47:17]
  reg [15:0] cMat_3_2; // @[src/main/scala/npu/NpuExeTop.scala 47:17]
  reg [15:0] cMat_3_3; // @[src/main/scala/npu/NpuExeTop.scala 47:17]
  reg [2:0] kCnt; // @[src/main/scala/npu/NpuExeTop.scala 49:17]
  reg [2:0] oCnt; // @[src/main/scala/npu/NpuExeTop.scala 51:17]
  wire [15:0] aVec_0 = io_a_bits[15:0]; // @[src/main/scala/npu/NpuExeTop.scala 60:32]
  wire [15:0] aVec_1 = io_a_bits[31:16]; // @[src/main/scala/npu/NpuExeTop.scala 60:32]
  wire [15:0] aVec_2 = io_a_bits[47:32]; // @[src/main/scala/npu/NpuExeTop.scala 60:32]
  wire [15:0] aVec_3 = io_a_bits[63:48]; // @[src/main/scala/npu/NpuExeTop.scala 60:32]
  wire [15:0] bVec_0 = io_b_bits[15:0]; // @[src/main/scala/npu/NpuExeTop.scala 61:32]
  wire [15:0] bVec_1 = io_b_bits[31:16]; // @[src/main/scala/npu/NpuExeTop.scala 61:32]
  wire [15:0] bVec_2 = io_b_bits[47:32]; // @[src/main/scala/npu/NpuExeTop.scala 61:32]
  wire [15:0] bVec_3 = io_b_bits[63:48]; // @[src/main/scala/npu/NpuExeTop.scala 61:32]
  wire  _T_1 = io_a_ready & io_a_valid; // @[src/main/scala/chisel3/util/Decoupled.scala 57:35]
  wire  _T_2 = io_b_ready & io_b_valid; // @[src/main/scala/chisel3/util/Decoupled.scala 57:35]
  wire  _T_3 = _T_1 & _T_2; // @[src/main/scala/npu/NpuExeTop.scala 70:22]
  wire [31:0] _cMat_0_0_T = aVec_0 * bVec_0; // @[src/main/scala/npu/NpuExeTop.scala 76:35]
  wire [31:0] _cMat_0_1_T = aVec_0 * bVec_1; // @[src/main/scala/npu/NpuExeTop.scala 76:35]
  wire [31:0] _cMat_0_2_T = aVec_0 * bVec_2; // @[src/main/scala/npu/NpuExeTop.scala 76:35]
  wire [31:0] _cMat_0_3_T = aVec_0 * bVec_3; // @[src/main/scala/npu/NpuExeTop.scala 76:35]
  wire [31:0] _cMat_1_0_T = aVec_1 * bVec_0; // @[src/main/scala/npu/NpuExeTop.scala 76:35]
  wire [31:0] _cMat_1_1_T = aVec_1 * bVec_1; // @[src/main/scala/npu/NpuExeTop.scala 76:35]
  wire [31:0] _cMat_1_2_T = aVec_1 * bVec_2; // @[src/main/scala/npu/NpuExeTop.scala 76:35]
  wire [31:0] _cMat_1_3_T = aVec_1 * bVec_3; // @[src/main/scala/npu/NpuExeTop.scala 76:35]
  wire [31:0] _cMat_2_0_T = aVec_2 * bVec_0; // @[src/main/scala/npu/NpuExeTop.scala 76:35]
  wire [31:0] _cMat_2_1_T = aVec_2 * bVec_1; // @[src/main/scala/npu/NpuExeTop.scala 76:35]
  wire [31:0] _cMat_2_2_T = aVec_2 * bVec_2; // @[src/main/scala/npu/NpuExeTop.scala 76:35]
  wire [31:0] _cMat_2_3_T = aVec_2 * bVec_3; // @[src/main/scala/npu/NpuExeTop.scala 76:35]
  wire [31:0] _cMat_3_0_T = aVec_3 * bVec_0; // @[src/main/scala/npu/NpuExeTop.scala 76:35]
  wire [31:0] _cMat_3_1_T = aVec_3 * bVec_1; // @[src/main/scala/npu/NpuExeTop.scala 76:35]
  wire [31:0] _cMat_3_2_T = aVec_3 * bVec_2; // @[src/main/scala/npu/NpuExeTop.scala 76:35]
  wire [31:0] _cMat_3_3_T = aVec_3 * bVec_3; // @[src/main/scala/npu/NpuExeTop.scala 76:35]
  wire [31:0] _GEN_1 = _T_1 & _T_2 ? _cMat_0_0_T : {{16'd0}, cMat_0_0}; // @[src/main/scala/npu/NpuExeTop.scala 47:17 70:36 76:24]
  wire [31:0] _GEN_2 = _T_1 & _T_2 ? _cMat_0_1_T : {{16'd0}, cMat_0_1}; // @[src/main/scala/npu/NpuExeTop.scala 47:17 70:36 76:24]
  wire [31:0] _GEN_3 = _T_1 & _T_2 ? _cMat_0_2_T : {{16'd0}, cMat_0_2}; // @[src/main/scala/npu/NpuExeTop.scala 47:17 70:36 76:24]
  wire [31:0] _GEN_4 = _T_1 & _T_2 ? _cMat_0_3_T : {{16'd0}, cMat_0_3}; // @[src/main/scala/npu/NpuExeTop.scala 47:17 70:36 76:24]
  wire [31:0] _GEN_5 = _T_1 & _T_2 ? _cMat_1_0_T : {{16'd0}, cMat_1_0}; // @[src/main/scala/npu/NpuExeTop.scala 47:17 70:36 76:24]
  wire [31:0] _GEN_6 = _T_1 & _T_2 ? _cMat_1_1_T : {{16'd0}, cMat_1_1}; // @[src/main/scala/npu/NpuExeTop.scala 47:17 70:36 76:24]
  wire [31:0] _GEN_7 = _T_1 & _T_2 ? _cMat_1_2_T : {{16'd0}, cMat_1_2}; // @[src/main/scala/npu/NpuExeTop.scala 47:17 70:36 76:24]
  wire [31:0] _GEN_8 = _T_1 & _T_2 ? _cMat_1_3_T : {{16'd0}, cMat_1_3}; // @[src/main/scala/npu/NpuExeTop.scala 47:17 70:36 76:24]
  wire [31:0] _GEN_9 = _T_1 & _T_2 ? _cMat_2_0_T : {{16'd0}, cMat_2_0}; // @[src/main/scala/npu/NpuExeTop.scala 47:17 70:36 76:24]
  wire [31:0] _GEN_10 = _T_1 & _T_2 ? _cMat_2_1_T : {{16'd0}, cMat_2_1}; // @[src/main/scala/npu/NpuExeTop.scala 47:17 70:36 76:24]
  wire [31:0] _GEN_11 = _T_1 & _T_2 ? _cMat_2_2_T : {{16'd0}, cMat_2_2}; // @[src/main/scala/npu/NpuExeTop.scala 47:17 70:36 76:24]
  wire [31:0] _GEN_12 = _T_1 & _T_2 ? _cMat_2_3_T : {{16'd0}, cMat_2_3}; // @[src/main/scala/npu/NpuExeTop.scala 47:17 70:36 76:24]
  wire [31:0] _GEN_13 = _T_1 & _T_2 ? _cMat_3_0_T : {{16'd0}, cMat_3_0}; // @[src/main/scala/npu/NpuExeTop.scala 47:17 70:36 76:24]
  wire [31:0] _GEN_14 = _T_1 & _T_2 ? _cMat_3_1_T : {{16'd0}, cMat_3_1}; // @[src/main/scala/npu/NpuExeTop.scala 47:17 70:36 76:24]
  wire [31:0] _GEN_15 = _T_1 & _T_2 ? _cMat_3_2_T : {{16'd0}, cMat_3_2}; // @[src/main/scala/npu/NpuExeTop.scala 47:17 70:36 76:24]
  wire [31:0] _GEN_16 = _T_1 & _T_2 ? _cMat_3_3_T : {{16'd0}, cMat_3_3}; // @[src/main/scala/npu/NpuExeTop.scala 47:17 70:36 76:24]
  wire [31:0] _GEN_104 = {{16'd0}, cMat_0_0}; // @[src/main/scala/npu/NpuExeTop.scala 94:38]
  wire [31:0] _cMat_0_0_T_3 = _GEN_104 + _cMat_0_0_T; // @[src/main/scala/npu/NpuExeTop.scala 94:38]
  wire [31:0] _GEN_105 = {{16'd0}, cMat_0_1}; // @[src/main/scala/npu/NpuExeTop.scala 94:38]
  wire [31:0] _cMat_0_1_T_3 = _GEN_105 + _cMat_0_1_T; // @[src/main/scala/npu/NpuExeTop.scala 94:38]
  wire [31:0] _GEN_106 = {{16'd0}, cMat_0_2}; // @[src/main/scala/npu/NpuExeTop.scala 94:38]
  wire [31:0] _cMat_0_2_T_3 = _GEN_106 + _cMat_0_2_T; // @[src/main/scala/npu/NpuExeTop.scala 94:38]
  wire [31:0] _GEN_107 = {{16'd0}, cMat_0_3}; // @[src/main/scala/npu/NpuExeTop.scala 94:38]
  wire [31:0] _cMat_0_3_T_3 = _GEN_107 + _cMat_0_3_T; // @[src/main/scala/npu/NpuExeTop.scala 94:38]
  wire [31:0] _GEN_108 = {{16'd0}, cMat_1_0}; // @[src/main/scala/npu/NpuExeTop.scala 94:38]
  wire [31:0] _cMat_1_0_T_3 = _GEN_108 + _cMat_1_0_T; // @[src/main/scala/npu/NpuExeTop.scala 94:38]
  wire [31:0] _GEN_109 = {{16'd0}, cMat_1_1}; // @[src/main/scala/npu/NpuExeTop.scala 94:38]
  wire [31:0] _cMat_1_1_T_3 = _GEN_109 + _cMat_1_1_T; // @[src/main/scala/npu/NpuExeTop.scala 94:38]
  wire [31:0] _GEN_110 = {{16'd0}, cMat_1_2}; // @[src/main/scala/npu/NpuExeTop.scala 94:38]
  wire [31:0] _cMat_1_2_T_3 = _GEN_110 + _cMat_1_2_T; // @[src/main/scala/npu/NpuExeTop.scala 94:38]
  wire [31:0] _GEN_111 = {{16'd0}, cMat_1_3}; // @[src/main/scala/npu/NpuExeTop.scala 94:38]
  wire [31:0] _cMat_1_3_T_3 = _GEN_111 + _cMat_1_3_T; // @[src/main/scala/npu/NpuExeTop.scala 94:38]
  wire [31:0] _GEN_112 = {{16'd0}, cMat_2_0}; // @[src/main/scala/npu/NpuExeTop.scala 94:38]
  wire [31:0] _cMat_2_0_T_3 = _GEN_112 + _cMat_2_0_T; // @[src/main/scala/npu/NpuExeTop.scala 94:38]
  wire [31:0] _GEN_113 = {{16'd0}, cMat_2_1}; // @[src/main/scala/npu/NpuExeTop.scala 94:38]
  wire [31:0] _cMat_2_1_T_3 = _GEN_113 + _cMat_2_1_T; // @[src/main/scala/npu/NpuExeTop.scala 94:38]
  wire [31:0] _GEN_114 = {{16'd0}, cMat_2_2}; // @[src/main/scala/npu/NpuExeTop.scala 94:38]
  wire [31:0] _cMat_2_2_T_3 = _GEN_114 + _cMat_2_2_T; // @[src/main/scala/npu/NpuExeTop.scala 94:38]
  wire [31:0] _GEN_115 = {{16'd0}, cMat_2_3}; // @[src/main/scala/npu/NpuExeTop.scala 94:38]
  wire [31:0] _cMat_2_3_T_3 = _GEN_115 + _cMat_2_3_T; // @[src/main/scala/npu/NpuExeTop.scala 94:38]
  wire [31:0] _GEN_116 = {{16'd0}, cMat_3_0}; // @[src/main/scala/npu/NpuExeTop.scala 94:38]
  wire [31:0] _cMat_3_0_T_3 = _GEN_116 + _cMat_3_0_T; // @[src/main/scala/npu/NpuExeTop.scala 94:38]
  wire [31:0] _GEN_117 = {{16'd0}, cMat_3_1}; // @[src/main/scala/npu/NpuExeTop.scala 94:38]
  wire [31:0] _cMat_3_1_T_3 = _GEN_117 + _cMat_3_1_T; // @[src/main/scala/npu/NpuExeTop.scala 94:38]
  wire [31:0] _GEN_118 = {{16'd0}, cMat_3_2}; // @[src/main/scala/npu/NpuExeTop.scala 94:38]
  wire [31:0] _cMat_3_2_T_3 = _GEN_118 + _cMat_3_2_T; // @[src/main/scala/npu/NpuExeTop.scala 94:38]
  wire [31:0] _GEN_119 = {{16'd0}, cMat_3_3}; // @[src/main/scala/npu/NpuExeTop.scala 94:38]
  wire [31:0] _cMat_3_3_T_3 = _GEN_119 + _cMat_3_3_T; // @[src/main/scala/npu/NpuExeTop.scala 94:38]
  wire [2:0] _kCnt_T_1 = kCnt + 3'h1; // @[src/main/scala/npu/NpuExeTop.scala 100:22]
  wire [31:0] _GEN_18 = _T_3 ? _cMat_0_0_T_3 : {{16'd0}, cMat_0_0}; // @[src/main/scala/npu/NpuExeTop.scala 47:17 90:36 94:24]
  wire [31:0] _GEN_19 = _T_3 ? _cMat_0_1_T_3 : {{16'd0}, cMat_0_1}; // @[src/main/scala/npu/NpuExeTop.scala 47:17 90:36 94:24]
  wire [31:0] _GEN_20 = _T_3 ? _cMat_0_2_T_3 : {{16'd0}, cMat_0_2}; // @[src/main/scala/npu/NpuExeTop.scala 47:17 90:36 94:24]
  wire [31:0] _GEN_21 = _T_3 ? _cMat_0_3_T_3 : {{16'd0}, cMat_0_3}; // @[src/main/scala/npu/NpuExeTop.scala 47:17 90:36 94:24]
  wire [31:0] _GEN_22 = _T_3 ? _cMat_1_0_T_3 : {{16'd0}, cMat_1_0}; // @[src/main/scala/npu/NpuExeTop.scala 47:17 90:36 94:24]
  wire [31:0] _GEN_23 = _T_3 ? _cMat_1_1_T_3 : {{16'd0}, cMat_1_1}; // @[src/main/scala/npu/NpuExeTop.scala 47:17 90:36 94:24]
  wire [31:0] _GEN_24 = _T_3 ? _cMat_1_2_T_3 : {{16'd0}, cMat_1_2}; // @[src/main/scala/npu/NpuExeTop.scala 47:17 90:36 94:24]
  wire [31:0] _GEN_25 = _T_3 ? _cMat_1_3_T_3 : {{16'd0}, cMat_1_3}; // @[src/main/scala/npu/NpuExeTop.scala 47:17 90:36 94:24]
  wire [31:0] _GEN_26 = _T_3 ? _cMat_2_0_T_3 : {{16'd0}, cMat_2_0}; // @[src/main/scala/npu/NpuExeTop.scala 47:17 90:36 94:24]
  wire [31:0] _GEN_27 = _T_3 ? _cMat_2_1_T_3 : {{16'd0}, cMat_2_1}; // @[src/main/scala/npu/NpuExeTop.scala 47:17 90:36 94:24]
  wire [31:0] _GEN_28 = _T_3 ? _cMat_2_2_T_3 : {{16'd0}, cMat_2_2}; // @[src/main/scala/npu/NpuExeTop.scala 47:17 90:36 94:24]
  wire [31:0] _GEN_29 = _T_3 ? _cMat_2_3_T_3 : {{16'd0}, cMat_2_3}; // @[src/main/scala/npu/NpuExeTop.scala 47:17 90:36 94:24]
  wire [31:0] _GEN_30 = _T_3 ? _cMat_3_0_T_3 : {{16'd0}, cMat_3_0}; // @[src/main/scala/npu/NpuExeTop.scala 47:17 90:36 94:24]
  wire [31:0] _GEN_31 = _T_3 ? _cMat_3_1_T_3 : {{16'd0}, cMat_3_1}; // @[src/main/scala/npu/NpuExeTop.scala 47:17 90:36 94:24]
  wire [31:0] _GEN_32 = _T_3 ? _cMat_3_2_T_3 : {{16'd0}, cMat_3_2}; // @[src/main/scala/npu/NpuExeTop.scala 47:17 90:36 94:24]
  wire [31:0] _GEN_33 = _T_3 ? _cMat_3_3_T_3 : {{16'd0}, cMat_3_3}; // @[src/main/scala/npu/NpuExeTop.scala 47:17 90:36 94:24]
  wire [15:0] _GEN_38 = 2'h1 == oCnt[1:0] ? cMat_1_1 : cMat_0_1; // @[src/main/scala/npu/NpuExeTop.scala 113:{40,40}]
  wire [15:0] _GEN_39 = 2'h2 == oCnt[1:0] ? cMat_2_1 : _GEN_38; // @[src/main/scala/npu/NpuExeTop.scala 113:{40,40}]
  wire [15:0] _GEN_40 = 2'h3 == oCnt[1:0] ? cMat_3_1 : _GEN_39; // @[src/main/scala/npu/NpuExeTop.scala 113:{40,40}]
  wire [15:0] _GEN_42 = 2'h1 == oCnt[1:0] ? cMat_1_0 : cMat_0_0; // @[src/main/scala/npu/NpuExeTop.scala 113:{40,40}]
  wire [15:0] _GEN_43 = 2'h2 == oCnt[1:0] ? cMat_2_0 : _GEN_42; // @[src/main/scala/npu/NpuExeTop.scala 113:{40,40}]
  wire [15:0] _GEN_44 = 2'h3 == oCnt[1:0] ? cMat_3_0 : _GEN_43; // @[src/main/scala/npu/NpuExeTop.scala 113:{40,40}]
  wire [15:0] _GEN_46 = 2'h1 == oCnt[1:0] ? cMat_1_3 : cMat_0_3; // @[src/main/scala/npu/NpuExeTop.scala 113:{40,40}]
  wire [15:0] _GEN_47 = 2'h2 == oCnt[1:0] ? cMat_2_3 : _GEN_46; // @[src/main/scala/npu/NpuExeTop.scala 113:{40,40}]
  wire [15:0] _GEN_48 = 2'h3 == oCnt[1:0] ? cMat_3_3 : _GEN_47; // @[src/main/scala/npu/NpuExeTop.scala 113:{40,40}]
  wire [15:0] _GEN_50 = 2'h1 == oCnt[1:0] ? cMat_1_2 : cMat_0_2; // @[src/main/scala/npu/NpuExeTop.scala 113:{40,40}]
  wire [15:0] _GEN_51 = 2'h2 == oCnt[1:0] ? cMat_2_2 : _GEN_50; // @[src/main/scala/npu/NpuExeTop.scala 113:{40,40}]
  wire [15:0] _GEN_52 = 2'h3 == oCnt[1:0] ? cMat_3_2 : _GEN_51; // @[src/main/scala/npu/NpuExeTop.scala 113:{40,40}]
  wire [63:0] _io_d_bits_T_1 = {_GEN_48,_GEN_52,_GEN_40,_GEN_44}; // @[src/main/scala/npu/NpuExeTop.scala 113:40]
  wire [2:0] _oCnt_T_1 = oCnt + 3'h1; // @[src/main/scala/npu/NpuExeTop.scala 118:22]
  wire [1:0] _GEN_53 = oCnt == 3'h3 ? 2'h0 : stateReg; // @[src/main/scala/npu/NpuExeTop.scala 119:37 121:20 43:25]
  wire [1:0] _GEN_55 = io_d_valid ? _GEN_53 : stateReg; // @[src/main/scala/npu/NpuExeTop.scala 116:23 43:25]
  wire [63:0] _GEN_57 = 2'h2 == stateReg ? _io_d_bits_T_1 : 64'h0; // @[src/main/scala/npu/NpuExeTop.scala 113:18 57:14 64:20]
  wire [31:0] _GEN_61 = 2'h1 == stateReg ? _GEN_18 : {{16'd0}, cMat_0_0}; // @[src/main/scala/npu/NpuExeTop.scala 47:17 64:20]
  wire [31:0] _GEN_62 = 2'h1 == stateReg ? _GEN_19 : {{16'd0}, cMat_0_1}; // @[src/main/scala/npu/NpuExeTop.scala 47:17 64:20]
  wire [31:0] _GEN_63 = 2'h1 == stateReg ? _GEN_20 : {{16'd0}, cMat_0_2}; // @[src/main/scala/npu/NpuExeTop.scala 47:17 64:20]
  wire [31:0] _GEN_64 = 2'h1 == stateReg ? _GEN_21 : {{16'd0}, cMat_0_3}; // @[src/main/scala/npu/NpuExeTop.scala 47:17 64:20]
  wire [31:0] _GEN_65 = 2'h1 == stateReg ? _GEN_22 : {{16'd0}, cMat_1_0}; // @[src/main/scala/npu/NpuExeTop.scala 47:17 64:20]
  wire [31:0] _GEN_66 = 2'h1 == stateReg ? _GEN_23 : {{16'd0}, cMat_1_1}; // @[src/main/scala/npu/NpuExeTop.scala 47:17 64:20]
  wire [31:0] _GEN_67 = 2'h1 == stateReg ? _GEN_24 : {{16'd0}, cMat_1_2}; // @[src/main/scala/npu/NpuExeTop.scala 47:17 64:20]
  wire [31:0] _GEN_68 = 2'h1 == stateReg ? _GEN_25 : {{16'd0}, cMat_1_3}; // @[src/main/scala/npu/NpuExeTop.scala 47:17 64:20]
  wire [31:0] _GEN_69 = 2'h1 == stateReg ? _GEN_26 : {{16'd0}, cMat_2_0}; // @[src/main/scala/npu/NpuExeTop.scala 47:17 64:20]
  wire [31:0] _GEN_70 = 2'h1 == stateReg ? _GEN_27 : {{16'd0}, cMat_2_1}; // @[src/main/scala/npu/NpuExeTop.scala 47:17 64:20]
  wire [31:0] _GEN_71 = 2'h1 == stateReg ? _GEN_28 : {{16'd0}, cMat_2_2}; // @[src/main/scala/npu/NpuExeTop.scala 47:17 64:20]
  wire [31:0] _GEN_72 = 2'h1 == stateReg ? _GEN_29 : {{16'd0}, cMat_2_3}; // @[src/main/scala/npu/NpuExeTop.scala 47:17 64:20]
  wire [31:0] _GEN_73 = 2'h1 == stateReg ? _GEN_30 : {{16'd0}, cMat_3_0}; // @[src/main/scala/npu/NpuExeTop.scala 47:17 64:20]
  wire [31:0] _GEN_74 = 2'h1 == stateReg ? _GEN_31 : {{16'd0}, cMat_3_1}; // @[src/main/scala/npu/NpuExeTop.scala 47:17 64:20]
  wire [31:0] _GEN_75 = 2'h1 == stateReg ? _GEN_32 : {{16'd0}, cMat_3_2}; // @[src/main/scala/npu/NpuExeTop.scala 47:17 64:20]
  wire [31:0] _GEN_76 = 2'h1 == stateReg ? _GEN_33 : {{16'd0}, cMat_3_3}; // @[src/main/scala/npu/NpuExeTop.scala 47:17 64:20]
  wire  _GEN_80 = 2'h1 == stateReg ? 1'h0 : 2'h2 == stateReg; // @[src/main/scala/npu/NpuExeTop.scala 56:14 64:20]
  wire [63:0] _GEN_81 = 2'h1 == stateReg ? 64'h0 : _GEN_57; // @[src/main/scala/npu/NpuExeTop.scala 57:14 64:20]
  wire [31:0] _GEN_84 = 2'h0 == stateReg ? _GEN_1 : _GEN_61; // @[src/main/scala/npu/NpuExeTop.scala 64:20]
  wire [31:0] _GEN_85 = 2'h0 == stateReg ? _GEN_2 : _GEN_62; // @[src/main/scala/npu/NpuExeTop.scala 64:20]
  wire [31:0] _GEN_86 = 2'h0 == stateReg ? _GEN_3 : _GEN_63; // @[src/main/scala/npu/NpuExeTop.scala 64:20]
  wire [31:0] _GEN_87 = 2'h0 == stateReg ? _GEN_4 : _GEN_64; // @[src/main/scala/npu/NpuExeTop.scala 64:20]
  wire [31:0] _GEN_88 = 2'h0 == stateReg ? _GEN_5 : _GEN_65; // @[src/main/scala/npu/NpuExeTop.scala 64:20]
  wire [31:0] _GEN_89 = 2'h0 == stateReg ? _GEN_6 : _GEN_66; // @[src/main/scala/npu/NpuExeTop.scala 64:20]
  wire [31:0] _GEN_90 = 2'h0 == stateReg ? _GEN_7 : _GEN_67; // @[src/main/scala/npu/NpuExeTop.scala 64:20]
  wire [31:0] _GEN_91 = 2'h0 == stateReg ? _GEN_8 : _GEN_68; // @[src/main/scala/npu/NpuExeTop.scala 64:20]
  wire [31:0] _GEN_92 = 2'h0 == stateReg ? _GEN_9 : _GEN_69; // @[src/main/scala/npu/NpuExeTop.scala 64:20]
  wire [31:0] _GEN_93 = 2'h0 == stateReg ? _GEN_10 : _GEN_70; // @[src/main/scala/npu/NpuExeTop.scala 64:20]
  wire [31:0] _GEN_94 = 2'h0 == stateReg ? _GEN_11 : _GEN_71; // @[src/main/scala/npu/NpuExeTop.scala 64:20]
  wire [31:0] _GEN_95 = 2'h0 == stateReg ? _GEN_12 : _GEN_72; // @[src/main/scala/npu/NpuExeTop.scala 64:20]
  wire [31:0] _GEN_96 = 2'h0 == stateReg ? _GEN_13 : _GEN_73; // @[src/main/scala/npu/NpuExeTop.scala 64:20]
  wire [31:0] _GEN_97 = 2'h0 == stateReg ? _GEN_14 : _GEN_74; // @[src/main/scala/npu/NpuExeTop.scala 64:20]
  wire [31:0] _GEN_98 = 2'h0 == stateReg ? _GEN_15 : _GEN_75; // @[src/main/scala/npu/NpuExeTop.scala 64:20]
  wire [31:0] _GEN_99 = 2'h0 == stateReg ? _GEN_16 : _GEN_76; // @[src/main/scala/npu/NpuExeTop.scala 64:20]
  assign io_a_ready = 2'h0 == stateReg | 2'h1 == stateReg; // @[src/main/scala/npu/NpuExeTop.scala 64:20 67:18]
  assign io_b_ready = 2'h0 == stateReg | 2'h1 == stateReg; // @[src/main/scala/npu/NpuExeTop.scala 64:20 67:18]
  assign io_d_valid = 2'h0 == stateReg ? 1'h0 : _GEN_80; // @[src/main/scala/npu/NpuExeTop.scala 56:14 64:20]
  assign io_d_bits = 2'h0 == stateReg ? 64'h0 : _GEN_81; // @[src/main/scala/npu/NpuExeTop.scala 57:14 64:20]
  always @(posedge clock) begin
    if (reset) begin // @[src/main/scala/npu/NpuExeTop.scala 43:25]
      stateReg <= 2'h0; // @[src/main/scala/npu/NpuExeTop.scala 43:25]
    end else if (2'h0 == stateReg) begin // @[src/main/scala/npu/NpuExeTop.scala 64:20]
      if (_T_1 & _T_2) begin // @[src/main/scala/npu/NpuExeTop.scala 70:36]
        stateReg <= 2'h1; // @[src/main/scala/npu/NpuExeTop.scala 72:18]
      end
    end else if (2'h1 == stateReg) begin // @[src/main/scala/npu/NpuExeTop.scala 64:20]
      if (kCnt == 3'h4) begin // @[src/main/scala/npu/NpuExeTop.scala 103:30]
        stateReg <= 2'h2; // @[src/main/scala/npu/NpuExeTop.scala 105:18]
      end
    end else if (2'h2 == stateReg) begin // @[src/main/scala/npu/NpuExeTop.scala 64:20]
      stateReg <= _GEN_55;
    end
    cMat_0_0 <= _GEN_84[15:0];
    cMat_0_1 <= _GEN_85[15:0];
    cMat_0_2 <= _GEN_86[15:0];
    cMat_0_3 <= _GEN_87[15:0];
    cMat_1_0 <= _GEN_88[15:0];
    cMat_1_1 <= _GEN_89[15:0];
    cMat_1_2 <= _GEN_90[15:0];
    cMat_1_3 <= _GEN_91[15:0];
    cMat_2_0 <= _GEN_92[15:0];
    cMat_2_1 <= _GEN_93[15:0];
    cMat_2_2 <= _GEN_94[15:0];
    cMat_2_3 <= _GEN_95[15:0];
    cMat_3_0 <= _GEN_96[15:0];
    cMat_3_1 <= _GEN_97[15:0];
    cMat_3_2 <= _GEN_98[15:0];
    cMat_3_3 <= _GEN_99[15:0];
    if (2'h0 == stateReg) begin // @[src/main/scala/npu/NpuExeTop.scala 64:20]
      if (_T_1 & _T_2) begin // @[src/main/scala/npu/NpuExeTop.scala 70:36]
        kCnt <= 3'h1; // @[src/main/scala/npu/NpuExeTop.scala 81:14]
      end
    end else if (2'h1 == stateReg) begin // @[src/main/scala/npu/NpuExeTop.scala 64:20]
      if (_T_3) begin // @[src/main/scala/npu/NpuExeTop.scala 90:36]
        kCnt <= _kCnt_T_1; // @[src/main/scala/npu/NpuExeTop.scala 100:14]
      end
    end
    if (!(2'h0 == stateReg)) begin // @[src/main/scala/npu/NpuExeTop.scala 64:20]
      if (2'h1 == stateReg) begin // @[src/main/scala/npu/NpuExeTop.scala 64:20]
        if (kCnt == 3'h4) begin // @[src/main/scala/npu/NpuExeTop.scala 103:30]
          oCnt <= 3'h0; // @[src/main/scala/npu/NpuExeTop.scala 106:14]
        end
      end else if (2'h2 == stateReg) begin // @[src/main/scala/npu/NpuExeTop.scala 64:20]
        if (io_d_valid) begin // @[src/main/scala/npu/NpuExeTop.scala 116:23]
          oCnt <= _oCnt_T_1; // @[src/main/scala/npu/NpuExeTop.scala 118:14]
        end
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  stateReg = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  cMat_0_0 = _RAND_1[15:0];
  _RAND_2 = {1{`RANDOM}};
  cMat_0_1 = _RAND_2[15:0];
  _RAND_3 = {1{`RANDOM}};
  cMat_0_2 = _RAND_3[15:0];
  _RAND_4 = {1{`RANDOM}};
  cMat_0_3 = _RAND_4[15:0];
  _RAND_5 = {1{`RANDOM}};
  cMat_1_0 = _RAND_5[15:0];
  _RAND_6 = {1{`RANDOM}};
  cMat_1_1 = _RAND_6[15:0];
  _RAND_7 = {1{`RANDOM}};
  cMat_1_2 = _RAND_7[15:0];
  _RAND_8 = {1{`RANDOM}};
  cMat_1_3 = _RAND_8[15:0];
  _RAND_9 = {1{`RANDOM}};
  cMat_2_0 = _RAND_9[15:0];
  _RAND_10 = {1{`RANDOM}};
  cMat_2_1 = _RAND_10[15:0];
  _RAND_11 = {1{`RANDOM}};
  cMat_2_2 = _RAND_11[15:0];
  _RAND_12 = {1{`RANDOM}};
  cMat_2_3 = _RAND_12[15:0];
  _RAND_13 = {1{`RANDOM}};
  cMat_3_0 = _RAND_13[15:0];
  _RAND_14 = {1{`RANDOM}};
  cMat_3_1 = _RAND_14[15:0];
  _RAND_15 = {1{`RANDOM}};
  cMat_3_2 = _RAND_15[15:0];
  _RAND_16 = {1{`RANDOM}};
  cMat_3_3 = _RAND_16[15:0];
  _RAND_17 = {1{`RANDOM}};
  kCnt = _RAND_17[2:0];
  _RAND_18 = {1{`RANDOM}};
  oCnt = _RAND_18[2:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module NpuExeTop(
  input         clock,
  input         reset,
  output        io_cmd_ready, // @[src/main/scala/npu/NpuExeTop.scala 174:14]
  input         io_cmd_valid, // @[src/main/scala/npu/NpuExeTop.scala 174:14]
  input  [15:0] io_cmd_bits_aBase, // @[src/main/scala/npu/NpuExeTop.scala 174:14]
  input  [15:0] io_cmd_bits_bBase, // @[src/main/scala/npu/NpuExeTop.scala 174:14]
  input  [15:0] io_cmd_bits_cBase, // @[src/main/scala/npu/NpuExeTop.scala 174:14]
  input         io_cmd_bits_start, // @[src/main/scala/npu/NpuExeTop.scala 174:14]
  output        io_done, // @[src/main/scala/npu/NpuExeTop.scala 174:14]
  input         io_init_en, // @[src/main/scala/npu/NpuExeTop.scala 174:14]
  input  [1:0]  io_init_bank, // @[src/main/scala/npu/NpuExeTop.scala 174:14]
  input  [7:0]  io_init_addr, // @[src/main/scala/npu/NpuExeTop.scala 174:14]
  input  [63:0] io_init_data, // @[src/main/scala/npu/NpuExeTop.scala 174:14]
  input  [1:0]  io_peek_bank, // @[src/main/scala/npu/NpuExeTop.scala 174:14]
  input  [7:0]  io_peek_addr, // @[src/main/scala/npu/NpuExeTop.scala 174:14]
  output [63:0] io_peek_data // @[src/main/scala/npu/NpuExeTop.scala 174:14]
);
`ifdef RANDOMIZE_MEM_INIT
  reg [63:0] _RAND_0;
  reg [63:0] _RAND_5;
  reg [63:0] _RAND_10;
  reg [63:0] _RAND_15;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [63:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [63:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [63:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [63:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
`endif // RANDOMIZE_REG_INIT
  wire  dut_clock; // @[src/main/scala/npu/NpuExeTop.scala 140:20]
  wire  dut_reset; // @[src/main/scala/npu/NpuExeTop.scala 140:20]
  wire  dut_io_cmd_ready; // @[src/main/scala/npu/NpuExeTop.scala 140:20]
  wire  dut_io_cmd_valid; // @[src/main/scala/npu/NpuExeTop.scala 140:20]
  wire [15:0] dut_io_cmd_bits_aBase; // @[src/main/scala/npu/NpuExeTop.scala 140:20]
  wire [15:0] dut_io_cmd_bits_bBase; // @[src/main/scala/npu/NpuExeTop.scala 140:20]
  wire [15:0] dut_io_cmd_bits_cBase; // @[src/main/scala/npu/NpuExeTop.scala 140:20]
  wire  dut_io_cmd_bits_start; // @[src/main/scala/npu/NpuExeTop.scala 140:20]
  wire  dut_io_spR_0_req_ready; // @[src/main/scala/npu/NpuExeTop.scala 140:20]
  wire  dut_io_spR_0_req_valid; // @[src/main/scala/npu/NpuExeTop.scala 140:20]
  wire [7:0] dut_io_spR_0_req_bits; // @[src/main/scala/npu/NpuExeTop.scala 140:20]
  wire  dut_io_spR_0_resp_valid; // @[src/main/scala/npu/NpuExeTop.scala 140:20]
  wire [63:0] dut_io_spR_0_resp_bits; // @[src/main/scala/npu/NpuExeTop.scala 140:20]
  wire  dut_io_spR_1_req_ready; // @[src/main/scala/npu/NpuExeTop.scala 140:20]
  wire  dut_io_spR_1_req_valid; // @[src/main/scala/npu/NpuExeTop.scala 140:20]
  wire [7:0] dut_io_spR_1_req_bits; // @[src/main/scala/npu/NpuExeTop.scala 140:20]
  wire  dut_io_spR_1_resp_valid; // @[src/main/scala/npu/NpuExeTop.scala 140:20]
  wire [63:0] dut_io_spR_1_resp_bits; // @[src/main/scala/npu/NpuExeTop.scala 140:20]
  wire  dut_io_spR_2_req_ready; // @[src/main/scala/npu/NpuExeTop.scala 140:20]
  wire  dut_io_spR_2_req_valid; // @[src/main/scala/npu/NpuExeTop.scala 140:20]
  wire [7:0] dut_io_spR_2_req_bits; // @[src/main/scala/npu/NpuExeTop.scala 140:20]
  wire  dut_io_spR_2_resp_valid; // @[src/main/scala/npu/NpuExeTop.scala 140:20]
  wire [63:0] dut_io_spR_2_resp_bits; // @[src/main/scala/npu/NpuExeTop.scala 140:20]
  wire  dut_io_spR_3_req_ready; // @[src/main/scala/npu/NpuExeTop.scala 140:20]
  wire  dut_io_spR_3_req_valid; // @[src/main/scala/npu/NpuExeTop.scala 140:20]
  wire [7:0] dut_io_spR_3_req_bits; // @[src/main/scala/npu/NpuExeTop.scala 140:20]
  wire  dut_io_spR_3_resp_valid; // @[src/main/scala/npu/NpuExeTop.scala 140:20]
  wire [63:0] dut_io_spR_3_resp_bits; // @[src/main/scala/npu/NpuExeTop.scala 140:20]
  wire  dut_io_spW_0_en; // @[src/main/scala/npu/NpuExeTop.scala 140:20]
  wire [7:0] dut_io_spW_0_addr; // @[src/main/scala/npu/NpuExeTop.scala 140:20]
  wire [63:0] dut_io_spW_0_data; // @[src/main/scala/npu/NpuExeTop.scala 140:20]
  wire  dut_io_spW_1_en; // @[src/main/scala/npu/NpuExeTop.scala 140:20]
  wire [7:0] dut_io_spW_1_addr; // @[src/main/scala/npu/NpuExeTop.scala 140:20]
  wire [63:0] dut_io_spW_1_data; // @[src/main/scala/npu/NpuExeTop.scala 140:20]
  wire  dut_io_spW_2_en; // @[src/main/scala/npu/NpuExeTop.scala 140:20]
  wire [7:0] dut_io_spW_2_addr; // @[src/main/scala/npu/NpuExeTop.scala 140:20]
  wire [63:0] dut_io_spW_2_data; // @[src/main/scala/npu/NpuExeTop.scala 140:20]
  wire  dut_io_spW_3_en; // @[src/main/scala/npu/NpuExeTop.scala 140:20]
  wire [7:0] dut_io_spW_3_addr; // @[src/main/scala/npu/NpuExeTop.scala 140:20]
  wire [63:0] dut_io_spW_3_data; // @[src/main/scala/npu/NpuExeTop.scala 140:20]
  wire  dut_io_mesh_a_ready; // @[src/main/scala/npu/NpuExeTop.scala 140:20]
  wire  dut_io_mesh_a_valid; // @[src/main/scala/npu/NpuExeTop.scala 140:20]
  wire [63:0] dut_io_mesh_a_bits; // @[src/main/scala/npu/NpuExeTop.scala 140:20]
  wire  dut_io_mesh_b_ready; // @[src/main/scala/npu/NpuExeTop.scala 140:20]
  wire  dut_io_mesh_b_valid; // @[src/main/scala/npu/NpuExeTop.scala 140:20]
  wire [63:0] dut_io_mesh_b_bits; // @[src/main/scala/npu/NpuExeTop.scala 140:20]
  wire  dut_io_mesh_d_valid; // @[src/main/scala/npu/NpuExeTop.scala 140:20]
  wire [63:0] dut_io_mesh_d_bits; // @[src/main/scala/npu/NpuExeTop.scala 140:20]
  wire  dut_io_done; // @[src/main/scala/npu/NpuExeTop.scala 140:20]
  wire  mesh_clock; // @[src/main/scala/npu/NpuExeTop.scala 142:20]
  wire  mesh_reset; // @[src/main/scala/npu/NpuExeTop.scala 142:20]
  wire  mesh_io_a_ready; // @[src/main/scala/npu/NpuExeTop.scala 142:20]
  wire  mesh_io_a_valid; // @[src/main/scala/npu/NpuExeTop.scala 142:20]
  wire [63:0] mesh_io_a_bits; // @[src/main/scala/npu/NpuExeTop.scala 142:20]
  wire  mesh_io_b_ready; // @[src/main/scala/npu/NpuExeTop.scala 142:20]
  wire  mesh_io_b_valid; // @[src/main/scala/npu/NpuExeTop.scala 142:20]
  wire [63:0] mesh_io_b_bits; // @[src/main/scala/npu/NpuExeTop.scala 142:20]
  wire  mesh_io_d_valid; // @[src/main/scala/npu/NpuExeTop.scala 142:20]
  wire [63:0] mesh_io_d_bits; // @[src/main/scala/npu/NpuExeTop.scala 142:20]
  reg [63:0] mem [0:255]; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  wire  mem_rdData_en; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  wire [7:0] mem_rdData_addr; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  wire [63:0] mem_rdData_data; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  wire  mem_rdat_en; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  wire [7:0] mem_rdat_addr; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  wire [63:0] mem_rdat_data; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  wire [63:0] mem_MPORT_data; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  wire [7:0] mem_MPORT_addr; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  wire  mem_MPORT_mask; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  wire  mem_MPORT_en; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  wire [63:0] mem_MPORT_4_data; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  wire [7:0] mem_MPORT_4_addr; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  wire  mem_MPORT_4_mask; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  wire  mem_MPORT_4_en; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  reg  mem_rdData_en_pipe_0;
  reg [7:0] mem_rdData_addr_pipe_0;
  reg  mem_rdat_en_pipe_0;
  reg [7:0] mem_rdat_addr_pipe_0;
  reg [63:0] mem_1 [0:255]; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  wire  mem_1_rdData_1_en; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  wire [7:0] mem_1_rdData_1_addr; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  wire [63:0] mem_1_rdData_1_data; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  wire  mem_1_rdat_1_en; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  wire [7:0] mem_1_rdat_1_addr; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  wire [63:0] mem_1_rdat_1_data; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  wire [63:0] mem_1_MPORT_1_data; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  wire [7:0] mem_1_MPORT_1_addr; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  wire  mem_1_MPORT_1_mask; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  wire  mem_1_MPORT_1_en; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  wire [63:0] mem_1_MPORT_5_data; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  wire [7:0] mem_1_MPORT_5_addr; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  wire  mem_1_MPORT_5_mask; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  wire  mem_1_MPORT_5_en; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  reg  mem_1_rdData_1_en_pipe_0;
  reg [7:0] mem_1_rdData_1_addr_pipe_0;
  reg  mem_1_rdat_1_en_pipe_0;
  reg [7:0] mem_1_rdat_1_addr_pipe_0;
  reg [63:0] mem_2 [0:255]; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  wire  mem_2_rdData_2_en; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  wire [7:0] mem_2_rdData_2_addr; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  wire [63:0] mem_2_rdData_2_data; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  wire  mem_2_rdat_2_en; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  wire [7:0] mem_2_rdat_2_addr; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  wire [63:0] mem_2_rdat_2_data; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  wire [63:0] mem_2_MPORT_2_data; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  wire [7:0] mem_2_MPORT_2_addr; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  wire  mem_2_MPORT_2_mask; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  wire  mem_2_MPORT_2_en; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  wire [63:0] mem_2_MPORT_6_data; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  wire [7:0] mem_2_MPORT_6_addr; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  wire  mem_2_MPORT_6_mask; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  wire  mem_2_MPORT_6_en; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  reg  mem_2_rdData_2_en_pipe_0;
  reg [7:0] mem_2_rdData_2_addr_pipe_0;
  reg  mem_2_rdat_2_en_pipe_0;
  reg [7:0] mem_2_rdat_2_addr_pipe_0;
  reg [63:0] mem_3 [0:255]; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  wire  mem_3_rdData_3_en; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  wire [7:0] mem_3_rdData_3_addr; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  wire [63:0] mem_3_rdData_3_data; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  wire  mem_3_rdat_3_en; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  wire [7:0] mem_3_rdat_3_addr; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  wire [63:0] mem_3_rdat_3_data; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  wire [63:0] mem_3_MPORT_3_data; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  wire [7:0] mem_3_MPORT_3_addr; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  wire  mem_3_MPORT_3_mask; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  wire  mem_3_MPORT_3_en; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  wire [63:0] mem_3_MPORT_7_data; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  wire [7:0] mem_3_MPORT_7_addr; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  wire  mem_3_MPORT_7_mask; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  wire  mem_3_MPORT_7_en; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  reg  mem_3_rdData_3_en_pipe_0;
  reg [7:0] mem_3_rdData_3_addr_pipe_0;
  reg  mem_3_rdat_3_en_pipe_0;
  reg [7:0] mem_3_rdat_3_addr_pipe_0;
  reg  respReg_valid; // @[src/main/scala/npu/NpuExeTop.scala 147:26]
  reg [63:0] respReg_bits; // @[src/main/scala/npu/NpuExeTop.scala 147:26]
  reg  respReg_1_valid; // @[src/main/scala/npu/NpuExeTop.scala 147:26]
  reg [63:0] respReg_1_bits; // @[src/main/scala/npu/NpuExeTop.scala 147:26]
  reg  respReg_2_valid; // @[src/main/scala/npu/NpuExeTop.scala 147:26]
  reg [63:0] respReg_2_bits; // @[src/main/scala/npu/NpuExeTop.scala 147:26]
  reg  respReg_3_valid; // @[src/main/scala/npu/NpuExeTop.scala 147:26]
  reg [63:0] respReg_3_bits; // @[src/main/scala/npu/NpuExeTop.scala 147:26]
  wire  doRead = dut_io_spR_0_req_ready & dut_io_spR_0_req_valid; // @[src/main/scala/chisel3/util/Decoupled.scala 57:35]
  reg  respReg_valid_REG; // @[src/main/scala/npu/NpuExeTop.scala 158:31]
  wire  doRead_1 = dut_io_spR_1_req_ready & dut_io_spR_1_req_valid; // @[src/main/scala/chisel3/util/Decoupled.scala 57:35]
  reg  respReg_valid_REG_1; // @[src/main/scala/npu/NpuExeTop.scala 158:31]
  wire  doRead_2 = dut_io_spR_2_req_ready & dut_io_spR_2_req_valid; // @[src/main/scala/chisel3/util/Decoupled.scala 57:35]
  reg  respReg_valid_REG_2; // @[src/main/scala/npu/NpuExeTop.scala 158:31]
  wire  doRead_3 = dut_io_spR_3_req_ready & dut_io_spR_3_req_valid; // @[src/main/scala/chisel3/util/Decoupled.scala 57:35]
  reg  respReg_valid_REG_3; // @[src/main/scala/npu/NpuExeTop.scala 158:31]
  wire  _T = io_init_bank == 2'h0; // @[src/main/scala/npu/NpuExeTop.scala 200:25]
  wire  _T_1 = io_init_bank == 2'h1; // @[src/main/scala/npu/NpuExeTop.scala 200:25]
  wire  _T_2 = io_init_bank == 2'h2; // @[src/main/scala/npu/NpuExeTop.scala 200:25]
  wire  _T_3 = io_init_bank == 2'h3; // @[src/main/scala/npu/NpuExeTop.scala 200:25]
  wire [63:0] peekDatas_0 = mem_rdat_data; // @[src/main/scala/npu/NpuExeTop.scala 220:23 224:20]
  wire [63:0] peekDatas_1 = mem_1_rdat_1_data; // @[src/main/scala/npu/NpuExeTop.scala 220:23 224:20]
  wire [63:0] _GEN_93 = 2'h1 == io_peek_bank ? peekDatas_1 : peekDatas_0; // @[src/main/scala/npu/NpuExeTop.scala 226:{16,16}]
  wire [63:0] peekDatas_2 = mem_2_rdat_2_data; // @[src/main/scala/npu/NpuExeTop.scala 220:23 224:20]
  wire [63:0] _GEN_94 = 2'h2 == io_peek_bank ? peekDatas_2 : _GEN_93; // @[src/main/scala/npu/NpuExeTop.scala 226:{16,16}]
  wire [63:0] peekDatas_3 = mem_3_rdat_3_data; // @[src/main/scala/npu/NpuExeTop.scala 220:23 224:20]
  NpuExecuteController dut ( // @[src/main/scala/npu/NpuExeTop.scala 140:20]
    .clock(dut_clock),
    .reset(dut_reset),
    .io_cmd_ready(dut_io_cmd_ready),
    .io_cmd_valid(dut_io_cmd_valid),
    .io_cmd_bits_aBase(dut_io_cmd_bits_aBase),
    .io_cmd_bits_bBase(dut_io_cmd_bits_bBase),
    .io_cmd_bits_cBase(dut_io_cmd_bits_cBase),
    .io_cmd_bits_start(dut_io_cmd_bits_start),
    .io_spR_0_req_ready(dut_io_spR_0_req_ready),
    .io_spR_0_req_valid(dut_io_spR_0_req_valid),
    .io_spR_0_req_bits(dut_io_spR_0_req_bits),
    .io_spR_0_resp_valid(dut_io_spR_0_resp_valid),
    .io_spR_0_resp_bits(dut_io_spR_0_resp_bits),
    .io_spR_1_req_ready(dut_io_spR_1_req_ready),
    .io_spR_1_req_valid(dut_io_spR_1_req_valid),
    .io_spR_1_req_bits(dut_io_spR_1_req_bits),
    .io_spR_1_resp_valid(dut_io_spR_1_resp_valid),
    .io_spR_1_resp_bits(dut_io_spR_1_resp_bits),
    .io_spR_2_req_ready(dut_io_spR_2_req_ready),
    .io_spR_2_req_valid(dut_io_spR_2_req_valid),
    .io_spR_2_req_bits(dut_io_spR_2_req_bits),
    .io_spR_2_resp_valid(dut_io_spR_2_resp_valid),
    .io_spR_2_resp_bits(dut_io_spR_2_resp_bits),
    .io_spR_3_req_ready(dut_io_spR_3_req_ready),
    .io_spR_3_req_valid(dut_io_spR_3_req_valid),
    .io_spR_3_req_bits(dut_io_spR_3_req_bits),
    .io_spR_3_resp_valid(dut_io_spR_3_resp_valid),
    .io_spR_3_resp_bits(dut_io_spR_3_resp_bits),
    .io_spW_0_en(dut_io_spW_0_en),
    .io_spW_0_addr(dut_io_spW_0_addr),
    .io_spW_0_data(dut_io_spW_0_data),
    .io_spW_1_en(dut_io_spW_1_en),
    .io_spW_1_addr(dut_io_spW_1_addr),
    .io_spW_1_data(dut_io_spW_1_data),
    .io_spW_2_en(dut_io_spW_2_en),
    .io_spW_2_addr(dut_io_spW_2_addr),
    .io_spW_2_data(dut_io_spW_2_data),
    .io_spW_3_en(dut_io_spW_3_en),
    .io_spW_3_addr(dut_io_spW_3_addr),
    .io_spW_3_data(dut_io_spW_3_data),
    .io_mesh_a_ready(dut_io_mesh_a_ready),
    .io_mesh_a_valid(dut_io_mesh_a_valid),
    .io_mesh_a_bits(dut_io_mesh_a_bits),
    .io_mesh_b_ready(dut_io_mesh_b_ready),
    .io_mesh_b_valid(dut_io_mesh_b_valid),
    .io_mesh_b_bits(dut_io_mesh_b_bits),
    .io_mesh_d_valid(dut_io_mesh_d_valid),
    .io_mesh_d_bits(dut_io_mesh_d_bits),
    .io_done(dut_io_done)
  );
  DummyMesh mesh ( // @[src/main/scala/npu/NpuExeTop.scala 142:20]
    .clock(mesh_clock),
    .reset(mesh_reset),
    .io_a_ready(mesh_io_a_ready),
    .io_a_valid(mesh_io_a_valid),
    .io_a_bits(mesh_io_a_bits),
    .io_b_ready(mesh_io_b_ready),
    .io_b_valid(mesh_io_b_valid),
    .io_b_bits(mesh_io_b_bits),
    .io_d_valid(mesh_io_d_valid),
    .io_d_bits(mesh_io_d_bits)
  );
  assign mem_rdData_en = mem_rdData_en_pipe_0;
  assign mem_rdData_addr = mem_rdData_addr_pipe_0;
  assign mem_rdData_data = mem[mem_rdData_addr]; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  assign mem_rdat_en = mem_rdat_en_pipe_0;
  assign mem_rdat_addr = mem_rdat_addr_pipe_0;
  assign mem_rdat_data = mem[mem_rdat_addr]; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  assign mem_MPORT_data = dut_io_spW_0_data;
  assign mem_MPORT_addr = dut_io_spW_0_addr;
  assign mem_MPORT_mask = 1'h1;
  assign mem_MPORT_en = dut_io_spW_0_en;
  assign mem_MPORT_4_data = io_init_data;
  assign mem_MPORT_4_addr = io_init_addr;
  assign mem_MPORT_4_mask = 1'h1;
  assign mem_MPORT_4_en = io_init_en & _T;
  assign mem_1_rdData_1_en = mem_1_rdData_1_en_pipe_0;
  assign mem_1_rdData_1_addr = mem_1_rdData_1_addr_pipe_0;
  assign mem_1_rdData_1_data = mem_1[mem_1_rdData_1_addr]; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  assign mem_1_rdat_1_en = mem_1_rdat_1_en_pipe_0;
  assign mem_1_rdat_1_addr = mem_1_rdat_1_addr_pipe_0;
  assign mem_1_rdat_1_data = mem_1[mem_1_rdat_1_addr]; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  assign mem_1_MPORT_1_data = dut_io_spW_1_data;
  assign mem_1_MPORT_1_addr = dut_io_spW_1_addr;
  assign mem_1_MPORT_1_mask = 1'h1;
  assign mem_1_MPORT_1_en = dut_io_spW_1_en;
  assign mem_1_MPORT_5_data = io_init_data;
  assign mem_1_MPORT_5_addr = io_init_addr;
  assign mem_1_MPORT_5_mask = 1'h1;
  assign mem_1_MPORT_5_en = io_init_en & _T_1;
  assign mem_2_rdData_2_en = mem_2_rdData_2_en_pipe_0;
  assign mem_2_rdData_2_addr = mem_2_rdData_2_addr_pipe_0;
  assign mem_2_rdData_2_data = mem_2[mem_2_rdData_2_addr]; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  assign mem_2_rdat_2_en = mem_2_rdat_2_en_pipe_0;
  assign mem_2_rdat_2_addr = mem_2_rdat_2_addr_pipe_0;
  assign mem_2_rdat_2_data = mem_2[mem_2_rdat_2_addr]; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  assign mem_2_MPORT_2_data = dut_io_spW_2_data;
  assign mem_2_MPORT_2_addr = dut_io_spW_2_addr;
  assign mem_2_MPORT_2_mask = 1'h1;
  assign mem_2_MPORT_2_en = dut_io_spW_2_en;
  assign mem_2_MPORT_6_data = io_init_data;
  assign mem_2_MPORT_6_addr = io_init_addr;
  assign mem_2_MPORT_6_mask = 1'h1;
  assign mem_2_MPORT_6_en = io_init_en & _T_2;
  assign mem_3_rdData_3_en = mem_3_rdData_3_en_pipe_0;
  assign mem_3_rdData_3_addr = mem_3_rdData_3_addr_pipe_0;
  assign mem_3_rdData_3_data = mem_3[mem_3_rdData_3_addr]; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  assign mem_3_rdat_3_en = mem_3_rdat_3_en_pipe_0;
  assign mem_3_rdat_3_addr = mem_3_rdat_3_addr_pipe_0;
  assign mem_3_rdat_3_data = mem_3[mem_3_rdat_3_addr]; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
  assign mem_3_MPORT_3_data = dut_io_spW_3_data;
  assign mem_3_MPORT_3_addr = dut_io_spW_3_addr;
  assign mem_3_MPORT_3_mask = 1'h1;
  assign mem_3_MPORT_3_en = dut_io_spW_3_en;
  assign mem_3_MPORT_7_data = io_init_data;
  assign mem_3_MPORT_7_addr = io_init_addr;
  assign mem_3_MPORT_7_mask = 1'h1;
  assign mem_3_MPORT_7_en = io_init_en & _T_3;
  assign io_cmd_ready = dut_io_cmd_ready; // @[src/main/scala/npu/NpuExeTop.scala 193:14]
  assign io_done = dut_io_done; // @[src/main/scala/npu/NpuExeTop.scala 194:14]
  assign io_peek_data = 2'h3 == io_peek_bank ? peekDatas_3 : _GEN_94; // @[src/main/scala/npu/NpuExeTop.scala 226:{16,16}]
  assign dut_clock = clock;
  assign dut_reset = reset;
  assign dut_io_cmd_valid = io_cmd_valid; // @[src/main/scala/npu/NpuExeTop.scala 193:14]
  assign dut_io_cmd_bits_aBase = io_cmd_bits_aBase; // @[src/main/scala/npu/NpuExeTop.scala 193:14]
  assign dut_io_cmd_bits_bBase = io_cmd_bits_bBase; // @[src/main/scala/npu/NpuExeTop.scala 193:14]
  assign dut_io_cmd_bits_cBase = io_cmd_bits_cBase; // @[src/main/scala/npu/NpuExeTop.scala 193:14]
  assign dut_io_cmd_bits_start = io_cmd_bits_start; // @[src/main/scala/npu/NpuExeTop.scala 193:14]
  assign dut_io_spR_0_req_ready = 1'h1; // @[src/main/scala/npu/NpuExeTop.scala 154:18]
  assign dut_io_spR_0_resp_valid = respReg_valid; // @[src/main/scala/npu/NpuExeTop.scala 161:13]
  assign dut_io_spR_0_resp_bits = respReg_bits; // @[src/main/scala/npu/NpuExeTop.scala 161:13]
  assign dut_io_spR_1_req_ready = 1'h1; // @[src/main/scala/npu/NpuExeTop.scala 154:18]
  assign dut_io_spR_1_resp_valid = respReg_1_valid; // @[src/main/scala/npu/NpuExeTop.scala 161:13]
  assign dut_io_spR_1_resp_bits = respReg_1_bits; // @[src/main/scala/npu/NpuExeTop.scala 161:13]
  assign dut_io_spR_2_req_ready = 1'h1; // @[src/main/scala/npu/NpuExeTop.scala 154:18]
  assign dut_io_spR_2_resp_valid = respReg_2_valid; // @[src/main/scala/npu/NpuExeTop.scala 161:13]
  assign dut_io_spR_2_resp_bits = respReg_2_bits; // @[src/main/scala/npu/NpuExeTop.scala 161:13]
  assign dut_io_spR_3_req_ready = 1'h1; // @[src/main/scala/npu/NpuExeTop.scala 154:18]
  assign dut_io_spR_3_resp_valid = respReg_3_valid; // @[src/main/scala/npu/NpuExeTop.scala 161:13]
  assign dut_io_spR_3_resp_bits = respReg_3_bits; // @[src/main/scala/npu/NpuExeTop.scala 161:13]
  assign dut_io_mesh_a_ready = mesh_io_a_ready; // @[src/main/scala/npu/NpuExeTop.scala 171:15]
  assign dut_io_mesh_b_ready = mesh_io_b_ready; // @[src/main/scala/npu/NpuExeTop.scala 171:15]
  assign dut_io_mesh_d_valid = mesh_io_d_valid; // @[src/main/scala/npu/NpuExeTop.scala 171:15]
  assign dut_io_mesh_d_bits = mesh_io_d_bits; // @[src/main/scala/npu/NpuExeTop.scala 171:15]
  assign mesh_clock = clock;
  assign mesh_reset = reset;
  assign mesh_io_a_valid = dut_io_mesh_a_valid; // @[src/main/scala/npu/NpuExeTop.scala 171:15]
  assign mesh_io_a_bits = dut_io_mesh_a_bits; // @[src/main/scala/npu/NpuExeTop.scala 171:15]
  assign mesh_io_b_valid = dut_io_mesh_b_valid; // @[src/main/scala/npu/NpuExeTop.scala 171:15]
  assign mesh_io_b_bits = dut_io_mesh_b_bits; // @[src/main/scala/npu/NpuExeTop.scala 171:15]
  always @(posedge clock) begin
    if (mem_MPORT_en & mem_MPORT_mask) begin
      mem[mem_MPORT_addr] <= mem_MPORT_data; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
    end
    if (mem_MPORT_4_en & mem_MPORT_4_mask) begin
      mem[mem_MPORT_4_addr] <= mem_MPORT_4_data; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
    end
    mem_rdData_en_pipe_0 <= dut_io_spR_0_req_ready & dut_io_spR_0_req_valid;
    if (dut_io_spR_0_req_ready & dut_io_spR_0_req_valid) begin
      mem_rdData_addr_pipe_0 <= dut_io_spR_0_req_bits;
    end
    mem_rdat_en_pipe_0 <= io_peek_bank == 2'h0;
    if (io_peek_bank == 2'h0) begin
      mem_rdat_addr_pipe_0 <= io_peek_addr;
    end
    if (mem_1_MPORT_1_en & mem_1_MPORT_1_mask) begin
      mem_1[mem_1_MPORT_1_addr] <= mem_1_MPORT_1_data; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
    end
    if (mem_1_MPORT_5_en & mem_1_MPORT_5_mask) begin
      mem_1[mem_1_MPORT_5_addr] <= mem_1_MPORT_5_data; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
    end
    mem_1_rdData_1_en_pipe_0 <= dut_io_spR_1_req_ready & dut_io_spR_1_req_valid;
    if (dut_io_spR_1_req_ready & dut_io_spR_1_req_valid) begin
      mem_1_rdData_1_addr_pipe_0 <= dut_io_spR_1_req_bits;
    end
    mem_1_rdat_1_en_pipe_0 <= io_peek_bank == 2'h1;
    if (io_peek_bank == 2'h1) begin
      mem_1_rdat_1_addr_pipe_0 <= io_peek_addr;
    end
    if (mem_2_MPORT_2_en & mem_2_MPORT_2_mask) begin
      mem_2[mem_2_MPORT_2_addr] <= mem_2_MPORT_2_data; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
    end
    if (mem_2_MPORT_6_en & mem_2_MPORT_6_mask) begin
      mem_2[mem_2_MPORT_6_addr] <= mem_2_MPORT_6_data; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
    end
    mem_2_rdData_2_en_pipe_0 <= dut_io_spR_2_req_ready & dut_io_spR_2_req_valid;
    if (dut_io_spR_2_req_ready & dut_io_spR_2_req_valid) begin
      mem_2_rdData_2_addr_pipe_0 <= dut_io_spR_2_req_bits;
    end
    mem_2_rdat_2_en_pipe_0 <= io_peek_bank == 2'h2;
    if (io_peek_bank == 2'h2) begin
      mem_2_rdat_2_addr_pipe_0 <= io_peek_addr;
    end
    if (mem_3_MPORT_3_en & mem_3_MPORT_3_mask) begin
      mem_3[mem_3_MPORT_3_addr] <= mem_3_MPORT_3_data; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
    end
    if (mem_3_MPORT_7_en & mem_3_MPORT_7_mask) begin
      mem_3[mem_3_MPORT_7_addr] <= mem_3_MPORT_7_data; // @[src/main/scala/npu/NpuExeTop.scala 146:30]
    end
    mem_3_rdData_3_en_pipe_0 <= dut_io_spR_3_req_ready & dut_io_spR_3_req_valid;
    if (dut_io_spR_3_req_ready & dut_io_spR_3_req_valid) begin
      mem_3_rdData_3_addr_pipe_0 <= dut_io_spR_3_req_bits;
    end
    mem_3_rdat_3_en_pipe_0 <= io_peek_bank == 2'h3;
    if (io_peek_bank == 2'h3) begin
      mem_3_rdat_3_addr_pipe_0 <= io_peek_addr;
    end
    if (reset) begin // @[src/main/scala/npu/NpuExeTop.scala 147:26]
      respReg_valid <= 1'h0; // @[src/main/scala/npu/NpuExeTop.scala 147:26]
    end else begin
      respReg_valid <= respReg_valid_REG; // @[src/main/scala/npu/NpuExeTop.scala 158:21]
    end
    if (reset) begin // @[src/main/scala/npu/NpuExeTop.scala 147:26]
      respReg_bits <= 64'h0; // @[src/main/scala/npu/NpuExeTop.scala 147:26]
    end else begin
      respReg_bits <= mem_rdData_data; // @[src/main/scala/npu/NpuExeTop.scala 159:21]
    end
    if (reset) begin // @[src/main/scala/npu/NpuExeTop.scala 147:26]
      respReg_1_valid <= 1'h0; // @[src/main/scala/npu/NpuExeTop.scala 147:26]
    end else begin
      respReg_1_valid <= respReg_valid_REG_1; // @[src/main/scala/npu/NpuExeTop.scala 158:21]
    end
    if (reset) begin // @[src/main/scala/npu/NpuExeTop.scala 147:26]
      respReg_1_bits <= 64'h0; // @[src/main/scala/npu/NpuExeTop.scala 147:26]
    end else begin
      respReg_1_bits <= mem_1_rdData_1_data; // @[src/main/scala/npu/NpuExeTop.scala 159:21]
    end
    if (reset) begin // @[src/main/scala/npu/NpuExeTop.scala 147:26]
      respReg_2_valid <= 1'h0; // @[src/main/scala/npu/NpuExeTop.scala 147:26]
    end else begin
      respReg_2_valid <= respReg_valid_REG_2; // @[src/main/scala/npu/NpuExeTop.scala 158:21]
    end
    if (reset) begin // @[src/main/scala/npu/NpuExeTop.scala 147:26]
      respReg_2_bits <= 64'h0; // @[src/main/scala/npu/NpuExeTop.scala 147:26]
    end else begin
      respReg_2_bits <= mem_2_rdData_2_data; // @[src/main/scala/npu/NpuExeTop.scala 159:21]
    end
    if (reset) begin // @[src/main/scala/npu/NpuExeTop.scala 147:26]
      respReg_3_valid <= 1'h0; // @[src/main/scala/npu/NpuExeTop.scala 147:26]
    end else begin
      respReg_3_valid <= respReg_valid_REG_3; // @[src/main/scala/npu/NpuExeTop.scala 158:21]
    end
    if (reset) begin // @[src/main/scala/npu/NpuExeTop.scala 147:26]
      respReg_3_bits <= 64'h0; // @[src/main/scala/npu/NpuExeTop.scala 147:26]
    end else begin
      respReg_3_bits <= mem_3_rdData_3_data; // @[src/main/scala/npu/NpuExeTop.scala 159:21]
    end
    if (reset) begin // @[src/main/scala/npu/NpuExeTop.scala 158:31]
      respReg_valid_REG <= 1'h0; // @[src/main/scala/npu/NpuExeTop.scala 158:31]
    end else begin
      respReg_valid_REG <= doRead; // @[src/main/scala/npu/NpuExeTop.scala 158:31]
    end
    if (reset) begin // @[src/main/scala/npu/NpuExeTop.scala 158:31]
      respReg_valid_REG_1 <= 1'h0; // @[src/main/scala/npu/NpuExeTop.scala 158:31]
    end else begin
      respReg_valid_REG_1 <= doRead_1; // @[src/main/scala/npu/NpuExeTop.scala 158:31]
    end
    if (reset) begin // @[src/main/scala/npu/NpuExeTop.scala 158:31]
      respReg_valid_REG_2 <= 1'h0; // @[src/main/scala/npu/NpuExeTop.scala 158:31]
    end else begin
      respReg_valid_REG_2 <= doRead_2; // @[src/main/scala/npu/NpuExeTop.scala 158:31]
    end
    if (reset) begin // @[src/main/scala/npu/NpuExeTop.scala 158:31]
      respReg_valid_REG_3 <= 1'h0; // @[src/main/scala/npu/NpuExeTop.scala 158:31]
    end else begin
      respReg_valid_REG_3 <= doRead_3; // @[src/main/scala/npu/NpuExeTop.scala 158:31]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {2{`RANDOM}};
  for (initvar = 0; initvar < 256; initvar = initvar+1)
    mem[initvar] = _RAND_0[63:0];
  _RAND_5 = {2{`RANDOM}};
  for (initvar = 0; initvar < 256; initvar = initvar+1)
    mem_1[initvar] = _RAND_5[63:0];
  _RAND_10 = {2{`RANDOM}};
  for (initvar = 0; initvar < 256; initvar = initvar+1)
    mem_2[initvar] = _RAND_10[63:0];
  _RAND_15 = {2{`RANDOM}};
  for (initvar = 0; initvar < 256; initvar = initvar+1)
    mem_3[initvar] = _RAND_15[63:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  mem_rdData_en_pipe_0 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  mem_rdData_addr_pipe_0 = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  mem_rdat_en_pipe_0 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  mem_rdat_addr_pipe_0 = _RAND_4[7:0];
  _RAND_6 = {1{`RANDOM}};
  mem_1_rdData_1_en_pipe_0 = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  mem_1_rdData_1_addr_pipe_0 = _RAND_7[7:0];
  _RAND_8 = {1{`RANDOM}};
  mem_1_rdat_1_en_pipe_0 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  mem_1_rdat_1_addr_pipe_0 = _RAND_9[7:0];
  _RAND_11 = {1{`RANDOM}};
  mem_2_rdData_2_en_pipe_0 = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  mem_2_rdData_2_addr_pipe_0 = _RAND_12[7:0];
  _RAND_13 = {1{`RANDOM}};
  mem_2_rdat_2_en_pipe_0 = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  mem_2_rdat_2_addr_pipe_0 = _RAND_14[7:0];
  _RAND_16 = {1{`RANDOM}};
  mem_3_rdData_3_en_pipe_0 = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  mem_3_rdData_3_addr_pipe_0 = _RAND_17[7:0];
  _RAND_18 = {1{`RANDOM}};
  mem_3_rdat_3_en_pipe_0 = _RAND_18[0:0];
  _RAND_19 = {1{`RANDOM}};
  mem_3_rdat_3_addr_pipe_0 = _RAND_19[7:0];
  _RAND_20 = {1{`RANDOM}};
  respReg_valid = _RAND_20[0:0];
  _RAND_21 = {2{`RANDOM}};
  respReg_bits = _RAND_21[63:0];
  _RAND_22 = {1{`RANDOM}};
  respReg_1_valid = _RAND_22[0:0];
  _RAND_23 = {2{`RANDOM}};
  respReg_1_bits = _RAND_23[63:0];
  _RAND_24 = {1{`RANDOM}};
  respReg_2_valid = _RAND_24[0:0];
  _RAND_25 = {2{`RANDOM}};
  respReg_2_bits = _RAND_25[63:0];
  _RAND_26 = {1{`RANDOM}};
  respReg_3_valid = _RAND_26[0:0];
  _RAND_27 = {2{`RANDOM}};
  respReg_3_bits = _RAND_27[63:0];
  _RAND_28 = {1{`RANDOM}};
  respReg_valid_REG = _RAND_28[0:0];
  _RAND_29 = {1{`RANDOM}};
  respReg_valid_REG_1 = _RAND_29[0:0];
  _RAND_30 = {1{`RANDOM}};
  respReg_valid_REG_2 = _RAND_30[0:0];
  _RAND_31 = {1{`RANDOM}};
  respReg_valid_REG_3 = _RAND_31[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
