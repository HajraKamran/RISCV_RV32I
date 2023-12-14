module fetch(

    input wire clk,
    input wire rst,
    input wire load,
    input wire [31:0]instruction,
    input wire [31:0] address_in,//pc address in
    input wire [31:0] res_o,// alu out
    input wire Branch,Jal,Jalr,// signals
    input wire valid,//signal

    output wire [31:0] address_out,//pc address out
    output reg mem_request,
    output reg we_re,
    output reg [31:0] instruction_out,
    output wire [31:0] pre_address,
    output reg [3:0] mask



    );

    program_counter u_program_counter(
        .clk(clk),
        .rst(rst),
        .valid(valid),
        .address_in(address_in),
        .address_out(address_out),
        .branch_address(res_o),
        .branch(Branch),
        .jal(Jal),
        .jalr(Jalr),
        .jal_address(res_o),
        .pre_address(pre_address),
        .jalr_address(res_o)
    );

    always @ (*) begin
        if (load & !valid) begin
            mask = 4'b1111; 
            we_re = 1'b0;
            mem_request = 1'b0;
        end
        else begin
            mask = 4'b1111; 
            we_re = 1'b0;
            mem_request = 1'b1;
        end
    end
    

    always @ (*)begin
        instruction_out = instruction;
     end
endmodule
