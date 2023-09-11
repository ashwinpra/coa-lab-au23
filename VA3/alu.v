module alu(in1, in2, Cin, func, result, Cout);
    input [7:0] in1, in2;
    input Cin;
    input [2:0] func;

    output [7:0] result;
    output Cout;
    
    reg [7:0] ALU_Result;

    assign result = ALU_Result;

    parameter ADD = 0;
    parameter SUB = 1; 
    parameter ASSIGN = 2; 
    parameter LSHIFT = 3; 
    parameter RSHIFT = 4;
    parameter AND = 5;
    parameter NOT = 6;
    parameter OR = 7;

    adder a0(in1, in2, Cin, Cout, ALU_Result);
    subtractor s0(in1, in2, Cin, Cout, ALU_Result);



    always @(*)
    begin
        case(func)
            ADD: a0;
            SUB: s0;
            
        endcase
    end

endmodule