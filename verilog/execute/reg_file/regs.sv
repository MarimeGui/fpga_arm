// TODO: uOp input, disable either in reg or in flags for NOP, CMP, STR

module regs (
    input clock,
    // While disabled, prevent changing internal state of register file. Synchronous
	input not_enable,

    // Select registers at input and both output ports
    input [3:0] sel_in, sel_p0, sel_p1,

    // Register input port, will store value for selected register
    input [31:0] in_reg,
    
    // Register data ports, will output current state of selected register
    output reg [31:0] p0, p1,

    // Set flags
    input [3:0] in_flags,
    // Get Flags
    output reg [3:0] out_flags
);

// PC is stored separately

bit [31:0] regs [14:0] ; // Internal register file, r0 - r15 (r13 = SP, r14 = LR)
bit [3:0] flags ; // Internal flags register

// Register read operation
always @ (posedge clock) begin
    out_flags <= flags;     
    p0 <= regs[sel_p0]; // Read register selected by sel_p0
    p1 <= regs[sel_p1]; // Read register selected by sel_p1
end

// Register write operation
always @ (negedge clock) begin
    if (!not_enable) begin
        regs[sel_in] <= in_reg; // Write to the register selected by sel_in
		flags <= in_flags; // Update flags register
    end
end

endmodule
