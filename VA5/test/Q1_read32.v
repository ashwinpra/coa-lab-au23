module Divby255(x, rst1, rst2, clk, result);
	input [15:0] x;
	input rst1, rst2, clk;

	reg [31:0] X;

	reg [31:0] Y;

	output reg [31:0] result;

	parameter S0 = 0,   // start state
			  S1 = 1,   // state for reading 16 MSBs
			  S2 = 2,   // state for reading 16 LSBs
			  S3 = 3, S4 = 4, S5 = 5, S6 = 6, S7 = 7;

	reg [2:0] cs = 0, ns;

	always @(posedge clk) begin
		cs <= ns;

		case (cs) 
			S0: begin 
				// initial state 
				y <= 0;
				if (rst1) ns <= S1;
			end
			S1: begin
				// read most significant 16 bits
				X[31:16] <= x;
				if (rst2) ns <= S2;
			end
			S2: begin
				// read least significant 16 bits
				X[15:0] <= x;
				ns <= S3;
			end
			S3: begin
				Y = X; 
				// computation starts here
			end
		endcase
	end

	
endmodule