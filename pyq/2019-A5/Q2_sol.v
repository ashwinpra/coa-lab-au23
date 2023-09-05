`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Assignment Number: 5
// Problem Number: 2 [Two’s Complement Converter FSM]
// Semester Number: 5
// Group Number: G1
// Group Members: Animesh Jha (19CS10070) and Nisarg Upadhyaya (19CS30031)
// 
//////////////////////////////////////////////////////////////////////////////////

module twoscomp(in, clk, reset, out);

    input in, clk, reset; 
    output reg out;

	parameter S0 = 1'b0;
    parameter S1 = 1'b1;     // parameters to represent states of FSM

    reg cs, ns;                  // present and next states of FSM
	
    always @(posedge clk) begin 
		cs = ns;      // cs state goes to next state

		if (reset) begin     // if reset
			ns <= S0;          	// next state is 0
			out <= 1'b0;           	// output is 0
		end
        else begin
            if (cs == S0) begin 
                out <= in; 
                if (in == 1'b1)    
                    ns <= S1;        
                else
                    ns <= S0;
            end
            else begin
                ns <= S1;
                out <= ~in;
            end
    end
    end

endmodule    