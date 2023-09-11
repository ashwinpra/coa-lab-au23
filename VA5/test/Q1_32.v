module subtractor8bit(A, B, Bin, Bout, out);
    input [7:0] A, B;
    input Bin;
    output reg Bout;
    reg [8:0] diff;
    output reg signed [7:0] out;

    always @(A, B, Bin) begin
        diff = A - B - Bin;
        out = diff[7:0];
        Bout = diff[8];
    end
endmodule

module div255(x, clk, out);
    input signed [31:0] x; 
    input clk;
    output reg signed [31:0] out;

    reg [7:0] y0, y1, y2, y3;
    reg [7:0] x0, x1, x2, x3;

    parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4;

    wire bout0, bout1, bout2, bout3;
    wire [7:0] diff0, diff1, diff2, diff3;
    subtractor8bit sub0(8'b0, x0, 1'b0, bout0, diff0);
    subtractor8bit sub1(y0, x1, bout0, bout1, diff1);
    subtractor8bit sub2(y1, x2, bout1, bout2, diff2);
    subtractor8bit sub3(y2, x3, bout2, bout3, diff3);


    reg [2:0] cs, ns;

    always @(x) begin
        y0 <= 0;
        y1 <= 0;
        y2 <= 0;
        y3 <= 0;
        x0 <= x[7:0];
        x1 <= x[15:8];
        x2 <= x[23:16];
        x3 <= x[31:24];
        cs <= S0;
    end

    always @(posedge clk) begin
        cs <= ns;
        // S0 -> S1 -> S2 -> S3 -> S4 -> finish
        case(cs)
            S0: begin 
                // get y0 
                y0 <= diff0; 
                ns <= S1;
            end
            S1: begin
                // get y1
                y1 <= diff1;
                ns <= S2;
            end
            S2: begin
                // get y2
                y2 <= diff2;
                ns <= S3;
            end
            S3: begin
                // get y3
                y3 <= diff3;
                ns <= S4;
            end
            S4: begin
                // end and get y
                out = {y3, y2, y1, y0};
            end
        endcase

    end

endmodule