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