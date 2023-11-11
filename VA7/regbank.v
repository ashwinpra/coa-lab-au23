// Register bank 

module regbank(ins, rData1, rData2, wrData, Rs, Rt, Rd, reset, RegW, clk);
    input [31:0] ins;
    input clk, RegW, reset;
    input [4:0] Rs, Rt, Rd;
    input [31:0] wrData;
    
    output signed [31:0] rData1, rData2;
    
    reg signed [31:0] regfile[0:16]; // R0 - R15 + SP
    
    assign rData1 = regfile[Rs];
    assign rData2 = regfile[Rt];

    initial begin 
        regfile[0] <= 0;  regfile[1] <= 0;   regfile[2] <= 0;  regfile[3] <= 0;
        regfile[4] <= 0;  regfile[5] <= 0;   regfile[6] <= 0;  regfile[7] <= 0;
        regfile[8] <= 0;  regfile[9] <= 0;   regfile[10] <= 0; regfile[11] <= 0;
        regfile[12] <= 0; regfile[13] <= 0;  regfile[14] <= 0; regfile[15] <= 0; regfile[16] <= 1023;
    end
    
    always @(posedge clk) begin
        regfile[0] <= 0;
        // $monitor("ins = %b, reg[%d] = %d, reg[%d] = %d", ins, Rs, rData1, Rt, rData2);
        $monitor("rf[0] = %d, rf[1] = %d, rf[2] = %d, rf[3] = %d, rf[4] = %d, rf[5] = %d, SP = %d", regfile[0], regfile[1], regfile[2], regfile[3], regfile[4], regfile[5], regfile[16]);
        // $monitor("SP = %d", regfile[16]);
        // $monitor("regfile[0] = %d, regfile[1] = %d, regfile[2] = %d, regfile[3] = %d", regfile[0], regfile[1], regfile[2], regfile[3]);
        // $monitor("regfile[4] = %d", regfile[4]);
        // $monitor("regfile[2] = %d", regfile[2]);
        // $monitor("ins = %b, Rs = %d, Rt = %d, Rd = %d, wrData = %d", ins, Rs, Rt, Rd, wrData);
        if (reset) begin
            regfile[0] <= 0;  regfile[1] <= 0;   regfile[2] <= 0;  regfile[3] <= 0;
            regfile[4] <= 0;  regfile[5] <= 0;   regfile[6] <= 0;  regfile[7] <= 0;
            regfile[8] <= 0;  regfile[9] <= 0;   regfile[10] <= 0; regfile[11] <= 0;
            regfile[12] <= 0; regfile[13] <= 0;  regfile[14] <= 0; regfile[15] <= 0; regfile[16] <= 1023;
        end
        if (RegW) begin
            // $display("writing %d to reg[%d]", wrData, Rd);
            regfile[Rd] <= wrData;
        end
    end
endmodule