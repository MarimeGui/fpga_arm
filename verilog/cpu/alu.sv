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
    output bit [0:3] flags_out // [Z, C, N, V] (Zero, Carry, Negative, Overflow)
);

bit is_nop;
bit [3:0] flags;

initial begin
    // Reset flags
    flags = 4'b0000;
end

always @(*) begin

    // ----- Perform operation
    
	is_nop = 1'b0;
	
    case(uop)
		5'b00000: begin // NOP
           out_alu = 32'b0;	
	       is_nop = 1'b1; // Flags do not change
	    end
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
        5'b00011: begin
			out_alu = lhs & rhs;
			flags[1] = 1'b0; flags[3] = 1'b0;
		end
        5'b00100: begin
			out_alu = lhs ^ rhs;
			flags[1] = 1'b0; flags[3] = 1'b0;
		end
        5'b00101: begin  // CMP (Compare)
            {flags[1], out_alu} = lhs - rhs;  // Calculate difference for flags, but do not store result in `out_alu`
            // Overflow flag for subtraction, same logic as SUB
            flags[3] = ((lhs[31] != rhs[31]) && (out_alu[31] != lhs[31]));
        end
        5'b00110: begin  // LSL (Logical Shift Left)
            {flags[1], out_alu} = lhs << rhs;
			flags[3] = 1'b0; // A vérifier
        end
        5'b00111: begin
			out_alu = lhs >> rhs;  // LSR (Logical Shift Right)
			flags[1] = 1'b0; flags[3] = 1'b0;
		end
        5'b01000: begin
			out_alu = rhs;  // MOV
			flags[1] = 1'b0; flags[3] = 1'b0;
		end
        5'b01001, 5'b01010: begin // STR, LDR
            // Just an add for address, but do not set any flags
            out_alu = lhs + rhs;
            flags[1] = 4'b0000;
            is_nop = 1'b1; // Keep flags at 4'b0000
        end
		default: begin // NOP
		    out_alu = 32'b0;
			is_nop = 1'b1; // Flags do not change
		end
    endcase

	if (!is_nop) begin
		    
        // ----- Compute Flags
    
        // Set the Negative flag (N) based on MSB of the result
        flags[2] = out_alu[31];
        // Zero flag (Z) is set if result is zero
        flags[0] = (out_alu == 32'b0) ? 1'b1 : 1'b0;
    end
    
	flags_out = flags;
end

// flags_out always receives flags
always @(*) begin
    flags_out = flags;
end

endmodule
