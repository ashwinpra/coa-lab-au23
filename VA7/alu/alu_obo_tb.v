module testbench; 

    reg [15:0] in; 
    reg btn = 0;
    reg rst = 0;
    reg clk = 0;
    wire [15:0] out;

    alu_obo alu(in,btn,rst,clk,out);

    parameter 
        ADD = 0,
        SUB = 1,
        AND = 2,
        OR = 3,
        XOR = 4,
        NOT = 5,
        SLA = 6,
        SRA = 7, 
        SRL = 8;

    always #5 clk = ~clk;

    initial 
    begin 
        // try 100(a) - 200(b)
        // set 16 LSB of a
        #10 in = 200; btn = 1;
        $display($time, " in_a_LSB = %b",in);
        #10 btn = 0;
        // set 16 MSB of a
        #10 in = 0; btn = 1;
        $display($time, " in_a_MSB = %b",in);
        #10 btn = 0;
        // set 16 LSB of b
        #10 in = 100; btn = 1;
        $display($time, " in_b_LSB = %b",in);
        #10 btn = 0;
        // set 16 MSB of b
        #10 in = 0; btn = 1;
        $display($time, " in_b_MSB = %b",in);
        #10 btn = 0;
        // set shamt to 0
        #10 in = 0; btn = 1;
        $display($time, " shamt = %b",in);
        #10 btn = 0;
        // set funct to SUB
        #10 in = 1; btn = 1;
        $display($time, " funct = %b",in);
        #10 btn = 0;
        // show 16 LSB of out
        #20 in = 0; btn = 1;
        $display($time, " out_LSB = %b",out);
        #10 btn = 0;
        // show 16 MSB of out
        #10 in = 0; btn = 1;
        $display($time, " out_MSB = %b",out);
        #10 btn = 0;
        #10 $finish;
    end

endmodule