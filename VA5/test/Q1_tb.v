module testbench; 
    reg signed [31:0] x;
    reg clk =0;
    wire signed [31:0] y;

    div255 DUT(x, clk, y);

    always #5 clk = ~clk;

    initial begin
        x = 255000;
        #100;
        $display("x = %d, y = %d", x, y);
        x = 2550;
        #100; 
        $display("x = %d, y = %d", x, y);
        #100;
        x = 255;
        #100;
        $display("x = %d, y = %d", x, y);
        #100; 
        x = 1020;
        #100;
        $display("x = %d, y = %d", x, y);
        #100; 
        $finish;
    end

endmodule