module testbench; 
    /*
    module adder(A, B, Cin, Cout, sum); 
    input [7:0] A,B;
    input Cin; 
    output [7:0] sum;
    output Cout;

    wire Cout1;

    CLA4bit c0(A[3:0], B[3:0], Cin, Cout1, sum[3:0]);
    CLA4bit c1(A[7:4], B[7:4], Cout1, Cout, sum[7:4]);
endmodule
    */
    reg signed [7:0] A, B;
    reg Cin;
    wire signed [7:0] sum;
    wire Cout;

    adder a(A, B, Cin, Cout, sum);

    initial 
        begin
            // make testcases
            A = 12;
            B = 23;
            Cin = 1'b0;
            #100 $display("A=%d, B=%d, Cin=%d, Cout=%d, sum=%d", A, B, Cin, Cout, sum);

            A = -10;
            B = 13;
            Cin = 1'b0;

            #100 $display("A=%d, B=%d, Cin=%d, Cout=%d, sum=%d", A, B, Cin, Cout, sum);
        end
endmodule