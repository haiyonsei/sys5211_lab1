
`timescale 1ns / 1ps

module testbench;

  localparam BS         = 4;
  localparam SP_BANKS   = 4;
  localparam SP_ENTRIES = 256;
  localparam DATA_W     = 16;
  localparam ADDR_W     = 16;
  localparam SP_WIDTH   = BS * DATA_W;

  logic           clock;
  logic           reset;

  logic           io_cmd_ready;
  logic           io_cmd_valid;
  logic [15:0]    io_cmd_bits_aBase;
  logic [15:0]    io_cmd_bits_bBase;
  logic [15:0]    io_cmd_bits_cBase;
  logic           io_cmd_bits_start;
  logic           io_done;
  logic           io_init_en;
  logic [1:0]     io_init_bank;
  logic [7:0]     io_init_addr;
  logic [63:0]    io_init_data;
  logic [1:0]     io_peek_bank;
  logic [7:0]     io_peek_addr;
  logic [63:0]    io_peek_data;

  int A[BS-1:0][BS-1:0];
  int B[BS-1:0][BS-1:0];
  int C_golden[BS-1:0][BS-1:0];

  NpuExeTop dut (.*);

  initial begin
    clock = 0;
    forever #5 clock = ~clock;
  end

  function int spBank(int base, int rowIdx);
    return (base + rowIdx) % SP_BANKS;
  endfunction

  function int spRow(int base, int rowIdx);
    return (base + rowIdx) / SP_BANKS;
  endfunction

  function logic [SP_WIDTH-1:0] packRow(int row_data[BS]);
    logic [SP_WIDTH-1:0] packed_data = 0;
    for (int i = 0; i < BS; i++) begin
      packed_data[i*DATA_W +: DATA_W] = row_data[i][DATA_W-1:0];
    end

    return packed_data;
  endfunction

  task writeRow(input int bank, input int row, input int data[BS]);
    @(posedge clock);
    io_init_en   = 1'b1;
    io_init_bank = bank;
    io_init_addr = row;
    io_init_data = packRow(data); 
    @(posedge clock);
    io_init_en   = 1'b0;
    io_init_data = 0;
  endtask

  task readRow(input int bank, input int row, output logic [SP_WIDTH-1:0] data);
    @(posedge clock);
    io_peek_bank = bank;
    io_peek_addr = row;
    @(posedge clock); 
    data = io_peek_data;
  endtask

  initial begin
    int aBase, bBase, cBase;
    int row_to_write[BS];
    int cycleCount;
    logic [SP_WIDTH-1:0] read_data;
    int c_dut_row[BS];
    int errors;
    logic [DATA_W-1:0] mask;

    mask = '1;
    $display("INFO: Starting NpuExeTop testbench...");

    for (int i = 0; i < BS; i++) begin
      for (int k = 0; k < BS; k++) begin
        A[i][k] = i + k;
      end
    end
    for (int k = 0; k < BS; k++) begin
      for (int j = 0; j < BS; j++) begin
        B[k][j] = k + j;
      end
    end

    reset = 1;
    io_cmd_valid = 0;
    io_init_en = 0;
    @(posedge clock);
    @(posedge clock);
    reset = 0;
    $display("INFO: Reset released.");

    aBase = 0;
    bBase = 4;
    cBase = 32;

    $display("INFO: Initializing Scratchpad memory...");
    for (int i = 0; i < BS; i++) begin
      for (int k = 0; k < BS; k++) begin
        row_to_write[k] = A[i][k];
      end
      writeRow(spBank(aBase, i), spRow(aBase, i), row_to_write);
    end

    for (int k = 0; k < BS; k++) begin
      for (int j = 0; j < BS; j++) begin
        row_to_write[j] = B[k][j];
      end
      writeRow(spBank(bBase, k), spRow(bBase, k), row_to_write);
    end
    $display("INFO: Scratchpad initialized.");


    for (int i = 0; i < BS; i++) begin
      readRow(spBank(aBase, i), spRow(aBase, i), read_data);
      
      for (int j = 0; j < BS; j++) begin
        c_dut_row[j] = (read_data >> (j * DATA_W)) & mask;
      end
      $display("C(%0d): %p", i, c_dut_row);
    end

    @(posedge clock);
    io_cmd_valid        = 1'b1;
    io_cmd_bits_aBase   = aBase;
    io_cmd_bits_bBase   = bBase;
    io_cmd_bits_cBase   = cBase;
    io_cmd_bits_start   = 1'b1;
    wait(io_cmd_ready);
    @(posedge clock);
    io_cmd_valid = 1'b0;
    $display("INFO: Command issued to DUT.");

    cycleCount = 0;
    while (!io_done) begin
      @(posedge clock);
      cycleCount = cycleCount + 1;
    end
    $display("INFO: Computation finished in %0d cycles.", cycleCount);

    $display("INFO: Verifying results...");
    errors = 0;

    for (int i = 0; i < BS; i++) begin
      for (int j = 0; j < BS; j++) begin
        C_golden[i][j] = 0;
        for (int k = 0; k < BS; k++) begin
          C_golden[i][j] += A[i][k] * B[k][j];
        end
      end
    end

    for (int i = 0; i < BS; i++) begin
      readRow(spBank(cBase, i), spRow(cBase, i), read_data);
      
      for (int j = 0; j < BS; j++) begin
        c_dut_row[j] = (read_data >> (j * DATA_W)) & mask;
      end

      for (int j = 0; j < BS; j++) begin
        if (c_dut_row[j] != C_golden[i][j]) begin
          $error("MISMATCH at C(%0d, %0d): DUT=%0d, Golden=%0d", i, j, c_dut_row[j], C_golden[i][j]);
          errors = errors + 1;
        end
      end
      $display("C(%0d): %p", i, c_dut_row);
    end

    if (errors == 0) begin
      $display("SUCCESS: Test Passed!");
    end else begin
      $display("FAILURE: Test Failed with %0d errors.", errors);
    end

    $finish;
  end

endmodule

