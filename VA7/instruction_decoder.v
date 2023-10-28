// Decoding the instruction into opcode, funct, Rs, Rt, Rd, shamt, imm

module instruction_decoder (ins,opcode,Rs,Rt,Rd,shamt,funct,imm,addr);
    input [31:0] ins;
    output [5:0] opcode,funct;
    output [4:0] Rs,Rt,Rd,shamt;
    output [15:0] imm;
    //output [25:0] addr;
    assign opcode = ins[31:26];

   always @(*)
        begin
            case(opcode)

                // R-type instructions - arithmetic operations
                6'b000000: begin
                    Rs = ins[25:21];
                    Rt = ins[20:16];
                    Rd = ins[15:11];
                    shamt = ins[10:6];
                    funct = ins[5:0];
                    imm = 0;
                    //addr = 0;
                end

                // HALT
                6'b010110: begin
                    Rs = 0;
                    Rt = 0;
                    Rd = 0;
                    shamt = 0;
                    funct = 0;
                    imm = 0;
                    //addr = 0;
                end

                // NOP
                6'b010111: begin
                    Rs = 0;
                    Rt = 0;
                    Rd = 0;
                    shamt = 0;
                    funct = 0;
                    imm = 0;
                    //addr = 0;
                end
                
                // RET
                6'b011000: begin
                    Rs = 0;
                    Rt = 0;
                    Rd = 0;
                    shamt = 0;
                    funct = 0;
                    imm = 0;
                    //addr = 0;
                end

                // I-type instructions 
                default: begin
                    Rs = ins[25:21];
                    Rt = ins[20:16];
                    Rd = 0;
                    shamt = 0;
                    funct = 0;
                    imm = ins[15:0];
                    //addr = 0;
                end
                
            endcase
        end
endmodule