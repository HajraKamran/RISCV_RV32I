module fetch(

    input wire clk,
    input wire rst,
    input wire [31:0]instruction,
    input wire [31:0] address_in,//pc address in
    input wire [31:0] res_o,// alu out
    input wire Branch,Jal,Jalr,// signals
    input wire valid,//signal

    output wire [31:0] address_out,//pc address out
    output wire mem_request,
    output wire we_re,
    output reg [31:0] instruction_out,
    output wire [3:0] mask



    );

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
    
        assign mem_request = 1'b1;
        assign we_re = 1'b0;
        assign mask = 4'b1111;


    always @ (*)begin
        instruction_out = instruction;
     end
endmodule
