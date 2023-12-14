 module wrapmem (wrap_in,func3,en,load,wrap_load_in,masking,wrap_out,wrap_load_out,byteadd);
    input wire [31:0] wrap_in;
    input wire [1:0] byteadd;
    input wire [2:0] func3;
    input wire en;
    input wire load;
    input wire [31:0]wrap_load_in;
    output reg [3:0] masking;
    output reg [31:0] wrap_out;
    output reg [31:0] wrap_load_out;
    
    

    always @(*) begin
        if (en) begin
            masking = 4'b0000;
            if(func3==3'b000)begin //sb
               case (byteadd)
                00: begin
                    masking = 4'b0001;
                    wrap_out = wrap_in;
                end
                01: begin
                    masking = 4'b0010;
                    wrap_out = {wrap_in[31:16],wrap_in[7:0],wrap_in[7:0]};
                end
                10: begin
                    masking = 4'b0100;
                    wrap_out = {wrap_in[31:24],wrap_in[7:0],wrap_in[15:0]};
                end
                11: begin
                    masking = 4'b1000;
                    wrap_out = {wrap_in[7:0],wrap_in[23:0]};
                end
               endcase 
            end

            if(func3==3'b001)begin //sh
                case (byteadd)
                 00: begin
                    masking = 4'b0011;
                    wrap_out = wrap_in;
                 end
                 01: begin
                    masking = 4'b0110;
                    wrap_out = {wrap_in[31:24],wrap_in[15:0],wrap_in[7:0]};
                 end
                 10: begin
                    masking = 4'b1100;
                    wrap_out = {wrap_in[15:0],wrap_in[15:0]};
                 end
                endcase   
            end

            if(func3==3'b010) begin //sw
                masking = 4'b1111;
                wrap_out = wrap_in;
            end
        end
    

        if (load)begin
            if(func3==3'b000)begin //lb
                case (byteadd)
                00: begin 
                    wrap_load_out = {{24{wrap_load_in[7]}},wrap_load_in[7:0]};
                end
                01: begin
                    wrap_load_out = {{24{wrap_load_in[15]}},wrap_load_in[15:8]};
                end
                10: begin
                    wrap_load_out = {{24{wrap_load_in[23]}},wrap_load_in[23:16]};
                end
                11: begin
                    wrap_load_out = {{24{wrap_load_in[31]}},wrap_load_in[31:24]};
                end
               endcase
            end

            if(func3==3'b001)begin //lh
                case (byteadd)
                 00: begin
                    wrap_load_out = {{16{wrap_load_in[15]}},wrap_load_in[15:0]};
                 end
                 01: begin
                    wrap_load_out = {{16{wrap_load_in[23]}},wrap_load_in[23:8]};
                 end
                 10: begin
                    wrap_load_out = {{16{wrap_load_in[31]}},wrap_load_in[31:16]};
                 end
                endcase   
            end

            if(func3==3'b010) begin //lw
                wrap_load_out = wrap_load_in;
            end

            if(func3==3'b100)begin //lbu
                case (byteadd)
                00: begin 
                    wrap_load_out = {24'b0,wrap_load_in[7:0]};
                end
                01: begin
                    wrap_load_out = {24'b0,wrap_load_in[15:8]};
                end
                10: begin
                    wrap_load_out = {24'b0,wrap_load_in[23:16]};
                end
                11: begin
                    wrap_load_out = {24'b0,wrap_load_in[31:24]};
                end
               endcase
            end

            if(func3==3'b101)begin //lhu
                case (byteadd)
                 00: begin
                    wrap_load_out = {16'b0,wrap_load_in[15:0]};
                 end
                 01: begin
                    wrap_load_out = {16'b0,wrap_load_in[23:8]};
                 end
                 10: begin
                    wrap_load_out = {16'b0,wrap_load_in[31:16]};
                 end
                endcase   
            end

            if(func3==3'b110) begin //lwu
                wrap_load_out = wrap_load_in;
            end
        end
        
    end


endmodule