module testbench; 
    reg [7:0] A,B; 
    wire [7:0] diff;

    subtractor s0(A, B, diff); // subtractor module instantiation

    initial begin
        A = 10; B = 5; 
        #10 $display("A = %d, B = %d, diff = %d", A, B, diff); // printing initial values

        A = 20; B = 13; 
        #10 $display("A = %d, B = %d, diff = %d", A, B, diff); // printing values after modification
    end
endmodule