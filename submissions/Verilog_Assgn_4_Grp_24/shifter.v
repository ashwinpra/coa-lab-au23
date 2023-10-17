module shifter(A, Q, Q_1, A_out, Q_out, Q_1_out, concat_shift);
    input signed [7:0] A, Q;
    input signed Q_1;

    output signed [7:0] A_out, Q_out;
    output signed Q_1_out;
    output signed [16:0] concat_shift;

    wire signed [16:0] concat;
    assign concat = {A, Q, Q_1};

    assign concat_shift = concat >>> 1; 


    assign A_out = concat_shift[16:9];
    assign Q_out = concat_shift[8:1];
    assign Q_1_out = concat_shift[0];

endmodule