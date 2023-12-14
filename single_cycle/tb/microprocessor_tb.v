`timescale 1ns/1ps
module microprocessor_tb();
    reg clk;
    reg [31:0]instruc;
    reg rst;
    reg en;
    wire[31:0] res_o;

    Microprocessor u_microprocessor(
        .clk(clk),
        .rst(rst),
        .en(en)
    );

    initial begin
        clk = 0;
        rst = 1;
        en = 0;
        #10;
        rst=0;
        #10;

        rst = 1;
        #140;
       

        $finish;       
    end
     initial begin
       $dumpfile("temp/microprocessor.vcd");
       $dumpvars(0,microprocessor_tb);
    end

    always begin
        #5 clk= ~clk;
    end
endmodule