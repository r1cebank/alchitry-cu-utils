module test (
    input clk, rst,
    inout [4:0] io_button,
    output reg [7:0] led,
    output [3:0] io_sel,
    output [7:0] io_seg
);
    wire[4:0] button_pd_out;
    reg [13:0] displayed_number;
    // Binary for 1540
    assign displayed_number = 13'b0011000000100;
    wire div_clk, count;
    assign count = button_pd_out[2];
    wire change_pulse;

    /*
      Button mapping
            0
        3   1   4
            2
    */
    // Initialize a divided clock
    clock_divider #(.COUNT_WIDTH(25), .MAX_COUNT(20000000)) div1 (.clk(clk), .rst(~rst), .out(div_clk));
    // Emulate pulldown on all button above
    emulate_pull_down #(.WIDTH (5)) button_pd(
        .clk(clk),
        .in(io_button),
        .out(button_pd_out));
    // Apply debouncing to button 2
    button_debounce btn_1 (.clk(clk), .rst(~rst), .btn(count), .out(change_pulse));
    decoder_4_7_seg decoder1 (
        .clk(clk),
        .rst(~rst),
        .displayed_number(displayed_number),
        .segs(io_seg),
        .digit(io_sel)
    );

    always @ (posedge change_pulse, negedge rst) begin
        if (rst == 1'b0) begin
            led <= 4'b0;
        end else begin
            led <= led + 1'b1;
        end
    end

endmodule