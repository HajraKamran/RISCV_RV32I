`include "alu.v"
`include "mux.v"
`include "mux2.v"
`include "control_unit.v"
`include "imm_gen.v"
`include "instruc_mem.v"
`include "program_counter.v"
`include "regfile.v"
`include "data_mem.v"
`include "wrapmem.v"
`include "branch.v"
`include "adder.v"
`include "mux3_8.v"
module microprocessor (clk,rst,en,in);
    input wire clk;
    input wire rst;
    input wire en;
    input wire [31:0]in;


    wire [31:0] data_out;
    wire [31:0] i_data_out;
    wire [31:0] wrap_in;
    wire [31:0] wrap_out;
    wire [31:0]i_type;
    wire [31:0] s_type;
    wire [31:0] uj_type;
    wire reg_write;
    wire [31:0] op1,op2;
    wire [31:0]address_in;
    wire [31:0]address_out;
    wire [3:0]alu_control;
    wire op_b;
    wire op_a;
    wire [2:0] imm_sel;
    wire [31:0] res_o;
    wire [31:0] out;
    wire [31:0] out2;
    wire [31:0] out3;
    wire [31:0] out4;
    wire [3:0] mask;
    wire [11:0] address;
    wire [2:0] func3;
    wire [31:0] wrap_load_in;
    wire [31:0] wrap_load_out;
    wire [1:0] byteadd;
    wire Branch;
    wire Jal;
    wire Jalr;
    wire enable;
    wire [31:0] sb_type;
    wire load;
    wire [1:0] rd_sel;
    wire [31:0] branch_out;
    wire [31:0] adder_out;
    wire [31:0] u_type;

    program_counter u_program_counter(
        .clk(clk),
        .rst(rst),
        .address_in(address_in),
        .address_out(address_out),
        .branch_address(res_o),
        .branch(Branch),
        .jal(Jal),
        .jalr(Jalr),
        .jal_address(res_o),
        .jalr_address(res_o)
    );
    
    instruc_mem u_instruc_mem0(
        .clk(clk),
        .en(en),
        .address(address_out[13:2]),
        .i_data_in(in),
        .i_data_out(i_data_out)
    );

    imm_gen u_imm_gen0(
        .instruc(i_data_out),
        .i_type(i_type),
        .s_type(s_type),
        .sb_type(sb_type),
        .uj_type(uj_type),
        .u_type(u_type)
    );

    control_unit u_control_unit0(
        .op(i_data_out[6:0]),
        .en(enable),
        .func3(i_data_out[14:12]),
        .func7(i_data_out[30]),
        .reg_write(reg_write),
        .op_b(op_b),
        .alu_control(alu_control),
        .imm_sel (imm_sel),
        .loadout(load),
        .mem_to_reg(rd_sel),
        .s(store),
        .Branch(Branch),
        .op_a(op_a),
        .Jal(Jal),
        .Jalr(Jalr)
    );
    regfile u_regfile0(
        .clk(clk),
        .rst(rst),
        .en(reg_write),
        .in(out3),//3rd  mux ka out
        .rs1(i_data_out[19:15]),
        .rs2(i_data_out[24:20]),
        .op1(op1),
        .op2(op2),
        .rd(i_data_out[11:7])
    );
    mux3_8 u_mux1(
        .a(i_type),
        .b(s_type),
        .c(sb_type),
        .d(uj_type),
        .e(u_type),
        .sel(imm_sel),
        .out(out)
    );


    mux u_mux2(
        .a(op2),
        .b(out),
        .sel(op_b),
        .out(out2)
    );
    adder u_adder0(
        .address_out(address_out),
        .adder_out(adder_out)
    );
                     
    mux2_4 u_mux3(
        .a(res_o),
        .b(wrap_load_out),
        .c(adder_out),
        .sel(rd_sel),
        .out(out3)
    );

    mux u_mux4(
        .a(op1),
        .b(address_out),//pc address out
        .sel(op_a),
        .out(out4)
    );

    alu u_alu0(
        .a(out4),
        .b(out2),
        .op(alu_control),
        .res_o(res_o)
    );

    data_mem u_data_mem(
        .clk(clk),
        .en(store),
        .mask(mask),
        .data_in(wrap_out),
        .data_out(data_out),
        .address(res_o[13:2])

    );

    wrapmem u_wrapmem(
        .wrap_in(op2),
        .byteadd(res_o[1:0]),
        .func3(i_data_out[14:12]),
        .en(enable),
        .load(load),
        .wrap_load_in(data_out),
        .wrap_load_out(wrap_load_out),
        .wrap_out(wrap_out),
        .masking (mask)
    );

    branch u_branch(
        .en(Branch),
        .rs1(op1),
        .rs2(op2),
        .func3(i_data_out[14:12]),
        .branch_out(branch_out)
    );
    
endmodule




