// Program counter module

module program_counter(PCin, updatePC, reset, clk, PCout);
    input [31:0] PCin;
    input updatePC;
    input reset,clk;
    output reg [31:0] PCout;

    always @(posedge clk)
    begin
        if(reset) begin
            PCout <= 0;
        end
        else if (updatePC) begin
            $display("UPDATING PC to %d", PCin);
            PCout <= PCin;
        end
    end
endmodule