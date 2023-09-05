`timescale 10ns/1ns

module testbench; 
    reg in, reset; 
    reg clk = 1'b1;
    wire out; 



    always #4 clk = ~clk; 

    mo3detector uut (
        .in(in), 
        .clk(clk), 
        .reset(reset), 
        .out(out)
    );

    initial 
    begin
        $display("TC 1\n");
		reset = 1'b1; in = 1'b0;
		#4 reset = 1'b0; 
		#4		
		#8 in = 1'b0;
		#8 in = 1'b0;
		#8 in = 1'b0;
		#8 in = 1'b1;
		#8 in = 1'b0;
		#8 in = 1'b1;
		#8 in = 1'b1;
		#8 in = 1'b1;
		#8 in = 1'b0;
		#8 in = 1'b1;
		#8 in = 1'b0;
		#8 in = 1'b0;
		#8 in = 1'b0;
		
		#8
		$display("TC 2\n");
		reset = 1'b1; in = 1'b0;
		#4 reset = 1'b0; 
		#4
		#8 in = 1'b1;
		#8 in = 1'b1;
		#8 in = 1'b1;
		#8 in = 1'b1;
		#8 in = 1'b1;
		
		#8
		$display("TC 3\n");
		reset = 1'b1; in = 1'b0;
		#4 reset = 1'b0; 
		#4
		#8 in = 1'b0;
		#8 in = 1'b0;
		#8 in = 1'b0;
		#8 in = 1'b0;
		#8 in = 1'b0;
		
		#8
		$display("TC 4\n");
		reset = 1'b1; in = 1'b0;
		#4 reset = 1'b0; 
		#4
		#8 in = 1'b0;
		#8 in = 1'b0;
		#8 in = 1'b0;
		#8 in = 1'b1;
		#8 in = 1'b0;

        #8 $finish;
    
    end
   	    always #8 $monitor($time,"\t in = %b \t out = %b", in, out);

endmodule