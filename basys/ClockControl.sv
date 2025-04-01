module ClockControl(
    input sysclk,
    input clk,

    input manual_button_pulse,
    input automatic_button_pulse,

    output bit clk_out
);

    // 0 is in auto mode, 1 is manual presses
    bit state;

    wire automatic_int = clk & (state == 0);
    wire manual_int = manual_button_pulse & (state == 1);

    assign clk_out = manual_int | automatic_int;

    always @(posedge sysclk) begin
        if (manual_button_pulse == 1) begin
            state <= 1;
        end else if (automatic_button_pulse == 1) begin
            state <= 0;
        end
    end

endmodule
