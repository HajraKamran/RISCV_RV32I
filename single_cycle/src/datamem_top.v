module datamem_top #(
      parameter INIT_MEM = 0
)(
    input wire clk,
    input wire rst,
    input wire we_re,
    input wire request,
    input wire load,
    input wire [3:0]  mask,
    input wire [11:0]  address,
    input wire [31:0] data_in,

    output reg valid,
    output wire [31:0] data_out
    );

    always @(posedge clk or negedge rst ) begin
        if(!rst)begin
            valid <= 0;
        end
        else begin
            valid <= load;
            end
    end

    memory #(
      .INIT_MEM(INIT_MEM)
    )u_memory(
        .clk(clk),
        .we_re(we_re),
        .request(request),
        .mask(mask),
        .address(address),
        .data_in(data_in),
        .data_out(data_out)
    );
endmodule
