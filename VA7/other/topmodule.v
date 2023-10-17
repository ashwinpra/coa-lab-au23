module topmodule(ins, clk, out);
    input [31:0] ins; 
    input clk;
    
    output reg [31:0] out;
                            
    wire [31:0] rData1, rData2, wrData; 
    assign wrData = out;
    regbank REG(rData1, rData2, wrData, ins[25:21], ins[20:16], ins[15:11], reset, write, clk);
    alu ALU(rData1,rData2,ins[10:6],ins[5:0],clk,out);

endmodule