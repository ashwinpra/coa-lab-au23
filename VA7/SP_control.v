// Module to control stack 

module SP_control(StackOp, clk, rst, SPin, SPout, MemSP); 
    input [2:0] StackOp; 
    input clk, rst;
    input [31:0] SPin; // will be obtained from Rs/Rt
    output reg [31:0] SPout; // will be used to update SP 
    output reg [31:0] MemSP; // will be used to update memory

    // wire [3:0] funct;
    // in push and call, funct = 2 (SUB)
    // in pop and ret, funct = 1 (ADD)
    // assign funct = (StackOp == 1 || StackOp == 3) ? 2 : 1;

    wire [31:0] tempSP;

    // // to do SP +/- 1
    // alu StackALU (
    //     .a(SPin),
    //     .b(1),
    //     .shamt(5'b1),
    //     .funct(funct),
    //     .clk(clk),
    //     .res(tempSP)
    // ); 

        always @(posedge clk) begin
        if (rst) begin
            SPout <= 0;
        end
        else begin
            case (StackOp)
                // 001 -> PUSH
                3'b001: begin
                    SPout <= SPin - 1;
                    MemSP <= SPin - 1; // Mem [SP] <= R[Rs]
                end

                // 010 -> POP
                3'b010: begin
                    MemSP <= SPin; // LMD <= Mem [SP]
                    SPout <= SPin + 1;
                end

                // 011 -> CALL
                3'b011: begin
                    SPout <= SPin - 1;
                    MemSP <= SPin - 1; // Mem [SP] <= NPC (PC + 1)
                    // PC <= ALUOut - done in PC_control
                end

                // 100 -> RET
                3'b100: begin
                    MemSP <= SPin; // LMD <= Mem [SP]
                    SPout <= SPin + 1;
                end
            endcase
        end
    end


endmodule