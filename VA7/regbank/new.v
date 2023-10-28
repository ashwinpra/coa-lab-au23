module top(output reg [15:0] out, input [5:0] in, input clk, input rst, input myclk);
    reg [5:0] rport1, rport2, wport;    // Register addresses
    reg [3:0] op;                       // ALU operations
    reg regR, regW;                     // Control Signals to read or write in regbank
    wire [31:0] regA, regB, aluOUT;
    wire zero, sign, over;

    // Slow Clock implementation
    reg [26:0] counter;
    initial counter <= 0;
    always @(posedge clk) counter <= counter+1;
    wire slowclk;
    assign slowclk = counter[26];

    // Module instantiation
    regbank R(regA, regB, rport1, rport2, wport, aluOUT, regR, regW, slowclk, rst);
    ALU A(aluOUT, zero, sign, over, regA, regB, op);

    integer state;

    initial begin
        state <= 0;
        rport1 <= 0;
        rport2 <= 0;
        wport <= 0;
        op <= 0;
        regR <= 0;
        regW <= 0;
    end
    always @(posedge slowclk) begin
        if (myclk) begin
            case(state)
                1: wport <= in;     // Read write reg address
                2: rport1 <= in;    // Read read reg1 address
                3: rport2 <= in;    // Read read reg2 address
                4: op <= in[3:0];   // Read function for ALU
                5: begin
                    regR <= 1;      // Reg bank outputs values contained in reg1 and reg2
                end
                6: begin
                    regR <= 0;
                    regW <= 1;      // Reg bank writes the output of ALU into write reg
                end
                7: regW <= 0;
            endcase
            // Outputs in LEDs
            if (state <= 5) out <= state;
            else if (state == 6) out <= aluOUT[31:16];
            else if (state == 7) out <= aluOUT[15:0];
            else if (state == 8) out <= 16'b1010101101101011;   // To check if the state resets correctly
            state <= (state+1)%9;
        end
        if (rst) state <= 0;
    end
endmodule