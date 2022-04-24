module button_debounce (
    input clk,
    input rst,
    input btn,

    output reg out
);

    localparam WAIT_CHANGE = 1'b0;
    localparam STATE_CHANGE = 1'b1;
    localparam [8:0] MAX_COUNT = 10;

    reg [24:0] count;
    reg [1:0] state;
    reg [1:0] btn_buffer;

    always @ (posedge clk, posedge rst) begin
        if (rst == 1'b1) begin
            count <= 1'b0;
            btn_buffer <= 1'b0;
            state <= WAIT_CHANGE;
            out <= 1'b0;
        end else begin
            case (state)
                WAIT_CHANGE: begin
                    count <= 1'b0;
                    state <= STATE_CHANGE;
                    btn_buffer <= btn;
                end
                STATE_CHANGE: begin
                    if (btn != btn_buffer) begin
                        state <= WAIT_CHANGE;
                    end else begin
                        if (count == MAX_COUNT) begin
                            out <= btn_buffer;
                        end else begin
                            count <= count + 1;
                        end
                    end
                end
                default: begin
                    count <= 1'b0;
                    btn_buffer <= 1'b0;
                    state <= WAIT_CHANGE;
                end
            endcase
        end
    end

endmodule