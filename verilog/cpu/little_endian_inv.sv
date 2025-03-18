// Simply invert the first and second byte for Little Endian decoding
// In the future, this could be expanded to handle 32-bit instructions.

module LittleEndianInverter(
    input [15:0] from_memory,
    output bit [15:0] instruction
);

always @ (*) begin
    instruction = {from_memory[7:0], from_memory[15:8]};
end

endmodule
