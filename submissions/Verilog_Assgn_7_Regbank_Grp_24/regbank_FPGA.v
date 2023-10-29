module regbank_FPGA(in, out, btn, reset, clk);

    input [15:0] in;
    input btn, clk, reset;
    output reg [15:0] out;

    reg reg_reset;
    reg write; 
    reg [4:0] sr1, sr2, dr;
    wire signed [31:0] rData1, rData2;

    reg [4:0] shamt; 
    reg [5:0] funct;
    wire signed [31:0] ALUout;

    reg [4:0] state;

    regbank REG(rData1, rData2, ALUout, sr1, sr2, dr, reg_reset, write, clk);
    alu ALU(rData1,rData2,shamt,funct,clk,ALUout);

    wire pe;
    pos_edge_det detector(btn,clk,pe);

    
    always @(posedge clk) begin
        if (pe) begin
            case (state) 
                0: begin
                    // ALU operation - get Rs , Rt and Rd 
                    sr1 <= in[15:11]; // Rs
                    sr2 <= in[10:6]; // Rt 
                    dr <= in[5:1]; // Rd

                    out <= 1;
                    state <= 1;
                end
                1: begin
                    write <= 0;

                    // get shamt and funct
                    shamt <= in[15:11];
                    funct <= in[10:6];

                    out <= 2;
                    state <= 2; 
                end
                2: begin
                    write <= 1;
                    
                    // display LSB of ALU output
                    out <= ALUout[15:0];
                    state <= 3;
                end
                3: begin
                    write <= 0;
                    // display MSB of ALU output
                    out <= ALUout[31:16];
                    state <= 0;
                end
            endcase
            if (reset) begin
                state <= 0;
                sr1 <= 0;
                sr2 <= 0;
                dr <= 0;
                write <= 0;
            end
        end
    end
endmodule

module pos_edge_det (sig, clk, pe); 
    input sig, clk; 
    output pe;     
    reg sig_dly; 

    always @ (posedge clk) begin
        sig_dly <= sig;
    end
    
    assign pe = sig & ~sig_dly;
endmodule