module seg7_decoder (in, out);

input       [2:0]   in;
output reg  [7:0]   out;

always @(*) begin
    case (in)
        3'b000:     out = 8'b1100_0000; // 0
        3'b001:     out = 8'b1111_1001; // 1
        3'b010:     out = 8'b1010_0100; // 2
        3'b011:     out = 8'b1011_0000; // 3
        3'b100:     out = 8'b1001_1001; // 4
        3'b101:     out = 8'b1001_0010; // 5
        3'b110:     out = 8'b1000_0010; // 6
        3'b111:     out = 8'b1111_1000; // 7
        default:    out = 8'b1111_1111; // turn off
    endcase
end

endmodule
