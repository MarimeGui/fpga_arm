// Display a decimal number on the 4 digit 7-segment display

module DisplayDecimalValue(
    input sysclk,

    input [14:0] value,
    input [3:0] dot_pattern,

    output bit [7:0] segments,
    output bit [3:0] digit_disable
);

wire clk;

ClockDivisor #(10000) i_divisor(
    .clk_in(sysclk),
    .clk_out(clk)
);

wire [6:0] all_segments [3:0];

NumToSegments i_seg_four(
    .num((value/1000) % 10),
    .segments(all_segments[3])
);

NumToSegments i_seg_three(
    .num((value/100) % 10),
    .segments(all_segments[2])
);

NumToSegments i_seg_two(
    .num((value/10) % 10),
    .segments(all_segments[1])
);

NumToSegments i_seg_one(
    .num(value % 10),
    .segments(all_segments[0])
);

bit [1:0] counter;

always @(posedge clk) begin
    digit_disable <= ~(1 << counter); // Select correct digit
    segments <= all_segments[counter]; // Main digit
    segments[7] <= (~dot_pattern) >> (counter); // Dot

    // Let overflow happen
    counter <= counter + 1;
end

endmodule
