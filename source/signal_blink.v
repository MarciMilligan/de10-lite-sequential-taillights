module signal_blink (in_clock, reset_n, LED_A, LED_B, LED_C);
input       in_clock;
input       reset_n;
output reg  LED_A;
output reg  LED_B;
output reg  LED_C;

reg [2:0]   count;

always @ (posedge in_clock, negedge reset_n) begin
    if (reset_n == 0)
        count <= 0;
    else if (count < 3)
        count <= count + 1;
    else
        count <= 0;

    case (count)
        0:  begin
                LED_A = 0;
                LED_B = 0;
                LED_C = 0;
            end
        1:  begin
                LED_A = 1;
                LED_B = 0;
                LED_C = 0;
            end
        2:  begin
                LED_A = 1;
                LED_B = 1;
                LED_C = 0;
            end
        3:  begin
                LED_A = 1;
                LED_B = 1;
                LED_C = 1;
            end
    endcase
end

endmodule
