// ALU module
    
module alu (a,b,shamt,funct,clk,res);
    input [31:0] a;
    input [31:0] b;
    input [4:0] shamt;
    input [3:0] funct;
    input clk;
    output reg [31:0] res;

    parameter 
        ADD = 1,
        SUB = 2,
        AND = 3,
        OR = 4,
        XOR = 5,
        NOT = 6,
        SLA = 7,
        SRA = 8, 
        SRL = 9;

    wire signed [31:0] add_out, sub_out, and_out, or_out, xor_out, not_out, sla_out, sra_out, srl_out;

    adder       add_gate(a,b,add_out);
    subtractor  sub_gate(a,b,sub_out);
    and_module  and_gate(a,b,and_out);
    or_module   or_gate(a,b,or_out);
    xor_module  xor_gate(a,b,xor_out);
    not_module  not_gate(a,not_out);
    sla         sla_gate(a,b,shamt,sla_out);
    sra         sra_gate(a,b,shamt,sra_out);
    srl         srl_gate(a,b,shamt,srl_out);



    always @(posedge clk)
    begin
        // $display("A = %d, B = %d, shamt = %d, funct = %d", a, b, shamt, funct);
        case(funct)
            ADD: res <= add_out; 
            SUB: res <= sub_out;
            AND: res <= and_out;
            OR:  res <= or_out;
            XOR: res <= xor_out;
            NOT: res <= not_out;
            SLA: res <= sla_out;
            SRA: res <= sra_out;
            SRL: res <= srl_out;
        endcase
    end
endmodule


module adder(a,b,out);
    input [31:0] a;
    input [31:0] b;
    output reg [31:0] out;

    always @(a or b)
        out = a + b;
endmodule

module subtractor(a,b,out);
    input [31:0] a;
    input [31:0] b;
    output reg [31:0] out;

    always @(a or b)
        out = a - b;
endmodule

module and_module(a,b,out);
    input [31:0] a;
    input [31:0] b;
    output reg [31:0] out;

    always @(a or b)
        out = a & b;
endmodule

module or_module(a,b,out);
    input [31:0] a;
    input [31:0] b;
    output reg [31:0] out;

    always @(a or b)
        out = a | b;
endmodule

module xor_module(a,b,out);
    input [31:0] a;
    input [31:0] b;
    output reg [31:0] out;

    always @(a or b)
        out = a ^ b;
endmodule

module not_module(a,out);
    input [31:0] a;
    output reg [31:0] out;

    always @(a)
        out = ~a;
endmodule

module sla(a,b,shamt,out);
    input signed [31:0] a;
    input signed [31:0] b;
    input signed [4:0] shamt;
    output reg signed [31:0] out;

    always @(a or b or shamt)
        if (shamt)
            out = a <<< shamt;
        else
            out = a <<< b[0];
endmodule

module sra(a,b,shamt,out);
    input signed [31:0] a;
    input signed [31:0] b;
    input signed [4:0] shamt;
    output reg signed [31:0] out;

    always @(a or b or shamt)
        if (shamt)
            out = a >>> shamt;
        else
            out = a >>> b[0];
endmodule   

module srl(a,b,shamt,out);
    input [31:0] a;
    input [31:0] b;
    input [4:0] shamt;
    output reg [31:0] out;

    always @(a or b or shamt)
        if (shamt)
            out = a >> shamt;
        else
            out = a >> b[0];
endmodule

