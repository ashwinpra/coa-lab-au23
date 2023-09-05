module twoscomp (in, clk, reset, out); 
    input in, clk, reset; 
    output reg out;

    parameter S0 = 1'b0; 
    parameter S1 = 1'b1;

    reg cs, ns; 

    always @(posedge clk) begin 
        cs = ns;
        
        if (reset) begin
            ns <= S0;
            out <= 1'b0;
        end
        
        case (cs)
            S0: begin
                out <= in; 
                if (in == 1'b1)
                    ns <= S1;
                else 
                    ns <= S0;
            end
            S1: begin
                ns <= S1;
                out <= ~in;
            end
        endcase
    end
endmodule 
