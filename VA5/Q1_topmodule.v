module Divby255(x, flg1, flg2, flg3, flg4, clk, y);
	input [15:0] x;
	input flg1, flg2, flg3, flg4, clk;
	reg [31:0] X;

	reg [7:0] X3, X2, X1, X0; 
	reg [7:0] Y3, Y2, Y1, Y0;
	output reg [15:0] y;

	wire bout0, bout1, bout2, bout3;
    wire [7:0] diff0, diff1, diff2, diff3;
    subtractor8bit sub0(8'b0, X0, 1'b0, bout0, diff0);
    subtractor8bit sub1(Y0, X1, bout0, bout1, diff1);
    subtractor8bit sub2(Y1, X2, bout1, bout2, diff2);
    subtractor8bit sub3(Y2, X3, bout2, bout3, diff3);

	parameter S0 = 0,   // start state
			  S1 = 1,   // state for reading 16 MSBs of X
			  S2 = 2,   // state for reading 16 LSBs of X
			  S3 = 3,   // starting state for computing y (initialisations)
			  S4 = 4,   // state where Y0 is computed
			  S5 = 5, 	// state where Y1 is computed
			  S6 = 6, 	// state where Y2 is computed
			  S7 = 7,   // state where Y3 is computed 
			  S8 = 8,   // state for writing 16 MSBs of Y
			  S9 = 9;    // state for writing 16 MSBs of Y

	reg [3:0] cs = 0, ns;

	always @(posedge clk) begin
		cs <= ns;

		case (cs) 
			S0: begin 
				// initial state
				y <= 0;
				if (flg1) ns <= S1;
			end
			S1: begin
				// read most significant 16 bits
				X[31:16] <= x;
				if (flg2) ns <= S2;
			end
			S2: begin
				// read least significant 16 bits
				X[15:0] <= x;
				ns <= S3;
			end
			S3: begin
				// get X3, X2, X1, X0, initialise Y3, Y2, Y1, Y0
				X3 <= X[31:24];
				X2 <= X[23:16];
				X1 <= X[15:8];
				X0 <= X[7:0];
				Y3 <= 0;
				Y2 <= 0;
				Y1 <= 0;
				Y0 <= 0;

				ns <= S4;
			end
			S4: begin
				// get Y0
				Y0 <= diff0;
				ns <= S5;
			end
			S5: begin
				// get Y1
				Y1 <= diff1;
				ns <= S6;
			end
			S6: begin
				// get Y2
				Y2 <= diff2;
				ns <= S7;
			end
			S7: begin
				// get Y3
				Y3 <= diff3;
				ns <= S8;
			end
			S8: begin
				// display 16 MSBs of y
				y <= {Y3, Y2};
				if(flg3) ns <= S9; 
			end
			S9: begin
				// display 16 LSBs of y 
				y <= {Y1, Y0};
				if(flg4) ns <= S0; 
			end
		endcase
	end

	
endmodule