module data_mem (clk,en,mask,data_in,address,data_out);
input wire clk;    
input wire en;
input wire [3:0] mask;
input wire [31:0] data_in;
input wire [11:0] address;
output reg [31:0] data_out;

reg [31:0] mem [4095:0];

always @ (posedge clk) begin 
    if (en)begin 
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

always @(*)begin 
    data_out = mem[address];
end
endmodule