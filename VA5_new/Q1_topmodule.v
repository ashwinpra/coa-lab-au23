module Divby255(x, flg1, flg2, flg3, flg4, rst, clk, y);
	input [15:0] x;
	input flg1, flg2, flg3, flg4, rst, clk;
	reg [31:0] X;
	wire [31:0] X_1; 

	wire [31:0] Y; 

	output reg [15:0] y;

	reg [1:0] count = 0;

	wire [31:0] one;
	assign one = 1; 

	wire [31:0] temp1, temp2, temp3, temp4, temp5, temp6;

	adder a0(X, one, X_1);
	rshift8bit r0(X_1, temp1); // temp1 = X_1 >> 8

	adder a1(temp1, X_1, temp2); // temp2 = temp1 + X_1
	rshift8bit r1(temp2, temp3); // temp3 = temp2 >> 8

	adder a2(temp3, X_1, temp4); // temp4 = temp3 + X_1
	rshift8bit r2(temp4, temp5); // temp5 = temp4 >> 8

	adder a3(temp5, X_1, temp6); // temp6 = temp5 + X_1
	rshift8bit r3(temp6, Y); // y = temp6 >> 8


	parameter S0 = 0,   // start state
			  S1 = 1,   // state for reading 16 MSBs of X
			  S2 = 2,   // state for reading 16 LSBs of X
			  S3 = 3,   // buffer state from after which Y is outputted 
			  S4 = 4,   // 16 MSBs of Y are outputted
			  S5 = 5; 	// 16 LSBs of Y are outputted

	reg [2:0] cs = 0, ns;

	always @(posedge clk) begin
		cs <= ns;
		$display("cs = %d", cs);
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
				// move to output display when flg3 is high
				if (flg3) ns <= S4;
			end
			S4: begin
				// display 16 MSBs of y
				y <= Y[31:16];
				$display($time, " y_MSB = %b, flg4 = %d", y, flg4);
				if(flg4) ns <= S5; 
			end
			S5: begin
				// display 16 LSBs of y 
				y <= Y[15:0];
				$display($time, " y_LSB = %b", y);1
				if(rst) ns <= S0; 
			end
		endcase
	end

	
endmodule