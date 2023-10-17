// test with 4 bit inputs, 2 bit shamt, 4 bit funct, 4 bit output
module alu_00(a_4,b_4,shamt_2,funct,clk,out);
    input [3:0] a_4, b_4;
    input [1:0] shamt_2;
    input [3:0] funct;
    input clk;
    output [31:0] out;

    wire [31:0] a, b;
    assign a = {28'b0, a_4};
    assign b = {28'b0, b_4};
    wire [4:0] shamt;
    assign shamt = {3'b0, shamt_2};

    alu a_0(a,b,shamt,funct,clk,out);
endmodule