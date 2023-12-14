module regfile (clk,en,instruction,rst,rs1,rs2,rd,op1,op2);
input wire clk;
input wire en;
input wire rst;
input wire [4:0] rs1;
input wire [4:0] rs2;
input wire [4:0] rd;
input wire [31:0]instruction;
output wire [31:0] op1;
output wire [31:0] op2;

reg [31:0] reg_file [31:0];
integer i;

always @(posedge clk or negedge rst)begin 
    reg_file[0]<=0;
    if (!rst)begin 
        for (i=1;i<=31;i++) begin 
            reg_file[i]<=0;
        end
    end
    else if (en) begin 
        reg_file[rd]<=instruction;
    end
end

assign op1=reg_file[rs1];
assign op2=reg_file[rs2];

endmodule