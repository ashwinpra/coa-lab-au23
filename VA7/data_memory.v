// module data_memory(clk, MemR, MemW, addr, din, LMD); 

// input clk, MemR, MemW; 
// input [9:0] addr; // check addr and din
// input [31:0] din;
// output reg [31:0] LMD; 

// blk_mem_gen_0 DATAMEM(
//   .clka(~clk),     // input wire clk (check ~clk or clk)
//   .ena(MemR),      // to enable read
//   .wea(MemW),      // to enable write
//   .addra(addr),    // address that is being read/written
//   .dina(din),      // data that is being written
//   .douta(LMD)      // data that is being read
// );

// endmodule

module data_memory (opcode, address, writeData, MemR, MemW, readData);
	input [5:0] opcode;
	input [31:0] address;
	input [31:0] writeData;
	input MemR;
	input MemW;
	output reg signed [31:0] readData;

    reg signed [31:0] mem [0:1023];

	integer k;

    initial begin
        $readmemh("data_mem.txt", mem, 0, 1023);
		// for(k = 0; k < 10; k = k + 1) $display("mem[%d] = %d", k, mem[k]);
    end

    always @(*) begin
		// $monitor("addr = %d, MemR = %d, MemW = %d", address[9:0], MemR, MemW);
		// $monitor("writeData = %d", writeData);
		// $monitor("mem[0] = %d, mem[1] = %d, mem[2] = %d, mem[3] = %d", mem[0], mem[1], mem[2], mem[3]);
		// $monitor("mem[1022] = %d", mem[1022]);
        if (MemW) begin
			// $display("opcode = %b, writing to mem[%d], %d", opcode, address[9:0], writeData);
			mem[address[9:0]] <= writeData;
			// { mem[address[9:0]], mem[address[9:0]+1], mem[address[9:0]+2], mem[address[9:0]+3] } = writeData;
        end
		if (MemR) begin
			// $display("opcode = %b, reading from mem[%d], %d", opcode, address[9:0], mem[address[9:0]]);
			readData <= mem[address[9:0]];
			// readData = { mem[address[9:0]], mem[address[9:0]+1], mem[address[9:0]+2], mem[address[9:0]+3] };
		end
    end
endmodule