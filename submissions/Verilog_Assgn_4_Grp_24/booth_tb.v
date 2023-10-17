`timescale 10ns / 1ns 

module booth_tb; 
    reg signed [7:0] M,Q;
    reg clk;
    wire signed [15:0] out;

    initial clk = 0;
    always #5 clk = ~clk;

    booth booth1(M, Q, clk, out);

    initial 
        begin
            M = -10; Q = 13;
            #1 $monitor("M = %d, Q = %d, out = %d", M, Q, out);
    
            #1000000 $finish;
        end
endmodule