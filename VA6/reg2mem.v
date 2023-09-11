module reg2mem(clk, opcode, res);
    input clk;
    input [9:0] opcode;
    output reg [3:0] res;

    reg [3:0] data_in;
    wire [3:0] data_out;
    reg [3:0] reg_num;
    reg [3:0] addr;
   
    reg ena, wea;

    reg [3:0] R [7:0];
   
    blk_mem_gen_0 mem_module (
      .clka(clk),    // input wire clka
      .ena(ena),      // input wire ena
      .wea(wea),      // input wire [0 : 0] wea
      .addra(addr),  // input wire [3 : 0] addra
      .dina(data_in),    // input wire [3 : 0] dina
      .douta(data_out)  // output wire [3 : 0] douta
    );

    parameter STORE_DATA = 0,
              MOVE_TO_MEM = 1,
              MOVE_FROM_MEM = 2,
              LOAD_DATA = 3;

    always @(posedge clk) begin
        $display("opcode = %b", opcode);
        case(opcode[9:8])
            STORE_DATA: begin
                data_in <= opcode[7:4];
                addr <= opcode[3:0];
                ena <= 0;
                wea <= 1;
            end
            MOVE_TO_MEM: begin
                $display("doing MOVE_2_MEM");
                reg_num <= opcode[6:4];
                addr <= opcode[3:0];
                data_in <= R[reg_num];
                ena <= 0;
                wea <= 1;
            end
            MOVE_FROM_MEM: begin
                $display("doing MOVE_FROM_MEM");
                reg_num <= opcode[6:4];
                addr <= opcode[3:0];
                ena <= 1;
                wea <= 0;
                R[reg_num] <= data_out;
            end
            LOAD_DATA: begin
                $display("doing LOAD_DATA");
                addr <= opcode[3:0];
                ena <= 1;
                wea <= 0;
                res <= data_out;
            end
        endcase
    end
endmodule
