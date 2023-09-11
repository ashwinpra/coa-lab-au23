`timescale 10ns / 1ns

// Verilog Assignment 2, Question 2
// GCD MODULE
// Autumn Semester 2023-24 (Semester 5)
// Group No. 24 
// Gorantla Thoyajakshi - 21CS10026
// Ashwin Prasanth - 21CS30009


module gcd(result, a, b, clk);
    // defining input and output ports 
    input [7:0] a,b;
    input clk;
    output reg [7:0] result;

    // temporary registers that will initially store values of a and b, and then reduce iteratively until GCD is found
    reg [7:0] tempa, tempb;

    // following code is executed at every positive edge trigger of the clock cycle
    always @ (posedge clk)
    begin
        // if one of them is zero, then the other is the gcd
        if (tempa == 0)
            result <= tempb;
        else if (tempb == 0)
            result <= tempa;
        else
        // if not, then the smaller of the two is subtracted from the larger of the two
        begin
            if (tempa > tempb)
                tempa <= tempa - tempb;
            else
                tempb <= tempb - tempa;
        end
    end

    // if the value of a and b ever changes (ie, a new test case is passed), the values of tempa and tempb are updated
    //  correspondingly and result is reset to zero
    always @ (a or b)
        begin 
            tempa <= a; 
            tempb <= b; 
            result <= 0;
        end

endmodule
