module booth_multiplier(prd, busy, mc, mp, clk, start);
    output [15:0] prd;
    output busy;
    input signed [7:0] mc, mp;
    input clk, start;
    reg signed [7:0] A, Q, B;
    reg Q_1;
    reg [3:0] count;
    wire signed [7:0] sum, diff;

    always @(posedge clk)
    begin
        if (start) begin
            A <= 8'b0;
            B <= mc;
            Q <= mp;
            Q_1 <= 1'b0;
            count <= 4'b0;
        end

        else begin
            $display("sum = %d, diff = %d, a=%d, b=%d", sum, diff, A, B);
            case ({Q[0], Q_1})
                2'b0_1 : {A, Q, Q_1} <= {sum[7], sum, Q};
                2'b1_0 : {A, Q, Q_1} <= {diff[7], diff, Q};
                default: {A, Q, Q_1} <= {A[7], A, Q};
            endcase
            count <= count + 1'b1;
            end
    end

    adder a (A, B, 1'b0, sum);
    subtractor s (A, B, 1'b1, diff);

    // alu a (sum, A, B, 1'b0);
    // alu s (diff, A, ~B, 1'b1);

    assign prd = {A, Q};
    assign busy = (count < 8);
endmodule



module alu(out, a, b, cin);
    output [7:0] out;
    input [7:0] a;
    input [7:0] b;
    input cin;
    assign out = a + b + cin;
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