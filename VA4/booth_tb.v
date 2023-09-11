module testbench;
    reg clk, start;
    reg signed [7:0] a, b;
    wire signed [15:0] ab;
    wire busy;

    always #5 clk = !clk;

    // booth_multiplier multiplier1(ab, busy, a, b, clk, start);
    booth_multiplier multiplier1(a, b, clk, start, ab);


    initial begin
        clk = 0;

        $display("first example: M = 3 Q = 17");
        a = 3; b = 17; start = 1; #10 start = 0;
        #80 $display("result = %d", ab);

        $display("second example: M = 7 Q = 7");
        a = 7; b = 7; start = 1; #10 start = 0;
        #80 $display("result = %d", ab);

        #10000 $finish;
        end
endmodule