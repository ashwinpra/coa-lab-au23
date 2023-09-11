`timescale 10ns / 1ns

// Verilog Assignment 2, Question 1 
// REGISTER MODULE
// Autumn Semester 2023-24 (Semester 5)
// Group No. 24 
// Gorantla Thoyajakshi - 21CS10026
// Ashwin Prasanth - 21CS30009


module register(LOAD, ENABLE, in_line, out_line);
    // defining input and output ports
    input LOAD, ENABLE;
    input [15:0] in_line;

    output reg [15:0] out_line;

    reg [15:0] R = 0; // initialising value at register to zero

    // following is executed whenever LOAD or ENABLE is modified
    always @ (LOAD or ENABLE)
        begin
            // if LOAD is high, then the value provided through "in_line" is assigned to the register
            if (LOAD) begin
                R <= in_line;
            end
            // if ENABLE is high, then the value in R can be accessed through "out_line"
            if (ENABLE)
                out_line <= R;
            // else, out_line is at high impedence state
            else
                out_line <= 8'bz;
        end
endmodule
