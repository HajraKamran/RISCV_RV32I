module memory (clk,address,we_re,request,signal,valid,mask,data_in,data_out);
    input wire clk;
    input wire [3:0] mask;
    input wire [11:0] address;
    input wire [31:0] data_in;
    input wire request;
    input wire we_re;
    input wire signal;
    output reg valid;
    output reg [31:0] data_out;

    reg [31:0] mem [0:4095];

    initial begin 
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
end

always @ (posedge clk) begin
        if (request && we_re==1'b0) begin
            valid <= 1'b1;
            data_out <= mem[address];
        end
end
 
endmodule