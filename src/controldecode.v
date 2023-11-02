module controldecode (r_type,i_type,s_type,load,func3,func7,lui,auipc,Lui,Auipc,reg_write,jal,jalr,Jal,Jalr,op_b,op_a,alu_control,next_sel,mem_en,mem_to_reg,s,loadout,imm_sel,branch,Branch);
  input wire r_type;
  input wire i_type;
  input wire s_type;
  input wire load;
  input wire branch;
  input wire [2:0]func3;
  input wire func7;
  input wire jal;
  input wire jalr;
  input wire lui;
  input wire auipc;
  

  output reg reg_write;
  output reg op_a;
  output reg op_b;
  output reg [3:0]alu_control;
  output reg [1:0]mem_to_reg;
  output reg s;
  output reg loadout;
  output reg [2:0] imm_sel;
  output reg next_sel;
  output reg mem_en;
  output reg Branch;
  output reg Jal;
  output reg Jalr;
  output reg Auipc;
  output reg Lui;


  always @(*)begin 
    reg_write = r_type | i_type | load | jal | jalr | lui | auipc;
    op_a = branch | jal|auipc;
    op_b = i_type | load | branch | s_type | jal | jalr|auipc |lui;
    loadout = load;
    s = s_type;
    mem_to_reg = load;
    mem_en = s_type;
    Branch = branch;
    next_sel = branch;
    Jal = 1'b0;
    Jalr = 1'b0;
  
    if (r_type)
    mem_to_reg = 2'b00;
      if(func7)
        case (func3)
          3'b000 : begin 
          alu_control = 0001; // subtract
          end
          3'b101:begin 
          alu_control = 0111; // sra
          end
        endcase
      else case (func3)
          3'b000:begin 
            alu_control = 0000; //add
          end
          3'b001:begin 
            alu_control = 0010; //and
          end
          3'b010:begin 
            alu_control = 0011; // or
          end
          3'b011:begin 
            alu_control = 0100; //xor
          end
          3'b100:begin 
            alu_control = 0101; //sll
          end
          3'b101:begin 
            alu_control = 0110; // srl
          end
          3'b110:begin 
            alu_control = 1000; //slt
          end
          3'b111:begin 
            alu_control = 1001; //sltu
          end
          endcase


    if (i_type)
    imm_sel = 000;
    mem_to_reg = 2'b00;
      if(func7)
        case (func3)
          3'b101 : begin 
            alu_control = 0111;
          end
        endcase
    else case (func3)
          3'b000:begin 
            alu_control = 0000;
          end
          3'b001:begin 
            alu_control = 0010;
          end
          3'b010:begin 
            alu_control = 0011;
          end
          3'b011:begin 
            alu_control = 0100;
          end
          3'b100:begin 
            alu_control = 0101;
          end
          3'b101:begin 
            alu_control = 0110;
          end
          3'b110:begin 
            alu_control = 1000;
          end
          3'b111:begin 
            alu_control = 1001;
          end
    endcase

       if (s_type) begin //store
        imm_sel = 001;
        mem_to_reg = 2'b00;
        
        case (func3) 
        3'b000: begin //sb
            alu_control = 4'b0000;
        end
        3'b001:begin //sh
            alu_control = 4'b0000;
        end
        3'b010:begin //sw
            alu_control = 4'b0000;
        end
        endcase
       end
        if (load)begin 
            imm_sel = 3'b000;
            mem_to_reg = 2'b00;
          case (func3) 
          3'b000:begin //lb
              alu_control = 4'b0000;
          end
          3'b001:begin //lh
              alu_control = 4'b0000;
          end
          3'b010:begin //lw
              alu_control = 4'b0000;
          end
          3'b100:begin //lbu
              alu_control = 4'b0000;
          end
          3'b101:begin //lhu
              alu_control = 4'b0000;
          end
          endcase
        end
        if (branch)begin
        alu_control = 4'b0000;
        imm_sel = 010; //branch selection
    end
    
     if (jal)begin
        mem_to_reg = 2'b10;
        Jal = jal;
        alu_control = 4'b0000;
        imm_sel = 3'b011;//jal selection
    end
    if(jalr)begin
        Jalr = jalr;
        mem_to_reg = 2'b00;
        alu_control = 4'b0000;
        imm_sel = 3'b000;//i_type selection
    end
    else if(lui)begin
        mem_to_reg = 2'b00;
        Lui =lui;
        imm_sel = 3'b100;//u_type selection
    end
        else if(auipc)begin
        mem_to_reg = 2'b00;
        Auipc =auipc;
        alu_control = 4'b0000;
        imm_sel = 3'b100;//u_type selection
    end
    end
endmodule

  