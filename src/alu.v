module alu (a,b,op,res_o);
    input wire [31:0] a;
    input wire [31:0] b;
    input wire  [3:0] op;
    output reg [31:0] res_o;
    always @ (*)
    begin
        case(op)
    4'b0000: begin
        res_o=a+b;
    end
    4'b0001 :begin
        res_o=a-b;
    end
    4'b0010 :begin
        res_o=a&b;
    end
    4'b0011 :begin
        res_o=a|b;end
    4'b0100 :begin
        res_o=a^b;end
    4'b0101 :begin
        res_o=a<<b;end
    4'b0110 :begin
        res_o=a>>b;end
    4'b0111 :begin
        res_o=a>>>b;end
    4'b1000 :begin
        res_o=$signed (a) < $signed (b);end
    4'b1001 :begin
        res_o=a<b;end
    default: begin
    res_o=a>>b;
    end
    endcase
    end
endmodule