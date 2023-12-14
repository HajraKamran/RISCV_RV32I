    module Microprocessor(

        input wire clk,
        input wire rst,
        input wire en,
        input wire [31:0] instruction  
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
    wire [31:0] wrap_out;
    wire [31:0] wrap_load_out;
    wire load_signal;

    




    core u_core(
        .clk(clk),
        .rst(rst),
        .instruction(data_out),
        .load_data_in(wrap_load_out),
        .write(write),
        .mask_signal(mask),
        .store_data_out(wrap_out),
        .alu_out_address(res_o),
        .pc_address(address_out),
        .instruc_mask_signal(instruc_mask_signal),
        .instruc_mem_we_re(instruc_mem_we_re),
        .instrucmem_req(instruc_mem_request),
        .data_mem_we_re(data_mem_we_re),
        .data_mem_request(data_mem_request),
        .instruc_mem_valid(instruc_mem_valid),
        .load_signal(load_signal),
        .data_mem_valid(data_mem_valid)
    );

   
    datamem_top u_datamem(
    
        .clk(clk),
        .rst(rst),
        .we_re(data_mem_we_re),
        .request(data_mem_request),
        .address(res_o[13:2]),
        .data_in(wrap_out),
        .mask(mask),
        .load(load_signal),
        .valid(data_mem_valid),
        .data_out(wrap_load_out)

    );

      instruc_mem_top #(
        .INIT_MEM(1)
    )u_instruc_mem(
        .clk(clk),
        .rst(rst),
        .we_re(instruc_mem_we_re),
        .request(instruc_mem_request),
        .address(address_out[13:2]),
        .data_in(instruction),
        .mask(instruc_mask_signal),
        .valid(instruc_mem_valid),
        .data_out(data_out) 
    );



    endmodule