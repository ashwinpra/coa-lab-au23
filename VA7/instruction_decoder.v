// Decoding the instruction into opcode, funct, Rs, Rt, Rd, shamt, imm

module instruction_decoder (ins,opcode,Rs,Rt,Rd,shamt,funct,imm);
    input [31:0] ins;
    output reg [5:0] opcode,funct;
    output reg [4:0] Rs,Rt,Rd,shamt;
    output reg [31:0] imm;

   always @(*)
        begin
            opcode <= ins[31:26];
            case(opcode)
                // R-type instructions - arithmetic operations
                6'b000000: begin
                    Rs <= ins[25:21];
                    Rt <= ins[20:16];
                    Rd <= ins[15:11];
                    shamt <= ins[10:6];
                    funct <= ins[5:0];
                    imm <= 0;
                end

                // PUSH (instruction of type PUSH Rt)
                // Rs will be used to get SP in this case. also writing to SP will be required so Rd will also be SP
                6'b010011: begin
                    Rs <= 16;
                    Rt <= ins[25:21];
                    Rd <= 16;
                    shamt <= 0;
                    funct <= 0;
                    imm <= 0; // not used
                end

                // POP (instruction of type POP Rt)
                // Rs will be used to get SP in this case. also writing to SP will be required so Rd will also be SP
                6'b010100: begin
                    Rs <= 16;
                    Rt <= ins[25:21];
                    Rd <= 16;
                    shamt <= 0;
                    funct <= 0;
                    imm <= 0; // not used
                end

                // CALL (instruction of type CALL imm)
                // Rs will be used to get SP in this case. also writing to SP will be required so Rd will also be SP
                6'b010101: begin
                    Rs <= 16;
                    Rt <= 0;
                    Rd <= 16;
                    shamt <= 0;
                    funct <= 0;
                    imm <= { {16{ins[15]}} , ins[15:0]};
                end

                // RET
                // Rs will be used to get SP in this case. also writing to SP will be required so Rd will also be SP
                6'b011000: begin
                    Rs <= 16;
                    Rt <= 0;
                    Rd <= 16;
                    shamt <= 0;
                    funct <= 0;
                    imm <= 0;
                end

                // HALT
                6'b010110: begin
                    Rs <= 0;
                    Rt <= 0;
                    Rd <= 0;
                    shamt <= 0;
                    funct <= 0;
                    imm <= 0;
                end

                // NOP
                6'b010111: begin
                    Rs <= 0;
                    Rt <= 0;
                    Rd <= 0;
                    shamt <= 0;
                    funct <= 0;
                    imm <= 0;
                end
                


                // other I-type instructions 
                default: begin
                    Rs <= ins[25:21];
                    Rt <= ins[20:16];
                    Rd <= 0;
                    shamt <= 0;
                    funct <= 0;
                    if (opcode == 6'b010010) imm <= 0; // implementing MOVE as ADDI with Imm = 0
                    else imm <= { {16{ins[15]}} , ins[15:0]};
                end
                
            endcase
        end
endmodule