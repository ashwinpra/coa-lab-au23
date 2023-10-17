module subtractor(A, B, Bout, diff); // subtractor module
    input [7:0] A,B;
    output [7:0] diff;
    output Bout;

    wire [7:0] Bcomp;

    assign Bcomp = ~B; //obtaining 2's complement of B

    adder a0(A, Bcomp, Bout, diff); // using adder module to add A and 2's complement of B

endmodule