// Control unit that outputs required control signals for each instruction

module control_unit(opcode, BranchOp, ALUOp, ALUSrc, MemR, MemW, RegW, RegDst, MemtoReg, StackOp);
    input [5:0] opcode;
    output reg [2:0] BranchOp;
    output reg [3:0] ALUOp;
    output reg ALUSrc, MemR, MemW, RegW, RegDst, MemtoReg; 
    output reg [2:0] StackOp;


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


    initial begin 
        BranchOp <= 3'b000;
        ALUOp <= 4'b0000;
        ALUSrc <= 0;
        MemR <= 0;
        MemW <= 0;
        RegW <= 0;
        RegDst <= 0;
        MemtoReg <= 0;
        StackOp <= 3'b000;
    end



    always @(*) begin
        case(opcode)

            // R-type arithmetic operations
            R_TYPE: begin
                BranchOp <= 3'b000;
                ALUOp <= 4'b0000;
                ALUSrc <= 0;
                MemR <= 0;
                MemW <= 0;
                RegW <= 1;
                RegDst <= 1;
                MemtoReg <= 0;
                StackOp <= 3'b000;
            end

            // I-type arithmetic operations
            ADDI: begin
                BranchOp <= 3'b000;
                ALUOp <= 4'b0001;
                ALUSrc <= 1;
                MemR <= 0;
                MemW <= 0;
                RegW <= 1;
                RegDst <= 0;    
                MemtoReg <= 0;
                StackOp <= 3'b000;
            end

            SUBI: begin
                BranchOp <= 3'b000;
                ALUOp <= 4'b0010;
                ALUSrc <= 1;
                MemR <= 0;
                MemW <= 0;
                RegW <= 1;
                RegDst <= 0;    
                MemtoReg <= 0;
                StackOp <= 3'b000;
            end

            ANDI: begin
                BranchOp <= 3'b000;
                ALUOp <= 4'b0011;
                ALUSrc <= 1;
                MemR <= 0;
                MemW <= 0;
                RegW <= 1;
                RegDst <= 0;    
                MemtoReg <= 0;
                StackOp <= 3'b000;
            end

            ORI: begin
                BranchOp <= 3'b000;
                ALUOp <= 4'b0100;
                ALUSrc <= 1;
                MemR <= 0;
                MemW <= 0;
                RegW <= 1;
                RegDst <= 0;    
                MemtoReg <= 0;
                StackOp <= 3'b000;
            end

            XORI: begin
                BranchOp <= 3'b000;
                ALUOp <= 4'b0101;
                ALUSrc <= 1;
                MemR <= 0;
                MemW <= 0;
                RegW <= 1;
                RegDst <= 0;    
                MemtoReg <= 0;
                StackOp <= 3'b000;
            end

            NOTI: begin
                BranchOp <= 3'b000;
                ALUOp <= 4'b0110;
                ALUSrc <= 1;
                MemR <= 0;
                MemW <= 0;
                RegW <= 1;
                RegDst <= 0;    
                MemtoReg <= 0;
                StackOp <= 3'b000;
            end

            SLAI: begin
                BranchOp <= 3'b000;
                ALUOp <= 4'b0111;
                ALUSrc <= 1;
                MemR <= 0;
                MemW <= 0;
                RegW <= 1;
                RegDst <= 0;    
                MemtoReg <= 0;
                StackOp <= 3'b000;
            end

            SRLI: begin
                BranchOp <= 3'b000;
                ALUOp <= 4'b1000;
                ALUSrc <= 1;
                MemR <= 0;
                MemW <= 0;
                RegW <= 1;
                RegDst <= 0;    
                MemtoReg <= 0;
                StackOp <= 3'b000;
            end

            SRAI: begin
                BranchOp <= 3'b000;
                ALUOp <= 4'b1001;
                ALUSrc <= 1;
                MemR <= 0;
                MemW <= 0;
                RegW <= 1;
                RegDst <= 0;    
                MemtoReg <= 0;
                StackOp <= 3'b000;
            end


            // I-type branch operations
            BR: begin
                BranchOp <= 3'b001;
                ALUOp <= 4'b0001;   // ADD is required
                ALUSrc <= 0;        // not relevant
                MemR <= 0;
                MemW <= 0;
                RegW <= 0;
                RegDst <= 0;    
                MemtoReg <= 0;
                StackOp <= 3'b000;
            end

            BPL: begin
                BranchOp <= 3'b010;
                ALUOp <= 4'b0001;   // ADD is required
                ALUSrc <= 0;        // not relevant
                MemR <= 0;
                MemW <= 0;
                RegW <= 0;
                RegDst <= 0;    
                MemtoReg <= 0;
                StackOp <= 3'b000;
            end

            BMI: begin
                BranchOp <= 3'b011;
                ALUOp <= 4'b0001;   // ADD is required
                ALUSrc <= 0;        // not relevant
                MemR <= 0;
                MemW <= 0;
                RegW <= 0;
                RegDst <= 0;    
                MemtoReg <= 0;
                StackOp <= 3'b000;
            end

            BZ: begin
                BranchOp <= 3'b100;
                ALUOp <= 4'b0001;   // ADD is required
                ALUSrc <= 0;        // not relevant
                MemR <= 0;
                MemW <= 0;
                RegW <= 0;
                RegDst <= 0;    
                MemtoReg <= 0;
                StackOp <= 3'b000;
            end


            // I-type load and store operations
            LD: begin
                BranchOp <= 3'b000;
                ALUOp <= 4'b0001;   // ADD is required
                ALUSrc <= 0;        // not relevant
                MemR <= 1;
                MemW <= 0;
                RegW <= 1;
                RegDst <= 0;    
                MemtoReg <= 1;
                StackOp <= 3'b000;
            end

            ST: begin
                BranchOp <= 3'b000;
                ALUOp <= 4'b0001;   // ADD is required
                ALUSrc <= 0;      // not relevant
                MemR <= 0;
                MemW <= 1;
                RegW <= 0;
                RegDst <= 0;    
                MemtoReg <= 0;
                StackOp <= 3'b000;
            end

            LDSP: begin
                BranchOp <= 3'b000;
                ALUOp <= 4'b0001;   // ADD is required
                ALUSrc <= 0;      // not relevant
                MemR <= 1;
                MemW <= 0;
                RegW <= 1;
                RegDst <= 0;    
                MemtoReg <= 1;
                StackOp <= 3'b000;
            end

            STSP: begin
                BranchOp <= 3'b000;
                ALUOp <= 4'b0001;   // ADD is required
                ALUSrc <= 0;      // not relevant
                MemR <= 0;
                MemW <= 1;
                RegW <= 0;
                RegDst <= 0;    
                MemtoReg <= 0;
                StackOp <= 3'b000;
            end

            // I-type move operation - check this
            MOVE: begin
                BranchOp <= 3'b000;
                ALUOp <= 4'1111;  // not relevant
                ALUSrc <= 0;      // not relevant
                MemR <= 0;
                MemW <= 0;
                RegW <= 1;
                RegDst <= 0;    
                MemtoReg <= 0;
                StackOp <= 3'b000;
            end

            // I-type stack operations + RET (miscellaneous)
            PUSH: begin
                BranchOp <= 3'b000;
                ALUOp <= 4'b1111; // not relevant
                ALUSrc <= 0;      // not relevant
                MemR <= 0;
                MemW <= 1;
                RegW <= 0;
                RegDst <= 0;
                MemtoReg <= 0;
                StackOp <= 3'b001;
            end

            POP: begin
                BranchOp <= 3'b000;
                ALUOp <= 4'b1111; // not relevant
                ALUSrc <= 0;      // not relevant
                MemR <= 1;
                MemW <= 0;
                RegW <= 1;
                RegDst <= 0;
                MemtoReg <= 1;
                StackOp <= 3'b010;
            end

            CALL: begin
                BranchOp <= 3'b000;
                ALUOp <= 4'b1111; // not relevant
                ALUSrc <= 1;      
                MemR <= 0;
                MemW <= 1;
                RegW <= 0;
                RegDst <= 0;
                MemtoReg <= 0;
                StackOp <= 3'b011;
            end

            RET: begin
                BranchOp <= 3'b000;
                ALUOp <= 4'b1111; // not relevant
                ALUSrc <= 0;      // not relevant
                MemR <= 1;
                MemW <= 0;
                RegW <= 0;
                RegDst <= 0;
                MemtoReg <= 1;
                StackOp <= 3'b100;
            end

            // HALT, NOP
            default: begin
                BranchOp <= 3'b000;
                ALUOp <= 4'b0000;
                ALUSrc <= 0;
                MemR <= 0;
                MemW <= 0;
                RegW <= 0;
                RegDst <= 0;
                MemtoReg <= 0;
                StackOp <= 3'b000;
            end

        endcase
    end
endmodule