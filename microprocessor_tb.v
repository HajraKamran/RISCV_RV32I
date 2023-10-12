`timescale 1ns/1ps
module microprocessor_tb();
    reg clk;
    reg [31:0]instruc;
    reg rst;
    reg en;
    wire[31:0] res_o;

    microprocessor u_microprocessor(
        .clk(clk),
        .rst(rst),
        .en(en)
    );

    initial begin
        clk = 0;
        rst = 0;
        en = 0;
        #10;
        rst=1;
        #10;

        rst = 1;
        #40;
        #40;

        $finish;       
    end
     initial begin
       $dumpfile("microprocessor.vcd");
       $dumpvars(0,microprocessor_tb);
    end

    always begin
        #5 clk= ~clk;
    end
endmodule