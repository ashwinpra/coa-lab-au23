module rightshift(a,result); // rightshift module
    input [7:0] a;
    output [7:0] result;
    
    assign result = a >> 1; // rightshift by 1
endmodule