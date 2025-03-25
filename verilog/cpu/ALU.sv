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
    output bit [31:0] out,
    // Flags for condition checking
    /* verilator lint_off ASCRANGE */
    output Flags flags
);

bit is_nop;

always @(*) begin
    is_nop = 0;

    case(uop)
        ADD: begin
            {flags.C, out} = lhs + rhs; // Set Carry flag (C)
            // Overflow flag (for signed addition): Overflow occurs if signs of lhs and rhs are the same, but result sign differs.
            flags.V = ((lhs[31] == rhs[31]) && (out[31] != lhs[31])); 
        end
        SUB: begin
            {flags.C, out} = lhs - rhs; // Set Carry flag (C) for borrow
            // Overflow flag (for signed subtraction): Overflow occurs if signs of lhs and rhs are different, but result sign differs from lhs.
            flags.V = ((lhs[31] != rhs[31]) && (out[31] != lhs[31]));
        end
        AND: begin
            out = lhs & rhs;
            flags.C = 1'b0;
            flags.V = 1'b0;
        end
        EOR: begin
            out = lhs ^ rhs;
            flags.C = 1'b0;
            flags.V = 1'b0;
        end
        CMP: begin
            {flags.C, out} = lhs - rhs;  // Calculate difference for flags, but do not store result in `out`
            // Overflow flag for subtraction, same logic as SUB
            flags.V = ((lhs[31] != rhs[31]) && (out[31] != lhs[31]));
        end
        LSL: begin
            {flags.C, out} = {1'd0, lhs << rhs};
            flags.V = 1'b0; // At check
        end
        LSR: begin
            out = lhs >> rhs;
            flags.C = 1'b0;
            flags.V = 1'b0;
        end
        MOV: begin
            out = rhs;
            flags.C = 1'b0;
            flags.V = 1'b0;
        end
        STR, LDR: begin
            // Just an add for address, but do not set any flags
            out = lhs + rhs;
            is_nop = 1; // Keep flags at 4'b0000
        end
        default: begin
            // NOP or unknown, set to 0
            out = 0;
            is_nop = 1;
        end
    endcase

    if (!is_nop) begin
        // Compute flags
        // Set the Negative flag (N) based on MSB of the result
        flags.N = out[31];
        // Zero flag (Z) is set if result is zero
        flags.Z = (out == 32'b0) ? 1'b1 : 1'b0;
    end else begin
        flags = 0;
    end
end

endmodule
