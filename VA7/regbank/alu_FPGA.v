module pos_edge_det (sig, clk, pe); 
    input sig, clk; 
    output pe;     
    reg sig_dly; // Internal signal to store the delayed version of signal

   // This always block ensures that sig_dly is exactly 1 clock behind sig
    always @ (posedge clk) begin
        sig_dly <= sig;
    end
    
   // Combinational logic where sig is AND with delayed, inverted version of sig
   // Assign statement assigns the evaluated expression in the RHS to the internal net pe
    assign pe = sig & ~sig_dly;
endmodule

module alu_FPGA(in,btn,rst,clk,outp);
    input [15:0] in;
    input btn;
    input rst;
    input clk;
    output reg signed [15:0] outp;

    reg signed [31:0] a_in,b_in;
    reg [4:0] shamt_in;
    reg [3:0] funct_in;
    reg [2:0] state;
    
    wire pe;

    wire signed [31:0] res;
    
    pos_edge_det detector(btn,clk,pe);

    initial begin 
        a_in = 0; 
        b_in = 0; 
        shamt_in = 0;
        funct_in = 0;
        state = 0;
        outp = 0;
    end

    alu a_0(a_in,b_in,shamt_in,funct_in,clk,res);

    always @(posedge clk)
    begin
        $display("%d", pe); 
        if(pe) begin
        case(state)
            0: begin 
                a_in[15:0] <= in;
                outp <= 1; 
                end
            1: begin 
                a_in[31:16] <= in;
                outp <= 2; 
            end
            2: begin
                // $display($time, " a = %d",a);
                b_in[15:0] <= in;
                outp <= 3; 
            end
            3: begin 
                b_in[31:16] <= in;
                outp <= 4;
            end
            4: begin
                shamt_in <= in[4:0];
                // $display($time, " b = %d",b);
                outp <= 5; 
            end
            5: begin
                funct_in <= in[3:0];
                outp <= 6; 
            end
            6: begin
                // $display($time, " res = %d",res);
                outp <= res[15:0];
                // $display($time, " out = %d",out);
            end
            7: begin 
                // $display($time, " res = %d",res);
                outp <= res[31:16];
                // $display($time, " out = %d",out);
            end
        endcase
        if (btn)
            state <= state + 1;
        if (state == 7)
            state <= 0;
       if(rst) begin 
            state <= 0;
            a_in <= 0;
            b_in <= 0;
            shamt_in <= 0;
            funct_in <= 0;
            outp <= 0;
         end
        end
    end

//    always @(posedge rst) begin
//        state <= 0;
//        a_in <= 0;
//        b_in <= 0;
//        shamt_in <= 0;
//        funct_in <= 0;
//        outp <= 0;
//    end
endmodule

