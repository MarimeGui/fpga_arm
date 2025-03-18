// Holds all the common registers used by instructions

import Utilities::NOP;
import Utilities::CMP;
import Utilities::STR;

module RegisterFile (
    input clock,
    // While disabled, prevent changing internal state of register file. Synchronous
	input not_enable,
    // Used to prevent overwriting registers for NOP, CMP, STR
    input [4:0] uop,
    // Select registers at input and both output ports
    input [3:0] sel_in, sel_p0, sel_p1,

    // Register input port, will store value for selected register
    input [31:0] in_reg,
    
    // Register data ports, will output current state of selected register
    output bit [31:0] p0, p1,

    // Set flags
    input [3:0] in_flags,
    // Get Flags
    output bit [3:0] out_flags
);

// PC is stored separately

bit [31:0] regs [14:0]; // Internal register file, r0 - r15 (r13 = SP, r14 = LR)
bit [3:0] flags; // Internal flags register

// Register read operation
always @ (posedge clock) begin
    out_flags <= flags;     
    p0 <= regs[sel_p0]; // Read register selected by sel_p0
    p1 <= regs[sel_p1]; // Read register selected by sel_p1
end

// Register write operation
always @ (negedge clock) begin
    if (!(not_enable || (uop == NOP) || (uop == CMP) || (uop == STR))) begin
        regs[sel_in] <= in_reg; // Write to the register selected by sel_in
		flags <= in_flags; // Update flags register
    end
end

endmodule
