    module Microprocessor(

        input wire clk,
        input wire rst,
        input wire en,
        input [31:0] instruction  
    );

    wire [31:0] address_out;
    wire write;
    wire [3:0] mask_signal;
    wire [31:0] res_o;
    wire instruc_mem_we_re;
    wire instruc_mem_request;
    wire [3:0]instruc_mask_signal;
    wire [31:0] data_out;
    wire instruc_mem_valid;
    wire data_mem_valid;
    wire data_mem_we_re;
    wire data_mem_request;
    wire store;
    wire [3:0] mask;
    wire [31:0] data_in;
    wire [31:0] wrap_out;
    wire [31:0] wrap_load_out;
    wire signal;

    




    core u_core(
        .clk(clk),
        .rst(rst),
        .instruction(data_out),
        .load_data_in(wrap_load_out),
        .write(write),
        .mask_signal(mask),
        .store_data_out(wrap_out),
        .alu_out_address(res_o),
        .address_out(address_out),
        .instruc_mask_signal(instruc_mask_signal),
        .instruc_mem_we_re(instruc_mem_we_re),
        .instrucmem_req(instruc_mem_request),
        .data_mem_we_re(data_mem_we_re),
        .data_mem_request(data_mem_request),
        .instruc_mem_valid(instruc_mem_valid),
        .data_mem_valid(data_mem_valid)
    );

    memory instruction_memory(
        .clk(clk),
        .we_re(instruc_mem_we_re),
        .request(instruc_mem_request),
        .signal(signal),
        .address(address_out[13:2]),
        .data_in(instruction),
        .data_out(data_out)

        
    );

    memory data_memory(
        .clk(clk),
        .we_re(data_mem_we_re),
        .valid(data_mem_valid),
        .request(data_mem_request),
        .mask(mask),
        .data_in(wrap_out),
        .data_out(wrap_load_out),
        .address(res_o[13:2])

    );

    endmodule