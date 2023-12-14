module decode(

input wire clk,
input wire rst,
input wire [31:0] instruction,
input wire [31:0] wb_mux_out,//write back mux out
input wire  [31:0] address_out,//pc address

output wire [3:0]alu_control,
output wire [31:0] opa_mux_out,
output wire [31:0]opb_mux_out,
output wire [31:0] op2_regfile_to_mem,//operand b of reg file for input in wrapper mem
output wire Jal,
output wire Jalr,
output wire Branch,
output wire [1:0] mem_to_reg,//sel for mux of alu out and load
output wire load ,
output wire store
);
    wire  [31:0] i_data_out;
    wire  [31:0] branch_out;
    wire reg_write;
    wire op_b;
    wire op_a;
    wire [31:0]op1;
    wire [31:0]op2;
    wire [31:0]out2;
    wire [31:0]out4;
    wire [31:0]out;
    wire [2:0] imm_sel;
    wire enable;
    wire Auipc;
    wire Lui;
    wire [31:0] i_type,s_type,sb_type,uj_type,u_type;

control_unit u_control_unit0(
        .op(instruction[6:0]),
        .en(enable),
        .func3(instruction[14:12]),
        .func7(instruction[30]),
        .reg_write(reg_write),
        .op_b(op_b),
        .alu_control(alu_control),
        .imm_sel (imm_sel),
        .loadout(load),
        .mem_to_reg(mem_to_reg),
        .s(store),
        .Branch(Branch),
        .op_a(op_a),
        .Jal(Jal),
        .Jalr(Jalr),
        .Auipc(Auipc),
        .Lui(Lui)
    );

     regfile u_regfile0(
        .clk(clk),                      
        .rst(rst),
        .en(reg_write),
        .instruction(wb_mux_out),//3rd  mux ka out
        .rs1(instruction[19:15]),
        .rs2(instruction[24:20]),
        .op1(op1),
        .op2(op2),
        .rd(instruction[11:7])
    );

    assign op2_regfile_to_mem = op2;

     imm_gen u_imm_gen0(
        .instruc(instruction),
        .i_type(i_type),
        .s_type(s_type),
        .sb_type(sb_type),
        .uj_type(uj_type),
        .u_type(u_type)
    );

    branch u_branch(
        .en(branch),
        .op1(op1),
        .op2(op2),
        .func3(instruction[14:12]),
        .branch_out(branch_out)
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
        .a(op2),//opb from regfile
        .b(out),//imm sel mux out
        .sel(op_b),
        .out(opb_mux_out)
    );

    mux u_mux4(
        .a(op1),//opa fro regfile
        .b(address_out),//pc address out
        .sel(op_a),
        .out(opa_mux_out)
    );
endmodule