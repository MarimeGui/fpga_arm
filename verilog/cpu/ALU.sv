// Performs all mathematical operations

module ALU(
    // Left-Hand Side of the operation
    input [31:0] lhs,
    // RIght-Hand SIde of the operation
    input [31:0] rhs,
    // Micro-Operation
    input [4:0] uop,
    // Result of the operation
    output bit [31:0] out_alu,
    // Flags for condition checking
    /* verilator lint_off ASCRANGE */
    output bit [0:3] flags // [Z, C, N, V] (Zero, Carry, Negative, Overflow)
);

always_latch @(*) begin
    // Reset flags
    flags = 4'b0000;

    // ----- Perform operation
    
    case(uop)
        5'b00001: begin  // ADD
            {flags[1], out_alu} = lhs + rhs; // Set Carry flag (C)
            // Overflow flag (for signed addition): Overflow occurs if signs of lhs and rhs are the same, but result sign differs.
            flags[3] = ((lhs[31] == rhs[31]) && (out_alu[31] != lhs[31])); 
        end
        5'b00010: begin  // SUB
            {flags[1], out_alu} = lhs - rhs; // Set Carry flag (C) for borrow
            // Overflow flag (for signed subtraction): Overflow occurs if signs of lhs and rhs are different, but result sign differs from lhs.
            flags[3] = ((lhs[31] != rhs[31]) && (out_alu[31] != lhs[31]));
        end
        5'b00011: out_alu = lhs & rhs;  
        5'b00100: out_alu = lhs ^ rhs;   
        5'b00101: begin  // CMP (Compare)
            {flags[1], out_alu} = lhs - rhs;  // Calculate difference for flags, but do not store result in `out_alu`
            // Overflow flag for subtraction, same logic as SUB
            flags[3] = ((lhs[31] != rhs[31]) && (out_alu[31] != lhs[31]));
        end
        5'b00110: begin  // LSL (Logical Shift Left)
            {flags[1], out_alu} = {1'd0, lhs << rhs};
        end
        5'b00111: out_alu = lhs >> rhs;  // LSR (Logical Shift Right) 
        5'b01000: out_alu = rhs;  // MOV
        5'b01001, 5'b01010: begin // STR, LDR
            // Just an add for address, but do not set any flags
            out_alu = lhs + rhs;
        end
        default: begin
            // ALU does not need to be used, keep previous values (hence always_latch)
        end
    endcase

    // ----- Compute Flags
    
    // Set the Negative flag (N) based on MSB of the result
    flags[2] = out_alu[31];  

    // Set the Zero flag (Z)
    if (out_alu == 32'b0) 
        flags[0] = 1'b1;  // Zero flag is set if result is zero
    else 
        flags[0] = 1'b0;
end

endmodule
