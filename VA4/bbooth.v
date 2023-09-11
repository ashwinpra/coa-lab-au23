module booth_multiplier (prd, busy, mc, mp, clk, start);
    output [15:0] prd;
    output busy;
    input [7:0] mc, mp;
    input clk, start;
    reg [7:0] A, Q, B;
    reg Q_1;
    reg [3:0] count;
    wire [7:0] sum, diff;

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
        case ({Q[0], Q_1})
            2'b0_1 : {A, Q, Q_1} <= {sum[7], sum, Q};
            2'b1_0 : {A, Q, Q_1} <= {diff[7], diff, Q};
            default: {A, Q, Q_1} <= {A[7], A, Q};
        endcase
            count <= count + 1'b1;
            end
    end

    alu adder (sum, A, B, 1'b0);
    alu subtracter (diff, A, ~B, 1'b1);

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