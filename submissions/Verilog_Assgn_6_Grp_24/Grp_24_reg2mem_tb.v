// Verilog Assignment 6, Question 1 
// TESTBENCH for REG2MEM module
// Autumn Semester 2023-24 (Semester 5)
// Group No. 24 
// Gorantla Thoyajakshi - 21CS10026
// Ashwin Prasanth - 21CS30009

module reg2mem_tb;
    reg clk; 
    reg [9:0] instruction;
    wire [3:0] res;

    reg2mem reg2mem (
        .clk(clk),
        .instruction(instruction),
        .res(res)
    );

    always #5 clk = ~clk;

    initial begin 
        clk = 0;
        // storing value 10 in memory location 5 -> 00 1010 0101
        instruction = 10'b0010100101;
        #20;
        $display("Operation: STORE_DATA\n Stored value %d in address %d", instruction[7:4], instruction[3:0]);
        #20;
        
        // storing to register number 4 the value in memory location 5 -> 10 0100 0101
        instruction = 10'b1001000101;
        #20;
        $display("Operation: MOVE_FROM_MEM\n Stored value in mem address %d to register %d", instruction[3:0], instruction[7:4]);
        #20; 
        
        // storing in memory location 11 the value in register number 4 -> 01 0100 1011
        instruction = 10'b0101001011;
        #20;
        $display("Operation: MOVE_TO_MEM\n Stored value in register %d to mem address %d", instruction[7:4], instruction[3:0]);
        #20; 
        
        // loading the value in memory location 11 -> 11 0000 1011
        instruction = 10'b1100001011;
        #20;
        $display("Operation: LOAD_DATA\n Loaded data = %d from mem address %d", res, instruction[3:0]);
        #20; 
        
        #100 $finish;
        
    end

endmodule
