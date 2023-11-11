// Decoding the instruction into opcode, funct, Rs, Rt, Rd, shamt, imm

module instruction_decoder (ins,opcode,Rs,Rt,Rd,shamt,funct,imm);
    input [31:0] ins;
    output reg [5:0] opcode,funct;
    output reg [4:0] Rs,Rt,Rd,shamt;
    output reg [31:0] imm;

    parameter 
        R_TYPE = 6'b000000,

        ADDI =  6'b000001,
        SUBI =  6'b000010,
        ANDI =  6'b000011,
        ORI =   6'b000100,
        XORI = 6'b000101,
        NOTI = 6'b000110,
        SLAI = 6'b000111,
        SRLI = 6'b001000,
        SRAI = 6'b001001,

        BR =   6'b001010,
        BMI =  6'b001011,
        BPL =  6'b001100,
        BZ =   6'b001101,

        LD =  6'b001110,
        ST =  6'b001111,
        LDSP = 6'b010000,
        STSP = 6'b010001,

        MOVE = 6'b010010,

        PUSH = 6'b010011,
        POP = 6'b010100,
        CALL = 6'b010101, 

        HALT = 6'b010110,
        NOP = 6'b010111,
        RET = 6'b011000;

   always @(*)
        begin
            opcode <= ins[31:26];
            case(opcode)
                // R-type instructions - arithmetic operations
                R_TYPE: begin
                    Rs <= ins[25:21];
                    Rt <= ins[20:16];
                    Rd <= ins[15:11];
                    shamt <= ins[10:6];
                    funct <= ins[5:0];
                    imm <= 0;
                end

                // PUSH (instruction of type PUSH Rt)
                // Rs will be used to get SP in this case. also writing to SP will be required so Rd will also be SP
                PUSH: begin
                    Rs <= 16;
                    Rt <= ins[25:21];
                    Rd <= 16;
                    shamt <= 0;
                    funct <= 0;
                    imm <= 0; // not used
                end

                // POP (instruction of type POP Rt)
                // Rs will be used to get SP in this case. also writing to SP will be required so Rd will also be SP
                POP: begin
                    Rs <= 16;
                    Rt <= ins[25:21];
                    Rd <= 16;
                    shamt <= 0;
                    funct <= 0;
                    imm <= 0; // not used
                end

                // CALL (instruction of type CALL imm)
                // Rs will be used to get SP in this case. also writing to SP will be required so Rd will also be SP
                CALL: begin
                    Rs <= 16;
                    Rt <= 0;
                    Rd <= 16;
                    shamt <= 0;
                    funct <= 0;
                    imm <= { {16{ins[15]}} , ins[15:0]};
                end

                // RET
                // Rs will be used to get SP in this case. also writing to SP will be required so Rd will also be SP
                RET: begin
                    Rs <= 16;
                    Rt <= 0;
                    Rd <= 16;
                    shamt <= 0;
                    funct <= 0;
                    imm <= 0;
                end

                // HALT
                HALT: begin
                    Rs <= 0;
                    Rt <= 0;
                    Rd <= 0;
                    shamt <= 0;
                    funct <= 0;
                    imm <= 0;
                end

                // NOP
                NOP: begin
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
                    // in case of shift operations, shamt is the "imm" field
                    if (opcode == SRAI || opcode == SLAI || opcode == SRLI) shamt <= ins[4:0];
                    else shamt <= 0;
                    funct <= 0;
                    if (opcode == MOVE) imm <= 0; // implementing MOVE as ADDI with Imm = 0
                    else imm <= { {16{ins[15]}} , ins[15:0]};
                end
                
            endcase
        end
endmodule