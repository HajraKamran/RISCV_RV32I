module mem_stage(


    input wire [31:0] wrap_in,
    input wire [31:0] res_o, //alu 2 bits
    input wire [31:0] instruction,
    input wire en,
    input wire load,
    input wire valid,
    input wire [31:0]wrap_load_in,
    

    output wire [31:0]wrap_load_out,
    output wire [31:0]wrap_out,
    output wire [3:0]mask,
    output reg mem_req,
    output reg we_re

    );

   

    wrapmem u_wrapmem(
        .wrap_in(wrap_in),
        .byteadd(res_o[1:0]),
        .func3(instruction[14:12]),
        .en(en),
        .load(load),
        .wrap_load_in(wrap_load_in),
        .wrap_load_out(wrap_load_out),
        .wrap_out(wrap_out),
        .masking (mask)
    );

    always @ (*)begin
     mem_req = load | en;
     we_re = en;
    end
endmodule