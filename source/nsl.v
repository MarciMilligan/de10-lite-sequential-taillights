module nsl (current_state, next_state, hzrd_in, brk_in, sig_l_in, sig_r_in);
`include "param.vh"

input       [2:0]   current_state;
input               hzrd_in;
input               brk_in;
input               sig_l_in;
input               sig_r_in;
output reg  [2:0]   next_state;

always @ (*) begin
    if (hzrd_in == 1)
        next_state <= HZRD;
    else begin
        case ({brk_in, sig_l_in, sig_r_in})
            3'b001:     next_state <= SIG_R;
            3'b010:     next_state <= SIG_L;
            3'b100:     next_state <= BRK;
            3'b101:     next_state <= BRK_SIG_R;
            3'b110:     next_state <= BRK_SIG_L;
            default:    next_state <= IDLE;
        endcase
    end
end

endmodule
