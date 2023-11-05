// Main top module
module risc(clk, rst, out);
    input clk, rst;
    output [31:0] out;


    wire [31:0] MemAddr, MemIn;
    wire [31:0] PC, NPC, ins;
    wire [5:0] opcode, funct;
    wire [4:0] Rs, Rt, Rd, shamt;
    wire [4:0] destReg; 
    wire [31:0] imm;
    wire ALUSrc, MemR, MemW, RegW, RegDst, MemtoReg; 
    wire [2:0] BranchOp, StackOp;
    wire [3:0] ALUOp;
    wire [31:0] A, B, Rdin;
    wire [31:0] LMD;
    wire [31:0] ALUout; 
    wire [31:0] SP, NSP, MemSP;
    wire updatePC;


    instruction_memory IM (
        .addr(NPC),
        .ins(ins)
    );

    assign MemIn = (StackOp == 3'b010) ? NPC: B; // MUX to control memory write input - NPC in case of CALL, B otherwise

    assign MemAddr = (StackOp == 3'b000) ? ALUout : MemSP; // MUX to control memory address - MemSP in case of stack operations, ALUout otherwise

    data_memory DM (
        .opcode(opcode),
        .address(MemAddr), 
        .writeData(MemIn), 
        .MemR(MemR),
        .MemW(MemW),
        .readData(LMD)
    );

    // decode the instruction into Rs, Rt, Rd, shamt, funct, imm... 
    instruction_decoder ID (
        .ins(ins),
        .opcode(opcode),
        .Rs(Rs),
        .Rt(Rt),
        .Rd(Rd),
        .shamt(shamt),
        .funct(funct),
        .imm(imm)
    );

    control_unit CPU (
        .clk(clk),
        .opcode(opcode),
        .BranchOp(BranchOp),
        .ALUOp(ALUOp),
        .ALUSrc(ALUSrc),
        .MemR(MemR),
        .MemW(MemW),
        .RegW(RegW),
        .RegDst(RegDst),
        .MemtoReg(MemtoReg),
        .StackOp(StackOp), 
        .updatePC(updatePC)
    );

    assign destReg = (RegDst == 1) ? Rd : Rt; // MUX to control destination register to write to 

    assign Rdin = (MemtoReg == 1) ? LMD : ALUout; // MUX to control Rdin

    regbank RB(
        .ins(ins),
        .rData1(A),
        .rData2(B),
        .wrData(Rdin),
        .Rs(Rs),
        .Rt(Rt),
        .Rd(destReg),
        .reset(reset),
        .RegW(RegW),
        .clk(clk)
    );

    PC_control PCC (
        .BranchOp(BranchOp),
        .StackOp(StackOp),
        .ALUout(ALUout),
        .regval(A),
        .LMD(LMD),
        .PCin(PC), 
        .rst(rst),
        .clk(clk),
        .PCout(NPC)
    );

    // SP_control(StackOp, clk, rst, SPin, SPout, MemSP);
    SP_control SPC (
        .StackOp(StackOp), 
        .clk(clk), 
        .rst(rst),
        .SPin(), 
        .SPout(), 
        .MemSP(MemSP)
    );

    program_counter PC0 (
        .PCin(NPC),
        .clk(clk),
        .reset(rst),
        .PCout(PC),
        .updatePC(updatePC)
    );

    // to decide funct based on ALUOp
    wire [3:0] ALUfunct;
    assign ALUfunct = (ALUOp == 4'b0000) ? funct : ALUOp;

    // if it's a branching operation, then ALUin1 is NPC, else A
    wire [31:0] ALUin1; 
    assign ALUin1 = (BranchOp == 0) ? A : NPC; 
    
    // if ALUSrc is 0, choose B, else choose imm 
    wire [31:0] ALUin2;
    assign ALUin2 = (ALUSrc == 0) ? B : imm;

    alu ALU (
        .a(ALUin1),
        .b(ALUin2),
        .shamt(shamt),
        .funct(ALUfunct),
        .clk(clk),
        .res(ALUout)
    );

    assign out = ALUout; 

endmodule