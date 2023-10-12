module instruc_mem (clk,address,en,i_data_in,i_data_out);
    input wire clk;
    input wire en;
    input wire [11:0] address;
    input wire [31:0] i_data_in;
    output reg [31:0] i_data_out;

    reg [31:0] mem [4095:0];

    initial begin 
        $readmemh("instruc.mem",mem);
    end
    always @ (posedge clk)begin 
        if (en)begin 
            mem [address] <= i_data_in;
        end
    end 
    always @ (*)begin 
       i_data_out = mem [address] ;
    end
endmodule
    