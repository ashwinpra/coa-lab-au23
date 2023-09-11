module testbench; 
    reg [15:0] x;
    reg flg1, flg2, flg3, flg4, rst, clk;
    wire [15:0] y;

    Divby255 divby255(x, flg1, flg2, flg3, flg4, rst, clk, y);

    always #5 clk = ~clk;

    initial begin 
        // 255000 -> 
        // 25500 -> 0000000000000000 0110001110011100
        // 2550 ->  0000000000000000 0000100111110110
        // 255 ->   0000000000000000 0000000011111111
    
        clk = 0; rst = 0; 

        x=0; flg1=1; flg2=0;
        #100 flg1=0;
        #100 flg2=1; 
        #20 x=16'b0110001110011100;
        #100 flg2=0;

        #100 flg3=1;flg4=0;
        #100 $display($time, " FINAL y_MSB = %b",y);

        #100 flg3=0; flg4=1;
        #100 $display($time, " FINAL y_LSB = %b",y);

    $finish;

    end
endmodule 