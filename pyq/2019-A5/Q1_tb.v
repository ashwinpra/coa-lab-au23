`timescale 10ns / 1ns

module tb_lfsr;

    reg [3:0] seed;
    reg clk;
    wire [3:0] out;

    // Instantiate the LFSR module
    lfsr lfsr1 (seed, clk, out);

    // Clock generation
    always #5 clk = ~clk;

    // Initialize signals
    initial begin
        seed = 4'b1111; // Initial seed value
        clk = 0;

        // Monitor every 200 ns
        #200 $monitor("seed = %b, out = %b", seed, out);


        #4000000000 $finish;
    end

endmodule
