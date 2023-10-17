`timescale 1ns / 1ps

// Verilog Assignment 2, Question 1 
// TESTBENCH MODULE
// Autumn Semester 2023-24 (Semester 5)
// Group No. 24 
// Gorantla Thoyajakshi - 21CS10026
// Ashwin Prasanth - 21CS30009


module control_reg_tb;
    reg [2:0] src, dest;
    reg MOVE, IN;
    reg [15:0] data_in;
    reg clk;
    wire [15:0] data_out;

    initial clk = 0;
    
    always #5 clk = ~clk; // declaring clock cycle with period of 

    control_reg C1 (src, dest, MOVE, IN, data_in, clk, data_out);

    initial
        begin
            // trying to move value "9" into R0
            dest = 0; data_in = 9; IN = 1; MOVE = 0;
            #200 $display("Inputted %d into R%d using IN", data_out, dest);

            // trying to move the value at R0 to R1
            src = 0; dest = 1; MOVE = 1; IN = 0;
            #200 $display("Moved %d from R%d to R%d using MOVE", data_out, src, dest);

            // trying to move value "15" into R2
            dest = 2; data_in = 15; IN = 1; MOVE =  0;
            #200 $display("Inputted %d into R%d using IN", data_out, dest);
            
            // trying to move the value at R2 to R0
            src = 2; dest = 0; MOVE = 1; IN = 0;
            #200 $display("Moved %d  from R%d to R%d using MOVE", data_out, src, dest);

            // trying error case - both MOVE and IN are high
            #200 dest = 1; IN = 1; MOVE = 1;

            #10000 $finish;
        end
endmodule