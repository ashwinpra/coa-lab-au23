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
	output reg [31:0] ins;

	reg [31:0] mem [1023:0];

	initial begin
		$readmemb("instructions_bin.txt", mem, 0, 1023);	
	end

	always @(*) begin 
		// $display("PC = %d, ins = %b", addr[9:0], mem[addr[9:0]]);
		ins = mem[addr[9:0]];
	end
endmodule