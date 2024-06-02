    module fetch_pipeline(
         input wire clk,
         input wire [31:0] instruction_fetch,
         input wire [31:0] pc_pre_address,
         input wire Jal,
         input wire Jalr,
         input wire branch_result,
         input wire load,

         output wire [31:0] instruction,
         output wire [31:0] pre_address
     );

         reg [31:0] pre_address_reg , instruction_reg , flush_pipeline;

         //flushing pipling to remove the 2 cycles delay


          always @ (posedge clk)begin

               if(Jal|Jalr|branch_result)begin 
                    instruction_reg <= 32'b0;
                    pre_address_reg <= 32'b0;
                    flush_pipeline <= 1; // Set flag to flush for one cycle
          end
          else begin
               if (flush_pipeline) begin
               // Stall the pipeline for one additional cycle after flushing
                    instruction_reg <= 32'b0;
                    pre_address_reg <= 32'b0;
                    flush_pipeline <= 0; // Reset flag after one cycle stall
          end
          else if (load) begin
               //stall pipeline
               pre_address_reg <= pre_address;
               instruction_reg <= instruction;
          end
          else begin
               pre_address_reg <= pc_pre_address;
               instruction_reg <= instruction_fetch;
         end
          end
          end

         //it will assign address and instruc without clk as it is in continuous state
         assign pre_address = pre_address_reg;
         assign instruction = instruction_reg;




    endmodule