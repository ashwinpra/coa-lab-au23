module testbench; 

    reg [3:0] a,b; 
    reg [1:0] shamt;
    reg [3:0] funct;
    reg clk = 0;
    wire signed [31:0] out;

    alu_00 alu(a,b,shamt,funct,clk,out);

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

    always #5 clk = ~clk;

    initial 
    begin 
        #10 a = 12; b = 3; funct = ADD;
        #10 $display("a = %d, b = %d, funct = %d, out = %d", a, b, funct, out);
        #10 funct = SUB;
        #10 $display("a = %d, b = %d, funct = %d, out = %d", a, b, funct, out);
        #10 funct = AND;
        #10 $display("a = %d, b = %d, funct = %d, out = %d", a, b, funct, out);
        #10 funct = OR;
        #10 $display("a = %d, b = %d, funct = %d, out = %d", a, b, funct, out);
        #10 funct = XOR;
        #10 $display("a = %d, b = %d, funct = %d, out = %d", a, b, funct, out);
        #10 funct = NOT;
        #10 $display("a = %d, b = %d, funct = %d, out = %d", a, b, funct, out);
        #10 funct = SLA; shamt = 0; 
        #10 $display("a = %d, b = %d, funct = %d, shamt = %d, out = %d", a, b, funct, shamt, out);
        #10 funct = SRA; shamt = 2; 
        #10 $display("a = %d, b = %d, funct = %d, shamt = %d, out = %d", a, b, funct, shamt, out);
        // would give garbage output
        #10 funct = SRL; shamt = 2; 
        #10 $display("a = %d, b = %d, funct = %d, shamt = %d, out = %d", a, b, funct, shamt, out);

        #10 $finish;

    end

endmodule