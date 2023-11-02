module control_unit (op,func3,func7,reg_write,op_b,op_a,alu_control,Auipc,Lui,Jal,Jalr,imm_sel,mem_to_reg,loadout,s,en,Branch);
input wire [6:0] op;
input wire  [2:0]func3;
input wire func7;
output wire reg_write;
output wire op_b;
output wire op_a;
output wire [3:0]alu_control;
output wire [2:0] imm_sel;
output wire [1:0] mem_to_reg;
output wire loadout;
output wire s;
output wire Branch;
output wire en;
output wire Jal;
output wire Jalr;
output wire Auipc;
output wire Lui;

wire r_type;  
wire i_type;
wire load;
wire s_type;
wire branch;
wire jal;
wire jalr;
wire lui;
wire auipc;


typedec u_typedec0 (
    .op (op),
    .r_type (r_type),
    .i_type (i_type),
    .load(load),
    .sb_type(branch),
    .s_type(s_type),
    .auipc(auipc),
    .lui(lui),
    .jal(jal),
    .jalr(jalr)
);

controldecode u_controldecode0(
    .r_type (r_type),
    .i_type (i_type),
    .load(load),
    .s_type(s_type),
    .loadout(loadout),
    .s(s),
    .branch(branch),
    .mem_to_reg(mem_to_reg),
    .mem_en(en),
    .op_b(op_b),
    .op_a(op_a),
    .imm_sel(imm_sel),
    .func3 (func3),
    .func7 (func7),
    .reg_write(reg_write),
    .Branch (Branch),
    .alu_control(alu_control),
    .jal(jal),
    .Jal(Jal),
    .jalr(jalr),
    .Jalr(Jalr),
    .auipc(auipc),
    .Auipc(Auipc),
    .lui(lui),
    .Lui(Lui)
);

endmodule