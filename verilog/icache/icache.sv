// Cache-like module for storing instructions

module ICache (
    input clk,
    input not_enable,

    input [31:0] index,
    output bit [15:0] data,

    input write,
    input [31:0] instruction_index,
    input [15:0] instruction
);

// 128 16-bit memory cells
bit [15:0] instructions [128:0];

always @(negedge clk) begin
    if(write) begin
        instructions[instruction_index] <= instruction;
    end
end

always @(posedge clk) begin
    if (!write) begin	
        if (!not_enable) begin
            // Send the selected (index) memory cell
            data <= instructions[index];
        end else begin
            // Module disable
            data <= 1'b0;
        end
    end
end

endmodule
