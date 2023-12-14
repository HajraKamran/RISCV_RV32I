module program_counter (clk,rst,address_in,jal,jalr,address_out,branch_address,jal_address,jalr_address,branch,valid,pre_address,load);
    input wire clk,rst,valid;
    input wire [31:0] address_in;
    input wire [31:0] branch_address;
    input wire [31:0] jal_address;
    input wire [31:0] jalr_address;
    input wire branch,jal,jalr;
    input wire load;

    output reg [31:0] address_out;
    output reg [31:0] pre_address;

    always @ (posedge clk or negedge rst) begin
        if (!rst) begin 
            address_out <= 0;
        end
        else if (branch) begin 
            address_out <= branch_address;
        end
        else if (jal) begin 
            address_out <= jal_address;
        end
        else if (jalr) begin 
            address_out <= jalr_address;
        end
        else if ((load && !valid))begin
            address_out <= address_out;
        end
        else begin
            address_out <= address_out + 32'd4;
        end
            pre_address <= address_out;

        

    end
endmodule