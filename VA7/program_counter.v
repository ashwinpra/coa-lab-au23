// Program counter module

module program_counter(pc_in,reset,clk,pc_out);
input [31:0] pc_in;
input reset,clk;
output reg [31:0] pc_out;

always @(posedge clk)
begin
    if(reset)
        pc_out <= 0;
    else
        pc_out <= pc_in;
end
endmodule