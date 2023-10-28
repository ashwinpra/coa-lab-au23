module data_memory( mem_write, mem_read,address,data_input,clk,reset,data_output);
    input mem_write, mem_read;
    input [31:0] address,data_input;
    input clk,reset;
    output [31:0] data_output;
    reg [31:0] data [0:1023];
    integer i;
    initial
    begin
        for(i=0;i<1024;i=i+1)
            data[i] = 0;
    end
    always @(posedge clk)
    begin
        if(reset)
            data_output <= 0;
        else if(mem_read)
            data_output <= data[address];
        else if(mem_write)
            data[address] <= data_input;
    end
    
endmodule