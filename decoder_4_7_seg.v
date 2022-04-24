module decoder_4_7_seg (
    input clk, rst,
    input [13:0] displayed_number,
    output reg [3:0] digit,
    output reg [7:0] segs
);
    reg [3:0] bcd;
    reg [18:0] counter;
    reg [1:0] led_select;

    initial begin 
        counter <= 0;
    end

    always @(posedge clk, posedge rst) begin
        if (rst == 1'b1) begin
            counter <= 0;
        end else begin
            counter <= counter + 1;
        end
    end

    assign led_select = counter[18:17];
    
    always @(led_select) begin
        case(led_select)
            2'b00: begin
                digit = ~4'b0001;
                bcd = ((displayed_number % 1000) % 100) % 10;
            end
            2'b01: begin
                digit = ~4'b0010;
                bcd = ((displayed_number % 1000) % 100) / 10;
            end
            2'b10: begin
                digit = ~4'b0100;
                bcd = (displayed_number % 1000) / 100;
            end
            2'b11: begin
                digit = ~4'b1000;
                bcd = displayed_number / 1000;
            end
            default: begin
                digit = ~4'b0000;
            end
        endcase
    end


    always @(posedge clk) begin
        case (bcd)
            0: segs <= ~7'b0111111;
            1: segs <= ~7'b0000110;
            2: segs <= ~7'b1011011;
            3: segs <= ~7'b1001111;
            4: segs <= ~7'b1100110;
            5: segs <= ~7'b1101101;
            6: segs <= ~7'b1111101;
            7: segs <= ~7'b0000111;
            8: segs <= ~7'b1111111;
            9: segs <= ~7'b1101111;
            default: segs <= ~7'b0000000;
        endcase
    end

endmodule