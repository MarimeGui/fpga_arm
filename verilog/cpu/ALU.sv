// Performs all mathematical operations

import Utilities::NOP;
import Utilities::ADD;
import Utilities::SUB;
import Utilities::AND;
import Utilities::EOR;
import Utilities::CMP;
import Utilities::LSL;
import Utilities::LSR;
import Utilities::MOV;
import Utilities::STR;
import Utilities::LDR;

import Utilities::Flags;

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
    output Flags flags_out
);

bit is_nop;
Flags flags;

initial begin
    // Reset flags
    flags = 4'b0000;
	out_alu = 32'b0;
end

always_latch @(*) begin
    
	is_nop = 0;

    // ----- Perform operation
    
    case(uop)
		NOP: begin
           is_nop = 1; // Flags do not change
	    end
        ADD: begin
            {flags.C, out_alu} = lhs + rhs; // Set Carry flag (C)
            // Overflow flag (for signed addition): Overflow occurs if signs of lhs and rhs are the same, but result sign differs.
            flags.V = ((lhs[31] == rhs[31]) && (out_alu[31] != lhs[31])); 
        end
        SUB: begin
            {flags.C, out_alu} = lhs - rhs; // Set Carry flag (C) for borrow
            // Overflow flag (for signed subtraction): Overflow occurs if signs of lhs and rhs are different, but result sign differs from lhs.
            flags.V = ((lhs[31] != rhs[31]) && (out_alu[31] != lhs[31]));
        end
        AND: begin
			out_alu = lhs & rhs;
			flags.C = 1'b0; flags.V = 1'b0;
		end
        EOR: begin
			out_alu = lhs ^ rhs;
			flags.C = 1'b0; flags.V = 1'b0;
		end
        CMP: begin
            {flags.C, out_alu} = lhs - rhs;  // Calculate difference for flags, but do not store result in `out_alu`
            // Overflow flag for subtraction, same logic as SUB
            flags.V = ((lhs[31] != rhs[31]) && (out_alu[31] != lhs[31]));
        end
        LSL: begin
            {flags.C, out_alu} = {1'd0, lhs << rhs};
			flags.V = 1'b0; // At check
        end
        LSR: begin
			out_alu = lhs >> rhs;
			flags.C = 1'b0; flags.V = 1'b0;
		end
        MOV: begin
			out_alu = rhs;
			flags.C = 1'b0; flags.V = 1'b0;
		end
        STR, LDR: begin
            // Just an add for address, but do not set any flags
            out_alu = lhs + rhs;
            flags = 4'b0000;
            is_nop = 1; // Keep flags at 4'b0000
        end
        default: begin
            // ALU does not need to be used, keep previous values (hence always_latch)
			is_nop = 1; // Flags do not change
        end
    endcase

	if (!is_nop) begin
		// ----- Compute Flags
		
		// Set the Negative flag (N) based on MSB of the result
		flags.N = out_alu[31];

		// Zero flag (Z) is set if result is zero
		flags.Z = (out_alu == 32'b0) ? 1'b1 : 1'b0;
	end
    
    flags_out = flags;
end

always @(*) begin
    flags_out = flags;
end

endmodule