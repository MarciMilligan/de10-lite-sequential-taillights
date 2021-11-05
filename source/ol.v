module ol (in_clock, current_state, reset_n, sig_sw, LEDR);
`include "param.vh"

input               in_clock;
input               reset_n;
input               sig_sw;
input       [2:0]   current_state;
output reg  [9:0]   LEDR;

wire            clock;
wire            LED_A;
wire            LED_B;
wire            LED_C;
wire            signal_reset;
reg     [2:0]   prev_state;

// restart turn signal sequence on state change
assign signal_reset = (prev_state == current_state) ? reset_n : 0;
always @ (posedge in_clock) begin
    prev_state = current_state;
end

clock_divider CLK_DIV_0 (
    .in_clock(in_clock),
    .reset_n(reset_n),
    .out_clock(clock)
);

signal_blink SIG_BLK_0 (
    .in_clock(clock),
    .reset_n(signal_reset),
    .LED_A(LED_A),
    .LED_B(LED_B),
    .LED_C(LED_C)
);

always @ (*) begin
    case (current_state)
        IDLE:       LEDR <= 10'b00_0000_0000;
        HZRD:       begin
                        LEDR[6:3] <= 4'b0000;
                        LEDR[9:7] <= {LED_B, LED_B, LED_B};
                        LEDR[2:0] <= {LED_B, LED_B, LED_B};
                    end
        SIG_L:      begin
                        LEDR[6:0] <= 7'b000_0000;
                        LEDR[9:7] <= {LED_C, LED_B, LED_A};
                    end
        SIG_R:      begin
                        LEDR[9:3] <= 7'b000_0000;
                        LEDR[2:0] <= {LED_A, LED_B, LED_C};
                    end
        BRK:        LEDR <= 10'b11_1000_0111;
        BRK_SIG_L:  begin
                        LEDR[6:0] <= 7'b000_0111;
                        LEDR[9:7] <= {LED_C, LED_B, LED_A};
                    end
        BRK_SIG_R:  begin
                        LEDR[9:3] <= 7'b111_0000;
                        LEDR[2:0] <= {LED_A, LED_B, LED_C};
                    end
        default:    LEDR <= 10'b00_0000_0000;
    endcase
end

endmodule
