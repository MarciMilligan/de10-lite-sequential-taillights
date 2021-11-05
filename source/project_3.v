module project_3 (ADC_CLK_10, KEY, SW, LEDR, HEX5);
`include "param.vh"

input           ADC_CLK_10;
input   [9:0]   SW;
input   [1:0]   KEY;
output  [9:0]   LEDR;
output  [7:0]   HEX5;

wire    [2:0]   current_state;
wire    [2:0]   next_state;
wire    [3:0]   q;
wire    [2:0]   rom_addr;
wire            rom_clock;
wire            SW0_mux;
wire            SW1_mux;
wire            SW2_mux;
wire            KEY1_mux;

assign SW0_mux  = SW[9] ? q[0] : SW[0];
assign SW1_mux  = SW[9] ? q[1] : SW[1];
assign SW2_mux  = SW[9] ? q[2] : SW[2];
assign KEY1_mux = SW[9] ? q[3] : KEY[1];

nsl NSL_0 (
    .current_state(current_state),
    .next_state(next_state),
    .hzrd_in(SW0_mux),
    .brk_in(SW2_mux),
    .sig_l_in(SW1_mux & KEY1_mux),
    .sig_r_in(SW1_mux & ~KEY1_mux)
);

csl CSL_0 (
    .clock(ADC_CLK_10),
    .reset_n(KEY[0]),
    .next_state(next_state),
    .current_state(current_state)
);

ol OL_0 (
    .in_clock(ADC_CLK_10),
    .current_state(current_state),
    .reset_n(KEY[0]),
    .sig_sw(SW1_mux),
    .LEDR(LEDR[9:0])
);

seg7_decoder SEG7_5 (
    .in(current_state),
    .out(HEX5)
);

rom ROM_0 (
    .address(rom_addr),
    .clock(ADC_CLK_10),
    .q(q)
);

clock_divider_rom CLK_DIV_ROM_0 (
    .in_clock(ADC_CLK_10),
    .reset_n(KEY[0]),
    .out_clock(rom_clock)
);

addr_counter ADDR_CTR_0 (
    .clock(rom_clock),
    .reset_n(KEY[0]),
    .count(rom_addr)
);

endmodule
