// Is responsible for getting the next instruction from ICache

module Fetch(
    input clk,
    input reset,
    input [31:0] delta_i,
    output bit [31:0] index
);

initial begin
    index = 5; // For stating at 10
end

always @(negedge clk) begin
    if (!reset) begin
        // If not held in reset, increment with clk
        index <= index + 1 + delta_i;
    end else begin
        // When held in reset, keep index at 5
        index <= 5;
    end
end

endmodule
