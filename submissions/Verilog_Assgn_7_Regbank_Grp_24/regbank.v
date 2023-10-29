module regbank(rData1, rData2, wrData, sr1, sr2, dr, reset, write, clk);
    input clk, write, reset;
    input [4:0] sr1, sr2, dr;
    input [31:0] wrData;
    
    output [31:0] rData1, rData2;
    
    reg [31:0] regfile[0:17]; // R0 - R15 + SP + PC
    
    assign rData1 = regfile[sr1];
    assign rData2 = regfile[sr2];

//     hardcoding values for testing
    initial begin
        regfile[1] <= 50000; 
        regfile[2] <= 100000;
        regfile[3] <= 150000;
        regfile[4] <= 200000;
        regfile[5] <= 250000;
        regfile[6] <= 300000;
        regfile[7] <= 350000;
        regfile[8] <= 400000;
    end

//    initial begin
//        regfile[0] <= 32'h00000000;  regfile[1] <= 32'h00000000;   regfile[2] <= 32'h00000000;  regfile[3] <= 32'h00000000;
//        regfile[4] <= 32'h00000000;  regfile[5] <= 32'h00000000;   regfile[6] <= 32'h00000000;  regfile[7] <= 32'h00000000;
//        regfile[8] <= 32'h00000000;  regfile[9] <= 32'h00000000;   regfile[10] <= 32'h00000000; regfile[11] <= 32'h00000000;
//        regfile[12] <= 32'h00000000; regfile[13] <= 32'h00000000;  regfile[14] <= 32'h00000000; regfile[15] <= 32'h00000000;
//        regfile[16] <= 32'h00000000; regfile[17] <= 32'h00000000;  
//    end
    
    always @(posedge clk) begin
        if (reset) begin
            regfile[0] <= 32'h00000000;  regfile[1] <= 32'h00000000;   regfile[2] <= 32'h00000000;  regfile[3] <= 32'h00000000;
            regfile[4] <= 32'h00000000;  regfile[5] <= 32'h00000000;   regfile[6] <= 32'h00000000;  regfile[7] <= 32'h00000000;
            regfile[8] <= 32'h00000000;  regfile[9] <= 32'h00000000;   regfile[10] <= 32'h00000000; regfile[11] <= 32'h00000000;
            regfile[12] <= 32'h00000000; regfile[13] <= 32'h00000000;  regfile[14] <= 32'h00000000; regfile[15] <= 32'h00000000;
            regfile[16] <= 32'h00000000; regfile[17] <= 32'h00000000;  
        end
        if (write) begin
            regfile[dr] <= wrData;
        end
    end
endmodule