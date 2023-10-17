module adder(A, B, out);
    input [31:0] A, B;
    output reg [31:0] out;
    
    always @(A or B) begin
        out = A + B;
    end
endmodule