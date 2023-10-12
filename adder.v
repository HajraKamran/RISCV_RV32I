module adder(address_out,adder_out);
    input wire [31:0] address_out;
    output reg [31:0] adder_out;

    always @ (*) begin
        adder_out = address_out + 32'd4;
    end
endmodule