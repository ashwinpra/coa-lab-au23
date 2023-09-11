module subtractor(A, B, Bin, Bout, diff);
    input [7:0] A,B;
    input Bin;
    output [7:0] diff;
    output Bout;

    wire [7:0] Bcomp;
    wire Bin1;

    assign Bcomp = ~B;
    assign Bin1 = ~Bin;

    adder a0(A, Bcomp, Bin1, Bout, diff);

endmodule