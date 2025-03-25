// Is responsible for getting the next instruction from ICache

module Fetch(
    input clk,
    input [31:0] delta_i,
    output bit [31:0] index
);

initial begin
    index = 5; // For stating at 10
end

always @(negedge clk) begin
    index <= index + 1 + delta_i;
end

endmodule
