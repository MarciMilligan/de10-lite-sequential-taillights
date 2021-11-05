module addr_counter (clock, reset_n, count);
input               clock;
input               reset_n;
output reg  [2:0]   count;

always @ (posedge clock, negedge reset_n) begin
    if (reset_n == 0)
        count <= 0;
    else if (count < 6)
        count <= count + 1;
    else begin
        count = 0;
    end
end
endmodule
