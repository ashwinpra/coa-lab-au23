module booth_multiplier(M, Q, clk, start, out);
    input [7:0] M, Q;
    input clk, start;
    output  [15:0] out;

    reg signed [7:0] A;
    reg Q_1;
    reg signed [7:0] Q_reg, M_reg;
    reg [3:0] count;

    wire signed [7:0] sum, diff;
    wire signed [16:0] shift;

    assign out = {A, Q_reg};

    adder a (A, M_reg, 1'b0, sum);
    subtractor s (A, M_reg, 1'b1, diff);
    shifter sh (A, Q_reg, Q_1, shift);

    always @(posedge clk) begin
        if(start) begin
            Q_reg <= Q;
            M_reg <= M;
            A <= 8'b0;
            Q_1 <= 1'b0;
            count <= 4'b0;
        end
        else begin
            $display("sum = %d, diff = %d, A = %d, M = %d", sum, diff, A, M_reg);
            case ({Q_reg[0], Q_1})
                2'b0_1 : begin
                    A = sum;
                    // $display("A = %d after sum", A);
                end
                2'b1_0 : begin
                    A = diff; 
                    // $display("A = %d after diff", A);
                end
                default: begin
                    A = A;
                end
            endcase

            $display("(A,Q,Q_1) = %b, shift = %b", {A,Q,Q_1}, shift);
            A = shift[16:9];
            Q_reg = shift[8:1];
            Q_1 = shift[0];

            // case ({Q_reg[0], Q_1})
            //     2'b0_1 : {A, Q_reg, Q_1} <= {sum[7], sum, Q_reg};
            //     2'b1_0 : {A, Q_reg, Q_1} <= {diff[7], diff, Q_reg};
            //     default: {A, Q_reg, Q_1} <= {A[7], A, Q_reg};
            // endcase

            count <= count + 1'b1;

            if(count == 8) begin
                $finish;
            end
        end
        
    end
endmodule

module shifter(A, Q, Q_1, shift);
    input signed [7:0] A, Q;
    input signed Q_1;
    output signed [16:0] shift;

    assign shift = {A,Q,Q_1} >>> 1;
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