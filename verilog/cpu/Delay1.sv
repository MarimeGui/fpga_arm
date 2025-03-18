// Simply delays data coming in by one clock cycle

module Delay1(
    input clk,
    input in,
    output bit out
);

always @(posedge clk) begin
    out <= in;
end

endmodule
