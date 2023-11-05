// to decide the 2 inputs to the ALU based on control signals
module alu_control(A, B, imm, NPC, BranchOp, ALUSrc, ALUOp, ALUin1, ALUin2);
    input [31:0] A,B,imm, NPC;
    input [2:0] BranchOp; 
    input ALUSrc;
    input [3:0] ALUOp; 
    output [31:0] ALUin1, ALUin2; 
    
    // if it's a branching operation, then ALUin1 is NPC, else A
    assign ALUin1 = (BranchOp == 0) ? A : NPC; 
    
    // if ALUSrc is 0, choose B, else choose imm 
    assign ALUin2 = (ALUSrc == 0) ? B : imm;
    
endmodule
