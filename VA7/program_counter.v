// Program counter module

module program_counter(PCin, updatePC, reset, clk, PCout);
    input [31:0] PCin;
    input updatePC;
    input reset,clk;
    output reg [31:0] PCout;

    always @(posedge clk)
    begin
        if(reset) 
            PCout <= 0;
        else if (updatePC) begin
            $display("UPDATING PC");
            PCout <= PCin;
        end
    end
endmodule