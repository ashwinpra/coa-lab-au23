module leftshift(a,result); // left shift module
    input [7:0] a;
    output [7:0] result;
    
    assign result = a << 1; // left shift by 1
endmodule