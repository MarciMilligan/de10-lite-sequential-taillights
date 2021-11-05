module clock_divider (in_clock, reset_n, out_clock);
input       in_clock;
input       reset_n;
output reg  out_clock;

reg [23:0]  count;

always @ (posedge in_clock, negedge reset_n) begin
    if (reset_n == 0) begin
        count <= 0;
        out_clock = 0;
    end else if (count < 1000000)
        count <= count + 1;
    else begin
        count = 0;
        out_clock = !out_clock;
    end
end
endmodule
