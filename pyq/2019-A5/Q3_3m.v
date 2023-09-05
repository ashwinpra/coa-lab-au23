module mo3detector(in, clk, reset, out);
    // detect multiple of 3 using FSM
    input in, clk, reset;
    output reg out;

    parameter S0 = 2'b00; 
    parameter S1 = 2'b01;
    parameter S2 = 2'b10;

    reg [1:0] cs, ns;

    always @(posedge clk) begin
        cs = ns;

        if (reset) begin
            ns <= S0;
            out <= 1'b0;
        end
        else begin
        // $display("cs=%b, ns=%b", cs, ns);
        case (cs)
            S0: begin
                out <= ~in; 
                // $display("S0: in=%b, out=%b", in, out);
                ns <= in == 1'b1 ? S1 : S0;
            end
            S1: begin
                out <= in;
                // $display("S1: in=%b, out=%b", in, out);
                ns <= in == 1'b1 ? S1 : S2;
            end
            S2: begin
                out <= 1'b0; 
                // $display("S2: in=%b, out=%b", in, out);
                ns <= in == 1'b1 ? S2 : S1;
            end
        endcase
        end
    end
endmodule