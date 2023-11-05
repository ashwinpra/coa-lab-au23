module readmemh_demo;

    reg [31:0] addr;
    wire [31:0] ins;

    instruction_memory IM(
        .addr(addr),
        .ins(ins)
    );
    
endmodule

