module testbench;
    reg [4:0] sr1, sr2,dr;
    reg [31:0] wrData;
    reg write, reset, clk;
    wire [31:0] rData1, rData2;
    
    regbank REG(rData1, rData2, wrData, sr1, sr2, dr, reset, write, clk);
    
    initial clk = 1;
    
    always #5 clk = ~clk;
    
    initial 
        begin 
            $display("starting..."); 
            #1 reset = 1; write = 0;
            #25 reset = 0;
            #25 dr = 1; wrData = 10; write = 1;
            #25 write = 0; 
            #25 $display("wrote to reg 1");
            #25 sr1 = 1; 
            #25 $display("read data = %d", rData1); 
            #100 $finish;
        end
endmodule
