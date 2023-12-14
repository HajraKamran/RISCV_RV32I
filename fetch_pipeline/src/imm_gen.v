module imm_gen (instruc,i_type,s_type,sb_type,uj_type,u_type);
    input wire [31:0] instruc;
    output reg [31:0] i_type,s_type,sb_type,uj_type,u_type;
     
     reg [11:0] i,s;
      
      
   always @(*)begin 
      s [4:0] = instruc [11:7];
      s [11:5] = instruc [31:25];
      i = instruc [31:20];
      i_type = {{20{i[11]}},i};
      s_type = {{20{s[11]}},s};
      sb_type ={{19{instruc[31]}},instruc[31],instruc[7],instruc[30:25],instruc[11:8],1'b0};
      uj_type = {{11{instruc[31]}},instruc[31],instruc[19:12],instruc[20],instruc[30:21],1'b0};
      u_type = {{instruc[31:12]},12'b0};
   end
endmodule