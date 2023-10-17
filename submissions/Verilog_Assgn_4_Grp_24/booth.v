module booth (M, Q, clk, out);
    input [7:0] M, Q;
    input clk; 
    output reg [15:0] out;

    reg [7:0] A = 8'b0;
    reg Q_1 = 1'b0;

    reg [7:0] Q_reg, M_reg; 

    reg [3:0] count = 4'b0; 

    wire [7:0] sum, diff, A_shift, Q_shift;
    wire [16:0] shift;
    wire Q_1_shift;

    adder a0 (A, M_reg, sum);
    subtractor s0 (A, M_reg, diff);
    shifter sh0 (A, Q_reg, Q_1, A_shift, Q_shift, Q_1_shift, shift);
    
    always @(Q or M) begin
        Q_reg <= Q;
        M_reg <= M;
    end

    always @ (posedge clk) begin
        if (Q_reg[0] == 1'b1 && Q_1 == 1'b0) begin 
            A = diff;
        end
        else if (Q_reg[0] == 1'b0 && Q_1 == 1'b1) begin
            A = sum;
        end
        
        // now arithmetic right shift

        Q_reg = {A[0], Q_reg[7:1]};
        A = {A[7], A[7:1]};
        Q_1 = Q_reg[0];

        count <= count + 1'b1;

        if (count == 4'b1000)
            out <= {A, Q_reg};
        else $display("A = %b, Q_reg = %b, Q_1 = %b, count = %d", A, Q_reg, Q_1, count);
    end


endmodule