// Cache-like module for storing instructions

module ICache (
    input clk,
    input not_enable,

    input write_enable,
    input [31:0] write_instruction_index,
    input [15:0] write_instruction,

    input [31:0] index,
    output bit [15:0] data
);

// 128 16-bit memory cells
bit [15:0] instructions [128:0];

always @(negedge clk) begin
    if(write_enable) begin
        instructions[write_instruction_index] <= write_instruction;
    end
end

always @(posedge clk) begin
    if (!write_enable) begin
        // Send the selected (index) memory cell
        data <= instructions[index];
    end
end

endmodule
