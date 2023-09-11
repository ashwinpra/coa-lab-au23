module cla4bit(S,Cout,A,B,Cin);
    output [3:0]S;
    output Cout;

    input [3:0]A,B;
    input Cin;

    wire [4:0]C;   // intermediate carry of adders, one extra for coding simplicity

    assign C[0] = Cin; // this line is not needed can be directly written
    assign C[1] = ( ( A[0] & B[0] ) | ( ( A[0] ^ B[0] ) & C[0] ) );
    assign C[2] = ( ( A[1] & B[1] ) | ( ( A[1] ^ B[1] ) & C[1] ) );
    assign C[3] = ( ( A[2] & B[2] ) | ( ( A[2] ^ B[2] ) & C[2] ) ); 
    assign C[4] = ( ( A[3] & B[3] ) | ( ( A[3] ^ B[3] ) & C[3] ) );

    assign S = A ^ B ^ C[3:0]; 
    assign Cout = C[4]; // carry out of the adder
  
endmodule