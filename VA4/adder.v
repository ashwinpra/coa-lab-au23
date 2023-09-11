module CLA4bit(A, B, Cin, Cout, sum);
    input [3:0] A,B;
    input Cin;
    output [3:0] sum;
    output Cout;

    wire [3:0] G, P, C;

    assign G = A & B;
    assign P = A ^ B;

    assign C[0] = Cin;
    assign C[1] = G[0] | (P[0] & C[0]);
    assign C[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & C[0]);
    assign C[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & C[0]);   

    assign Cout = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]) | (P[3] & P[2] & P[1] & P[0] & C[0]);

    assign sum = P ^ C;
endmodule

module adder(A, B, Cin, Cout, sum); 
    input [7:0] A,B;
    input Cin; 
    output [7:0] sum;
    output Cout;

    wire Cout1;

    CLA4bit c0(A[3:0], B[3:0], Cin, Cout1, sum[3:0]);
    CLA4bit c1(A[7:4], B[7:4], Cout1, Cout, sum[7:4]);
endmodule
