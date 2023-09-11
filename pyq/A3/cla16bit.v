// make it using 4 bit cla adders using hierarchical design

module cla16bit(S,Cout,A,B,Cin);
    output [15:0]S;
    output Cout;

    input [15:0]A,B;
    input Cin;

    wire [4:0]C;   // intermediate carry of adders, one extra for coding simplicity

    // now use the cla4bit module to make the cla16bit module
    cla4bit c1(S[3:0],C[1],A[3:0],B[3:0],Cin);
    cla4bit c2(S[7:4],C[2],A[7:4],B[7:4],C[1]);
    cla4bit c3(S[11:8],C[3],A[11:8],B[11:8],C[2]);
    cla4bit c4(S[15:12],C[4],A[15:12],B[15:12],C[3]);

    assign Cout = C[4]; // carry out of the adder
endmodule