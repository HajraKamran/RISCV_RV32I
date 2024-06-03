module core(
        input wire clk,
        input wire rst,
        input wire [31:0] instruction,
        input wire [31:0] load_data_in,
        input wire instruc_mem_valid,
        input wire data_mem_valid,

        output wire write,
        output wire load_signal,
        output wire [3:0]  mask_signal,
        output wire [31:0] store_data_out,
        output wire [31:0] alu_out_address,
        output wire [31:0] pc_address,
        output wire instruc_mem_we_re,
        output wire instrucmem_req,
        output wire data_mem_we_re,
        output wire data_mem_request,
        output wire [3:0]  instruc_mask_signal

    );

        wire [31:0] instruc_data_out;
        wire [31:0] pc_address_out;
        wire [31:0] adder_out;
        wire load;
        wire store;
        wire next_sel;
        wire branch_result;
        wire [3:0] mask;
        wire [3:0] alu_control;
        wire [1:0] mem_to_reg;
        wire [31:0] op_b;
        wire [31:0] opa_mux_out;
        wire [31:0] opb_mux_out;
        wire [31:0] alu_res_out;
        wire [31:0] next_sel_address;
        wire [31:0] wrap_load_out;
        wire [31:0] wrap_load_in;
        wire [31:0] rd_wb_data;
        wire [31:0] address_in;
        wire [31:0] res_o;
        wire [31:0] wb_mux_out;
        wire [31:0] op2_regfile_to_mem;
        wire instruction_memory_request;
        wire [31:0] instruction_out;
        wire [31:0] pre_address;
        wire [31:0] pre_address_fetch;
        wire [31:0] instruc;

    fetch u_fetch(
        .clk(clk),
        .rst(rst),
        .load(load),
        .instruction(instruction),
        .address_in(0),// pc address 0 beacuse 
        .res_o(res_o),
        .Branch(branch_result),
        .Jal(Jal),
        .Jalr(Jalr),
        .address_out(pc_address),
        .valid(data_mem_valid),
        .mem_request(instruction_memory_request),
        .we_re(instruc_mem_we_re),
        .instruction_out(instruction_out),
        .pre_address(pre_address_fetch),
        .mask(instruc_mask_signal)
        
    );
    assign instrucmem_req = instruction_memory_request;
    assign instruction_out = instruction;

    assign address_out = pc_address_out;


    fetch_pipeline u_fetch_pipline(
        .clk(clk),
        .rst(rst),
        .instruction_fetch(instruction_out),
        .pc_pre_address(pre_address_fetch),
        .instruction(instruc),
        .pre_address(pre_address)
    );



    decode u_decode(
        .clk(clk),
        .rst(rst),
        .instruction(instruc),
        .address_out(pre_address),
        .wb_mux_out(wb_mux_out),
        .load(load),
        .store(store),
        .mem_to_reg(mem_to_reg),
        .Branch(branch_result),
        .Jal(Jal),
        .Jalr(Jalr),
        .alu_control(alu_control),
        .opa_mux_out(opa_mux_out),
        .opb_mux_out(opb_mux_out),
        .op2_regfile_to_mem(op2_regfile_to_mem)

    );

    assign load_signal = load;


    execute u_execute(
        .opa_mux_out(opa_mux_out),
        .opb_mux_out(opb_mux_out),
        .address_out(pre_address),
        .alu_control(alu_control),
        .res_o(res_o),
        .adder_out(adder_out)
    );

    mem_stage u_memorystage(
        .wrap_in(op2_regfile_to_mem),
        .en(store),
        .wrap_load_in(load_data_in),
        .load(load),
        .instruction(instruction_out),
        .res_o(res_o),
        .mask(mask_signal),
        .wrap_out(store_data_out),
        .wrap_load_out(wrap_load_out),
        .valid(instruc_mem_valid),
        .mem_request(data_mem_request),
        .we_re(data_mem_we_re)
    );

    assign alu_out_address = res_o ;
    assign mask = mask ;

    write_back u_wbstage(
        .alu_out(res_o),
        .data_mem_out(wrap_load_out),
        .adder_out(adder_out),
        .rd_sel(mem_to_reg),
        .wb_mux_out(wb_mux_out)
    );


    


endmodule