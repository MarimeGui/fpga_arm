module Fetch(
    input clk,

    // Connects to memory data bus
    input [31:0] data,
    // 16-bit LE instruction
    output reg [15:0] instruction
);

// The part that controls access to memory is responsible for fetching PC from Register File and making sure the memory data bus contains the next instruction to execute.
// Also, the Register File is responsible for increasing PC each cycle.
// THe advantage of doing this is that if an instruction modifies PC, the new value will be taken into account when the negative edge falls.

always @(posedge clk) begin
    // Keep highest two bytes, reverse order
    instruction <= data[15:8] | (data[7:0] << 8);
end

endmodule
