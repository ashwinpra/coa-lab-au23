module testbench;
reg clk = 0;
reg rst; 
wire [31:0] out; 


risc KGPRISC(
    .clk(clk),
    .rst(rst),
    .out(out)
); 

localparam CLK_PERIOD = 10;
always #(CLK_PERIOD/2) clk=~clk;

initial begin
    $display("Starting testbench");
    // #10 rst = 1;
    // #10 rst = 0;


    // $monitor("out = %d", out);  

    #100000000
    $finish;
end

endmodule