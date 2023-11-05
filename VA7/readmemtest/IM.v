// module instruction_memory(clk, PC, ins);
//     input clk; 
//     input [31:0] PC; 
//     output [31:0] ins;
    
//     blk_mem_gen_1  INSMEM(
//       .clka(clk),    // input wire
//       .addra(PC),  // input wire [9 : 0] 
//       .douta(ins)  // output wire [31 : 0] 
//     );


// endmodule

module instruction_memory(addr, ins);
	input [31:0] addr;
	output [31:0] ins;

	reg [31:0] mem [1023:0];

    integer k; 

	initial begin
		$readmemb("data.txt", mem, 0, 1023);
		#10;
        $display("Contents of Mem after reading data file:");
        for (k=0; k<6; k=k+1) $display("%d: %b",k,mem[k]);
	end

	assign ins = mem[addr[9:0]];
endmodule