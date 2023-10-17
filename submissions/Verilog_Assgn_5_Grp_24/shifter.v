module rshift8bit(A, out);
    input [31:0] A;
    output reg [31:0] out;

    always @(A) begin
        out = A >> 8;
    end
endmodule