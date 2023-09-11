`timescale 10ns / 1ns

// Verilog Assignment 2, Question 1 
// REGISTER CONTROL MODULE
// Autumn Semester 2023-24 (Semester 5)
// Group No. 24 
// Gorantla Thoyajakshi - 21CS10026
// Ashwin Prasanth - 21CS30009


module control_reg(src, dest, MOVE, IN, data_in, clk, data_out);
    // defining input and output ports
    input [2:0] src, dest;
    input MOVE, IN;
    input [15:0] data_in;
    input clk;

    output reg [15:0] data_out;

    wire [15:0] R [7:0]; // an array of length 7 is made, each entry being of 16 bits, to store the value at each register

    reg [7:0] L; // an 8 bit array to save the "LOAD" value of each register
    reg E; // a common register to store the "ENABLE" value of all registers
    reg [15:0] in_line; // a common register to store the value to be inputted in the required register

    // instantiating 8 registers - their values are accessed through out_line (stored in R), and values provided through in_line
    register R0 ( L[0], E, in_line, R[0] );
    register R1 ( L[1], E, in_line, R[1] );
    register R2 ( L[2], E, in_line, R[2] );
    register R3 ( L[3], E, in_line, R[3] );
    register R4 ( L[4], E, in_line, R[4] );
    register R5 ( L[5], E, in_line, R[5] );
    register R6 ( L[6], E, in_line, R[6] );
    register R7 ( L[7], E, in_line, R[7] );


    // following code is executed at every positive edge trigger of the clock cycle
    always @(posedge clk)
        begin
            // initially, all L and E are set to zero
            L <= 0;
            E <= 0;

            // MOVE and IN both cannot be simultaneously HIGH - throwing error and terminating in this case
            if (MOVE && IN) begin
                $display("Error: MOVE and IN cannot be 1 at the same time");
                $finish;
            end
            else begin
            if (MOVE)
                // if MOVE is high, then value in register specified by "src" is moved to the register specified by "dest"
                // also the alue that was transfered (ie, R[src]) is stored to "data_out" as output
                begin
                    E <= 1; // first, the registers are enabled
                    data_out <= R[src]; // the value at R[src] is transfered to data_out
                    
                    in_line <= data_out; // the above value is transfered to in_line
                    L[dest] <= 1; // now the LOAD value of register specified by "dest" is set to high so that it accepts the value in "in_line"
                end
            else if (IN)
                // if IN is high, then the value given as input in "data_in" is moved to the register specified by "dest"
                // also the alue that was transfered (ie, "data_in") is stored to "data_out" as output
                begin
                    E <= 1; // first, the registers are enabled
                    in_line <= data_in; // the data_in value is transfered to in_line
                    L[dest] <= 1; // now the LOAD value of register specified by "dest" is set to high so that it accepts the value in "in_line"
                    
                    data_out <= data_in; // for monitoring purposes
                end
            end
        end
endmodule 