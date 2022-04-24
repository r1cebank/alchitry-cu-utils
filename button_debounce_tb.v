`timescale 1ns / 10 ps

// Define testbench
module button_debounce_tb();

    wire out;

    reg btn = 0;
    reg clk = 0;
    reg rst = 0;

    localparam DURATION = 10000;

    // Generate 
    always #1 clk = ~ clk;  

    btn_debounce btn_1 (.clk(clk), .rst(rst), .btn(btn), .out(out));

    initial begin
        #10
        rst = 1'b1;
        #1
        rst = 1'b0;

        // Crazy button
        #10 btn = 1; #1 btn = 0; #4 btn = 1; #30 btn = 0; #2 btn = 1; #1 btn = 0; #2 btn = 1;
        #5 btn = 0; #2 btn = 1; #30 btn = 0; #2 btn = 1; #1 btn = 0; #30 btn = 0;
    end

    initial begin
        $dumpfile("button_debounce_tb.vcd");
        $dumpvars(0, button_debounce_tb);

        #(DURATION)

        $display("Finished");
        $finish;
    end

endmodule