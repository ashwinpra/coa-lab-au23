module testbench; 
// regbank_FGPA(in, out, btn, reset, clk);
    reg [15:0] in;
    reg btn, reset, clk;

    wire [15:0] out;

    initial begin
        clk = 0; 
    end
    always #5 clk = ~clk;

    regbank_FPGA REGFPGA(in, out, btn, reset, clk);

    initial begin
        #20 reset = 1;
        #20 reset = 0;

        // write 10 to register 1

        // register number
        #10 in  = 1; 
        #10 btn  = 1;
        #10 btn  = 0;  

        // LSB of data
        #10 in  = 10;
        #10 btn  = 1;
        #10 btn  = 0;  

        // MSB of data
        #10 in  = 0; 
        #10 btn  = 1;
        #10 btn  = 0;  

        // write 20 to register 2

        // register number
        #10 in  = 2;
        #10 btn  = 1;
        #10 btn  = 0;  

        // LSB of data
        #10 in  = 20;
        #10 btn  = 1;
        #10 btn  = 0;   

        // MSB of data
        #10 in  = 0;
        #10 btn  = 1;
        #10 btn  = 0;   

        // give register numbers -> sr1 = 1, sr2 = 2, dr = 3 -> denote in 16 bits as 00001 00010 00011
        #10 in  = 16'b0000100010000110;
        #10 btn  = 1;
        #10 btn  = 0;   

        // give shamt and funct -> shamt = 0, funct = 0 (ADD)
        #10 in  = 0;
        #10 btn  = 1;
        #10 btn  = 0;   

        // display LSB of result
        #20 $display("Result LSB: %b", out);
        #10 btn  = 1;
        #10 btn  = 0;   

        // display MSB of result
        #20 $display("Result MSB: %b", out);
        #10 btn  = 1;
        #10 btn  = 0;   

        #20 $finish;
    end

endmodule