module booth_multiplier(M, Q, clk, out);
    input [7:0] M, Q;
    input clk; 
    output reg [15:0] out;

    reg signed [7:0] A = 8'b0;
    reg Q_1 = 1'b0;

    reg signed [7:0] Q_reg, M_reg; 

    reg [3:0] count = 4'b0; 

    wire signed [7:0] sum, diff, A_shift, Q_shift;
    wire [16:0] shift;
    wire Q_1_shift;

    adder a0 (A, M_reg, 1'b0, sum);
    subtractor s0 (A, M_reg, 1'b1, diff);
    // shifter sh0 (A, Q_reg, Q_1, A_shift, Q_shift, Q_1_shift, shift);
    
    always @(Q or M) begin
        Q_reg <= Q;
        M_reg <= M;
    end

    always @ (posedge clk) begin
        $display("A = %d, M_reg = %d, sum = %d, diff = %d", A, M_reg, sum, diff);
        
        case ({Q_reg[0], Q_1})
            2'b0_1 : {A, Q_reg, Q_1} <= {sum[7], sum, Q_reg};
            2'b1_0 : {A, Q_reg, Q_1} <= {diff[7], diff, Q_reg};
            default: {A, Q_reg, Q_1} <= {A[7], A, Q_reg};
        endcase
        // if (Q_reg[0] == 1'b1 && Q_1 == 1'b0) begin 
        //     A = diff;
        // end
        // else if (Q_reg[0] == 1'b0 && Q_1 == 1'b1) begin
        //     A = sum;
        // end
        
        // now arithmetic right shift

        // Q_reg = {A[0], Q_reg[7:1]};
        // A = {A[7], A[7:1]};
        // Q_1 = Q_reg[0];

        count <= count + 1'b1;
        $display("count = %d", count);

        if (count == 4'b1000)
        begin
            $display("A = %b, Q_reg = %b", A, Q_reg);
            out <= {A, Q_reg};
            $finish;
        end
        
    end

endmodule


module CLA4bit(A, B, Cin, Cout, sum);
    input [3:0] A,B;
    input Cin;
    output [3:0] sum;
    output Cout;

    wire [3:0] G, P, C;

    assign G = A & B;
    assign P = A ^ B;

    assign C[0] = Cin;
    assign C[1] = G[0] | (P[0] & C[0]);
    assign C[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & C[0]);
    assign C[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & C[0]);   

    assign Cout = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]) | (P[3] & P[2] & P[1] & P[0] & C[0]);

    assign sum = P ^ C;
endmodule

module adder(A, B, Cin, sum); 
    input [7:0] A,B;
    input Cin;
    output [7:0] sum;

    wire Cout;
    wire Cout1;

    CLA4bit c0(A[3:0], B[3:0], Cin, Cout1, sum[3:0]);
    CLA4bit c1(A[7:4], B[7:4], Cout1, Cout, sum[7:4]);
endmodule

module subtractor(A, B, Cin, diff);
    input [7:0] A,B;
    input Cin;
    output [7:0] diff;

    wire [7:0] Bcomp;
    assign Bcomp = ~B;

    adder a0(A, Bcomp, Cin, diff);

endmodule