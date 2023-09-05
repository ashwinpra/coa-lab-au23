`timescale 10ns / 1ns

module dff(d, clk, q, in_val);
    input d, clk, in_val;
    output reg q;

    initial q = in_val;

	always @(posedge clk) q <= d; 
endmodule

module lfsr (
    input [3:0] seed,
    input clk,
    output [3:0] q
);
    reg [3:0] d;

    dff dff0 (d[0], clk, q[0], seed[0]);
    dff dff1 (d[1], clk, q[1], seed[1]);
    dff dff2 (d[2], clk, q[2], seed[2]);
    dff dff3 (d[3], clk, q[3], seed[3]);

    always @(posedge clk) begin
        d[0] <= d[3];
        d[1] <= d[0];
        d[2] <= d[1];
        d[3] <= d[2] ^ d[3];
    end

endmodule
