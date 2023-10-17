module not_module(a,result); // NOT module
    input [7:0] a;
    output [7:0] result;
    
    assign result = ~a; // bitwise NOT
endmodule