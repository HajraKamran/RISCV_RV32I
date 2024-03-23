    module fetch_pipeline(
         input wire clk,
         input wire [31:0] instruction_fetch,
         input wire [31:0] pc_pre_address,

         output wire [31:0] instruction,
         output wire [31:0] pre_address
     );

         reg [31:0] pre_address_reg , instruction_reg;

         //flushing pipling to remove the 2 cycles delay


          always @ (posedge clk)begin

               if(Jal|Jalr|branch_result)begin 
                    instruction <= 32'b0;
                    pre_address <= 32'b0;
                    

          end
          end


         always @ (posedge clk) begin
                pre_address_reg <= pc_pre_address;
                instruction_reg <= instruction_fetch;
         end
         //it will assign address and instruc without clk as it is in continuous state
         assign pre_address = pre_address_reg;
         assign instruction = instruction_reg;




    endmodule