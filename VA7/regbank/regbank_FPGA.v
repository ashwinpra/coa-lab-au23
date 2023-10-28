module pos_edge_det (sig, clk, pe); 
    input sig, clk; 
    output pe;     
    reg sig_dly; 

    always @ (posedge clk) begin
        sig_dly <= sig;
    end
    
    assign pe = sig & ~sig_dly;
endmodule


module regbank_FPGA(in, out, btn, reset, clk);

    input [15:0] in;
    input btn, clk, reset;
    output reg [15:0] out;

    reg write; 
    reg [4:0] sr1, sr2, dr;
    reg signed [31:0] wrData;
    wire signed [31:0] rData1, rData2;

    reg [4:0] shamt; 
    reg [5:0] funct;
    wire signed [31:0] ALUout;

    reg [4:0] state;

    regbank REG(rData1, rData2, wrData, sr1, sr2, dr, reset, write, clk);
    alu ALU(rData1,rData2,shamt,funct,clk,ALUout);

    // pos_edge_det detector(btn,clk,pe);

    
    always @(posedge clk) begin
        // $display($time, " pe = %d", pe);
        // if (pe) begin
            $display($time, "-------------dr = %d----------------", dr);
            case (state) 
                0: begin
                    $display($time, " state 0, in = %b", in);
                    // first get register to write to
                    dr <= in[4:0];

                    out <= 1;
                end
                1: begin
                    $display($time, " state 1, got register 1 number = %d, in = %b", dr, in);
                    // get LSB of data to write
                    wrData[15:0] <= in;

                    out <= 2;
                end
                2: begin
                    $display($time, " state 2, got LSB of data = %d, in = %b", wrData[15:0], in);
                    // get MSB of data to write
                    wrData[31:16] <= in;

                    out <= 3;
                end
                3: begin
                    $display($time, " state 3, got MSB of data = %d, in = %b", wrData[31:16], in);
                    write <= 1;

                    // 2nd register write
                    dr <= in[4:0];

                    out <= 4;
                end
                4: begin
                    $display($time, " state 4, got register 2 number = %d, in = %b", dr, in);
                    write <= 0;

                    // get LSB of data to write
                    wrData[15:0] <= in;

                    out <= 5;
                end
                5: begin
                    $display($time, " state 5, got LSB of data = %d, in = %b", wrData[15:0], in);
                    // get MSB of data to write
                    wrData[31:16] <= in;

                    out <= 6;
                end
                6: begin
                    $display($time, " state 6, got MSB of data = %d, in = %b", wrData[31:16], in);
                    write <= 1;

                    // now ALU operation - get Rs , Rt and Rd 
                    sr1 <= in[15:11]; // Rs
                    sr2 <= in[10:6]; // Rt 
                    dr <= in[5:1]; // Rd

                    out <= 7;
                end
                7: begin
                    $display($time, " state 7, got Rs = %d, Rt = %d, Rd = %d, in = %b", sr1, sr2, dr, in);
                    write <= 0;

                    // get shamt and funct
                    shamt <= in[15:11];
                    funct <= in[10:6];

                    out <= 8;
                end
                8: begin
                    $display($time, " reg[Rs] = %d, reg[Rt] = %d", rData1, rData2);
                    $display($time, " state 8, got shamt = %d, funct = %d, in = %b", shamt, funct, in);
                    // display LSB of ALU output
                    out <= ALUout[15:0];
                end
                9: begin
                    $display($time, " state 9, done?, in = %b", in);
                    // display MSB of ALU output
                    out <= ALUout[31:16];
                end
            endcase
            if (btn) begin
                state <= state + 1;
            end
            if (state == 9) begin
                state <= 0;
            end
            if (reset) begin
                state <= 0;
                sr1 <= 0;
                sr2 <= 0;
                dr <= 0;
                wrData <= 0;
                write <= 0;
            end
        end
    // end
endmodule