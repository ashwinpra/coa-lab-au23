module reg2mem_tb;
    reg clk;
    reg [9:0] opcode;
    wire [3:0] res;

    reg2mem reg2mem (
        .clk(clk),
        .opcode(opcode),
        .res(res)
    );

    always #5 clk = ~clk;

    initial begin
        opcode = 10'b0010100101;
        clk = 0;
        $monitor("opcode = %d, addr1 = %d, addr2 = %d, res = %d", opcode[9:8], opcode[7:4], opcode[3:0], res);
       
        #100 opcode = 10'b1001000101;
        #100 opcode = 10'b0101001011;
        #100 opcode = 10'b1100001011;
       
        #10000 $finish;
//        // storing value 10 in memory location 5 -> 00 1010 0101
//        opcode = 10'b0010100101;
//        #20;
//        $display("OP 00, res = %d", res);
//        #20;
       
//        // storing to register number 4 the value in memory location 5 -> 10 0100 0101
//        opcode = 10'b1001000101;
//        #20;
//        $display("OP 10, res = %d", res);
//        #20;
       
//        // storing in memory location 11 the value in register number 4 -> 01 0100 1011
//        opcode = 10'b0101001011;
//        #20;
//        $display("OP 01, res = %d", res);
//        #20;
       
//        // loading the value in memory location 11 -> 11 0000 1011
//        opcode = 10'b1100001011;
//        #20;
//        $display("OP 11, res = %d", res);
//        #20;
       
    end

endmodule