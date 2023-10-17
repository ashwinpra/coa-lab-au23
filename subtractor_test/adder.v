module CLA4bit(A, B, Cin, Cout, sum); // 4 bit Carry Look Ahead Adder
    input [3:0] A,B;
    input Cin;
    output [3:0] sum;
    output Cout;

    wire [3:0] G, P, C;

    assign G = A & B; // Generate
    assign P = A ^ B; // Propagate

    assign C[0] = Cin; // Carry in
    assign C[1] = G[0] | (P[0] & C[0]); // Carry out from first bit
    assign C[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & C[0]); // Carry out from second bit
    assign C[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & C[0]);   // Carry out from third bit
    assign Cout = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]) | (P[3] & P[2] & P[1] & P[0] & C[0]); // Carry out from fourth bit

    assign sum = P ^ C; // Sum 
endmodule

module adder(A, B, sum); 
    input [7:0] A,B;
    output [7:0] sum;

    wire Cout;
    wire Cout1;

    CLA4bit c0(A[3:0], B[3:0], 1'b0, Cout1, sum[3:0]); // sum of the least significant 4 bits
    CLA4bit c1(A[7:4], B[7:4], Cout1, Cout, sum[7:4]); // sum of the most significant 4 bits
endmodule
