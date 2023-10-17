module or_module(a,b,result); // OR module
    input [7:0] a,b;
    output [7:0] result;
    
    assign result = a | b; // bitwise OR
endmodule