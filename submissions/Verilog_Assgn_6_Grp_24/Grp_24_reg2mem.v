q// Verilog Assignment 6, Question 1 
// REG2MEM module and REGISTER module
// Autumn Semester 2023-24 (Semester 5)
// Group No. 24 
// Gorantla Thoyajakshi - 21CS10026
// Ashwin Prasanth - 21CS30009

module register(dest, en, we, data_in, data_out, clk);
    input [2:0] dest; 
    input en, we;
    input [3:0] data_in;
    output reg [3:0] data_out;
    input clk;

    reg [3:0] R [7:0];

    always @(posedge clk) begin
        if (en) begin
            if (we) begin
                R[dest] = data_in;
                data_out = R[dest];
            end
            data_out = R[dest];
        end
        else
            data_out = 0;
    end

endmodule 

module reg2mem(clk, instruction, res);
    input clk; 
    input [9:0] instruction; 
    output reg [3:0] res; 

    reg [3:0] data_in;
    reg [3:0] reg_data_in; 
    wire [3:0] data_out;
    reg [2:0] reg_num;
    reg [3:0] addr;
    
    reg ena, wea;
    reg en_reg, we_reg; 
    reg [3:0] data_in_reg; 
    wire [3:0] data_out_reg;

    register R0(
        .dest(reg_num),
        .en(en_reg),
        .we(we_reg),
        .data_in(data_in_reg),
        .data_out(data_out_reg),
        .clk(clk)
    );
    
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
        case(instruction[9:8])
            STORE_DATA: begin
                data_in = instruction[7:4];
                addr = instruction[3:0];
                ena = 1; 
                wea = 1; 
            end
            MOVE_TO_MEM: begin
                reg_num = instruction[6:4];
                addr = instruction[3:0];
                en_reg = 1;
                we_reg = 0;
                data_in = data_out_reg;
                ena = 1; 
                wea = 1; 
            end
            MOVE_FROM_MEM: begin
                reg_num = instruction[6:4];
                addr = instruction[3:0];
                ena = 1; 
                wea = 0; 
                data_in_reg = data_out;
                en_reg = 1;
                we_reg = 1;

            end
            LOAD_DATA: begin
                addr = instruction[3:0];
                ena = 1; 
                wea = 0; 
                res = data_out;
            end
        endcase
    end
endmodule
