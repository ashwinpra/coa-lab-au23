// Module to control branch operations

module branch_control(BranchOp, PCin, rst, clk, PCout);
    input [2:0] BranchOp;
    input [31:0] PCin;
    input rst, clk;
    output reg [31:0] PCout;

    always @(posedge clk) begin
        if (rst) begin
        end

        else begin
            case (BranchOp)
               // 001 -> BR (unconditional branch)
                3'b001: begin
                    
                end

            endcase 
        end


        end

endmodule