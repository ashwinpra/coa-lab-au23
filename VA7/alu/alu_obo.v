module alu_obo(in,btn,rst,clk,out);
    input [15:0] in;
    input btn;
    input rst;
    input clk;
    output reg signed [15:0] out;

    reg signed [31:0] a,b;
    reg [4:0] shamt;
    reg [3:0] funct;
    reg [2:0] state;

    wire signed [31:0] res;

    initial begin 
        a = 0; 
        b = 0; 
        shamt = 0;
        funct = 0;
        state = 0;
        out = 0;
    end

    alu a_0(a,b,shamt,funct,clk,res);

    always @(posedge clk)
    begin
        $display($time, " res = %d",res);
        case(state)
            0: a[15:0] <= in;
            1: a[31:16] <= in;
            2: begin
                // $display($time, " a = %d",a);
                b[15:0] <= in;
            end
            3: b[31:16] <= in;
            4: begin
                shamt <= in[4:0];
                // $display($time, " b = %d",b);
            end
            5: funct <= in[3:0];
            6: begin
                // $display($time, " res = %d",res);
                out = res[15:0];
                // $display($time, " out = %d",out);
            end
            7: begin 
                // $display($time, " res = %d",res);
                out = res[31:16];
                // $display($time, " out = %d",out);
            end
        endcase
        if (btn)
            state <= state + 1;
        if (state == 7)
            state <= 0;
    end

    always @(posedge rst) begin
        state <= 0;
        a <= 0;
        b <= 0;
        shamt <= 0;
        funct <= 0;
        out <= 0;
    end
endmodule

