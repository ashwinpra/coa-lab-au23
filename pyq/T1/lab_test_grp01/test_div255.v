`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.11.2022 13:01:47
// Design Name: 
// Module Name: test_div255
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module test_div255;

reg[31:0] x;
reg clk;
reg rst;
wire[31:0] y;

div255 dut(x, clk, rst, y);

initial
    begin
        clk<=1'd0;
        rst<=1'd1;
    end

always #10 clk=~clk;

initial
    begin
        //x<=32'd47619;
        x<=32'd13;
        //x<=32'd24760;
        //x<=32'd513;
        //x<=32'd512;
        //x<=32'd13;
        
        #30 rst<=1'd0;
    end


endmodule
