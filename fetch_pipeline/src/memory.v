module memory#(
    parameter  INIT_MEM = 0
)
   (clk,address,we_re,request,mask,data_in,data_out);
    input wire clk;
    input wire [3:0] mask;
    input wire [11:0] address;
    input wire [31:0] data_in;
    input wire request;
    input wire we_re;
    output reg [31:0] data_out;

    reg [31:0] mem [0:4095];

    initial begin 
        if (INIT_MEM)
        $readmemh("tb/instruc.mem",mem);
    end

always @ (posedge clk) begin 
    if (request && we_re)begin 
        if (mask[0])begin
        mem[address][7:0] <= data_in [7:0];
        end
        if (mask[1])begin
            mem[address][15:8] <= data_in [15:8];
        end
        if (mask[2])begin
            mem[address][23:16] <= data_in [23:16];
        end
        if (mask[3])begin
            mem[address][31:24] <= data_in [31:24];
        end
    end
    else if (request && !we_re)begin 
        data_out <= mem[address];
    end
end

endmodule