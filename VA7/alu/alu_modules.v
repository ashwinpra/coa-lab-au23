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

