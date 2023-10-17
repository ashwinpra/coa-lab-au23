module alu(in1, in2, func, result, Cout); // Arithmetic Logic Unit
    input [7:0] in1, in2;
    input [2:0] func;
    
    output reg [7:0] result;
    output Cout;
    
    // assigning parameters to map with 3 bit function input
    parameter ADD = 0; 
    parameter SUB = 1; 
    parameter MOVE = 2; 
    parameter LSHIFT = 3; 
    parameter RSHIFT = 4;
    parameter AND = 5;
    parameter NOT = 6;
    parameter OR = 7;

    wire [7:0] sum, diff, move, lshift, rshift, and_res, not_res, or_res;

    // instantiating modules
    adder a0(in1, in2, Cout, sum); 
    subtractor s0(in1, in2, Cout, diff);
    move m0(in1, move);
    leftshift l0(in1, lshift);
    rightshift r0(in1, rshift);
    and_module a1(in1, in2, and_res);
    not_module n0(in1, not_res);
    or_module o0(in1, in2, or_res);

    always @(*)
    begin
        // case statement to map 3 bit function input to the correct output
        case(func) 
            ADD: result = sum;
            SUB: result = diff;
            MOVE: result = move;
            LSHIFT: result = lshift;
            RSHIFT: result = rshift;
            AND: result = and_res;
            NOT: result = not_res;
            OR: result = or_res;
        endcase
    end

endmodule