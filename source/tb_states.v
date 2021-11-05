`timescale 1 ns / 100 ps

module tb_project_3();

reg             ADC_CLK_10 = 0;
reg     [1:0]   KEY;
reg     [9:0]   SW;
wire    [9:0]   LEDR;
wire    [7:0]   HEX5;

project_3_no_auto U0 (
    .SW(SW),
    .KEY(KEY),
    .ADC_CLK_10(ADC_CLK_10),
    .LEDR(LEDR),
    .HEX5(HEX5)
);

always #5 ADC_CLK_10 = ~ADC_CLK_10;

initial begin
    $dumpfile("tb_states.vcd");
    $dumpvars;
         SW[0] = 0; SW[1] = 0; SW[2] = 0; KEY[0] = 0; KEY[1] = 0;    // RESET
    #500 SW[0] = 0; SW[1] = 0; SW[2] = 0; KEY[0] = 1; KEY[1] = 0;    // IDLE
    #500 SW[0] = 1; SW[1] = 0; SW[2] = 0; KEY[0] = 1; KEY[1] = 1;    // HZRD
    #500 SW[0] = 0; SW[1] = 1; SW[2] = 0; KEY[0] = 1; KEY[1] = 1;    // SIG_L
    #500 SW[0] = 0; SW[1] = 1; SW[2] = 0; KEY[0] = 1; KEY[1] = 0;    // SIG_R
    #500 SW[0] = 0; SW[1] = 0; SW[2] = 1; KEY[0] = 1; KEY[1] = 1;    // BRK
    #500 SW[0] = 0; SW[1] = 1; SW[2] = 1; KEY[0] = 1; KEY[1] = 1;    // BRK_SIG_L
    #500 SW[0] = 0; SW[1] = 1; SW[2] = 1; KEY[0] = 1; KEY[1] = 0;    // BRK_SIG_R
    #500 $finish;
end

initial begin
    $monitor($time, " SW[0]: %b, SW[1]: %b, SW[2]: %b, KEY[0]: %b, KEY[1]: %b, CLK: %b", SW[0], SW[1], SW[2], KEY[0], KEY[1], ADC_CLK_10);
end

endmodule
