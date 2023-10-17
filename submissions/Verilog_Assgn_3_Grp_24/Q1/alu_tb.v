`timescale 10ns / 1ns


module alu_tb; 
    reg [7:0] a,b;
    reg [2:0] func;
    wire [7:0] result;
    wire Cout;

    reg clk;
    initial clk = 0; 
    always #5 clk = ~clk;

    alu alu1(a, b, func, result, Cout);
    
    initial 
        begin
            a = 75; 
            b = 61;
            func = 0;
        end
    
    always @(posedge clk) 
        begin
            if(func ==0) 
                $display("a = %d, b = %d, func = %d, result = %d, Cout = %d", a, b, func, result, Cout);
            else if (func == 1 )
                $display("a = %d, b = %d, func = %d, result = %d, Bout = %d", a, b, func, result, Cout);
            else $display("a = %d, b = %d, func = %d, result = %d", a, b, func, result);

            func = func + 1;

            if(func == 8) 
                #10 $finish;
        end
        

            
endmodule

