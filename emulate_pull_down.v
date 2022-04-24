// A module to emulate pull down resistors by occasionally pulling outputs low.
// Built for use with alchitry CU and early gen alchitry IO boards which didn't
// have pull down resistors in hardware

`ifndef _ALCHITRY_EMULATE_PULL_DOWN_
`define _ALCHITRY_EMUALTE_PULL_DOWN_

`default_nettype none

module emulate_pull_down #(parameter WIDTH = 1) (
    input clk,
    inout [WIDTH-1:0] in,
    output reg [WIDTH-1:0] out
  );
  
  localparam SIZE = 3'h5;
  reg [WIDTH-1:0] IO_in_enable;
  wire [WIDTH-1:0] IO_in_read;
  reg [WIDTH-1:0] IO_in_write;
  genvar GEN_in;
  generate
    for (GEN_in = 0; GEN_in < WIDTH; GEN_in = GEN_in + 1) begin
      assign in[GEN_in] = IO_in_enable[GEN_in] ? IO_in_write[GEN_in] : 1'bz;
    end
  endgenerate
  assign IO_in_read = in;
  
  
  reg [3:0] M_flip_d, M_flip_q = 1'h0;
  reg [WIDTH-1:0] M_saved_d, M_saved_q = 1'h0;
  
  always @* begin
    M_saved_d = M_saved_q;
    M_flip_d = M_flip_q;
    
    M_flip_d = M_flip_q + 1'h1;
    IO_in_write = 1'h0;
    IO_in_enable = {3'h5{M_flip_q == 1'h0}};
    if (M_flip_q > 2'h2) begin
      M_saved_d = IO_in_read;
    end
    out = M_saved_q;
  end
  
  always @(posedge clk) begin
    M_flip_q <= M_flip_d;
    M_saved_q <= M_saved_d;
  end
  
endmodule


`endif // _ALCHITRY_EMULATE_PULL_DOWN_