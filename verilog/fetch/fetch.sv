module Fetch(
    input clk,
	input [31:0] delta_i,
	output reg [31:0] index
);

initial begin
	index = 9; // For stating at 10
end

always @(posedge clk) begin
    index += 1 + delta_i;
end

endmodule
