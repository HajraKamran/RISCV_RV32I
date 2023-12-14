module write_back(

    input wire [31:0]alu_out,
    input wire [31:0]data_mem_out,
    input wire [31:0]adder_out,
    input wire [1:0]rd_sel,
    output wire [31:0]wb_mux_out
    
);
    mux2_4 u_muxrd(
        .a(alu_out),
        .b(data_mem_out),
        .c(adder_out),
        .sel(rd_sel),
        .out(wb_mux_out)
    );


endmodule