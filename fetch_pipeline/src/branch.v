module branch (en,op1,op2,func3,branch_out);
input wire en; // en coming from control unit branch
input wire [31:0]op1;
input wire [31:0]op2;
input wire [2:0]func3; // [14:12] bits of input
output reg [31:0] branch_out;

    always @ (*)
    begin 
        if (en==1)begin
        case (func3)
        3'b000:begin 
            branch_out = (op1==op2)?1:0;
        end
        3'b001:begin 
            branch_out = (op1!=op2)?1:0;
        end
        3'b010:begin 
            branch_out = ( $signed(op1) < $signed (op2) )?1:0;
        end
        3'b011:begin 
            branch_out = ( $signed (op1) >= $signed (op2) )?1:0;
        end
        3'b100:begin 
            branch_out = (op1<op2)?1:0;
        end
        3'b101:begin 
            branch_out = (op1>=op2)?1:0;
        end
        default:begin
            branch_out = 0;
         end
        endcase
        end
    end
endmodule