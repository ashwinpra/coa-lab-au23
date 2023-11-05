// Module to control stack operations

module SP_control(StackOp, clk, rst, SPin, SPout, MemSP);
    input [2:0] StackOp;
    input clk, rst; 
    input [31:0] SPin;
    output reg [31:0] SPout;
    output reg [31:0] MemSP; // the value of SP that will be used to access memory

    wire [3:0] funct;
    // in push and call, funct = 2 (SUB)
    // in pop and ret, funct = 1 (ADD)
    assign funct = (StackOp == 1 || StackOp == 3) ? 2 : 1;

    wire [31:0] tempSP;

    // alu (a,b,shamt,funct,clk,res);
    alu StackALU (
        .a(SPin),
        .b(1),
        .shamt(5'b0),
        .funct(funct),
        .clk(clk),
        .res(tempSP)
    );

    // initial $display("SP_control called");

    always @(posedge clk) begin
        if (rst) begin
            SPout <= 0;
        end
        else begin
            case (StackOp)
                // 000 -> PUSH
                3'b001: begin
                    SPout <= tempSP;
                    MemSP <= tempSP; // Mem [SP] <= R[Rs]
                end

                // 001 -> POP
                3'b010: begin
                    MemSP <= SPin; // LMD <= Mem [SP]
                    SPout <= tempSP;
                end

                // 011 -> CALL
                3'b010: begin
                    SPout <= tempSP;
                    MemSP <= tempSP; // Mem [SP] <= NPC (PC + 1)
                    // PC <= ALUOut - done in PC_control
                end

                // 100 -> RET
                3'b011: begin
                    MemSP <= SPin; // LMD <= Mem [SP]
                    SPout <= tempSP;
                end
            endcase
        end
    end




    
endmodule