module subtractor(A, B, diff); // subtractor module
    input [7:0] A,B;
    output [7:0] diff;

    wire [7:0] Bcomp;

    assign Bcomp = ~B + 1; //obtaining 2's complement of B

    adder a0(A, Bcomp, diff); // using adder module to add A and 2's complement of B

endmodule