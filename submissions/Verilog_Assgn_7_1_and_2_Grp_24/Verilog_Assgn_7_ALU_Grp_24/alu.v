module alu (a,b,shamt,funct,clk,res);
    input [31:0] a;
    input [31:0] b;
    input [4:0] shamt;
    input [3:0] funct;
    input clk;
    output reg [31:0] res;

    parameter 
        ADD = 0,
        SUB = 1,
        AND = 2,
        OR = 3,
        XOR = 4,
        NOT = 5,
        SLA = 6,
        SRA = 7, 
        SRL = 8;

    wire [31:0] add_out, sub_out, and_out, or_out, xor_out, not_out, sla_out, sra_out, srl_out;

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