  module typedec (op,r_type,i_type,s_type,load,sb_type,auipc,jal,jalr,lui);
  input wire [6:0] op;
  output reg r_type;
  output reg i_type;
  output reg s_type;
  output reg load;
  output reg sb_type;
  output reg auipc;
  output reg  jal;
  output reg  jalr;
  output reg  lui;
  
  always @(*)begin 
    r_type = 1'b0;
    i_type = 1'b0;
    s_type = 1'b0;//store
    load = 1'b0;
    sb_type = 1'b0;//branch
    auipc = 1'b0; // u_type
    jal = 1'b0; //uj type
    jalr = 1'b0; //uj type
    lui = 1'b0; //u type
  case(op)
    7'b0110011:begin 
      r_type = 1'b1;
    end 
    7'b0010011:begin 
      i_type<=1'b1;
    end
    7'b0100011:begin 
      s_type<=1'b1;
    end
     7'b0000011:begin 
      load<=1'b1;
    end
    7'b1100011:begin 
      sb_type<=1'b1;
    end
     7'b0010111:begin 
      auipc<=1'b1;
    end
    7'b1101111:begin 
      jal<=1'b1;
    end
    7'b1100111:begin 
      jalr<=1'b1;
    end
    7'b0110111:begin 
      lui<=1'b1;
    end

    default:begin 
      r_type = 1'b0;
      i_type = 1'b0;
      s_type = 1'b0;
      load = 1'b0;
      sb_type = 1'b0;
      auipc = 1'b0; // u_type
      jal = 1'b0; //uj type
      jalr = 1'b0; //uj type
      lui = 1'b0; //u type
      end
  endcase
  end  
  endmodule