`timescale 1ns / 1ps

// Verilog Assignment 2, Question 2
// TESTBENCH MODULE
// Autumn Semester 2023-24 (Semester 5)
// Group No. 24 
// Gorantla Thoyajakshi - 21CS10026
// Ashwin Prasanth - 21CS30009


module gcd_tb;
    reg [7:0] a;
    reg [7:0] b;
    reg clk;
    wire [7:0] result;

    initial clk = 0;
    
    always #5 clk = ~clk; // declaring clock cycle with period of 5* 1ns 

    gcd gcd1(result, a, b, clk);

    initial
        begin
            // trying multiple test cases and displaying the answers, with sufficient time gap 

            a = 1; b = 1;
            #200 $display("a = %d, b = %d, gcd = %d", a, b, result);

            a = 10; b = 5;
            #200 $display("a = %d, b = %d, gcd = %d", a, b, result);

            a = 12; b = 8;
            #200 $display("a = %d, b = %d, gcd = %d", a, b, result);

            a = 10; b = 15;
            #200 $display("a = %d, b = %d, gcd = %d", a, b, result);
            
            a = 0; b = 7; 
            #200 $display("a = %d, b = %d, gcd = %d", a, b, result);

            #100000 $finish;
        end
endmodule
