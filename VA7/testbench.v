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
    $dumpfile("tb_ControlUnit.vcd");
    $dumpvars(5, testbench);


    $display("Starting testbench");
    #10 rst = 1;
    #40 rst = 0;


    // $monitor("out = %d", out);  

    #100000
    $finish;
end

endmodule