module csl (clock, reset_n, next_state, current_state);
`include "param.vh"

input               clock;
input               reset_n;
input       [2:0]   next_state;
output reg  [2:0]   current_state;

always @ (posedge clock, negedge reset_n) begin
    if (reset_n == 0)
        current_state <= IDLE;
    else
        current_state <= next_state;
end

endmodule
