module div255(
    input signed [31:0] x,
    input clk,
    output reg signed [31:0] out
);

    reg [31:0] y = 0;
    reg [7:0] x0, x1, x2, x3;
    reg [7:0] y0, y1, y2, y3;
    reg [2:0] state = 0;

    always @(posedge clk) begin
        // State machine to perform the division
        $display("state = %d", state);
        case (state)
            0: begin
                x0 = x[7:0];
                y0 = y - x0;
                y = y0;
                $display("x0 = %d, y0 = %d", x0, y0);
                state = 1;
            end
            1: begin
                x1 = x[15:8];
                y1 = y - x1;
                y = y1;
                $display("x1 = %d, y1 = %d", x1, y1);
                state = 2;
            end
            2: begin
                x2 = x[23:16];
                y2 = y - x2;
                y = y2;
                $display("x2 = %d, y2 = %d", x2, y2);
                state = 3;
            end
            3: begin
                x3 = x[31:24];
                y3 = y - x3;
                y = y3;
                $display("x3 = %d, y3 = %d", x3, y3);
                state = 4;
            end
            4: begin
                // Output the result when done
                out = {y3, y2, y1, y0};
                state = 0; // Reset the state machine for the next calculation
            end
        endcase
    end

endmodule
