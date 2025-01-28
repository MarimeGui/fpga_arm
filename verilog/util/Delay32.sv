// Simply delays data coming in by one clock cycle
module Delay32(
    input clk,
    input [31:0] in,
    output reg [31:0] out
);

always @(posedge clk) begin
    out <= in;
end

endmodule
