module execute(opa_mux_out,opb_mux_out,alu_control,res_o,address_out,adder_out);

input wire [31:0] opa_mux_out;
input wire [31:0] opb_mux_out;
input wire  [3:0] alu_control;
input wire [31:0] address_out;
output wire [31:0] res_o;
output wire [31:0] adder_out;


 alu u_alu0(
        .a(opa_mux_out),
        .b(opb_mux_out),
        .op(alu_control),
        .res_o(res_o)
    );

    adder u_adder0(
        .address_out(address_out),
        .adder_out(adder_out)
    );
endmodule
