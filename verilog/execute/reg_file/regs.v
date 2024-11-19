module regs (
    input clock,
	input in_enable, // Enable in hight level. A low level disable writing but not for PC
    input [31:0] in_reg, pc_in,
    input [3:0] sel_in, sel_p0, sel_p1,
    input [3:0] flags_in,
    output reg [31:0] p0, p1, pc_out, 
    output reg [3:0] flags_out
);

reg [31:0] regs [15:0]; // Internal register file, r0 - r15 (r13 = SP, r14 = LR, r15 = PC)
reg [3:0] flags;        // Internal flags register

// Register read operation
always @ (negedge clock) begin
    flags_out <= flags; 
    pc_out <= regs[15];  // PC = r15       
    p0 <= regs[sel_p0];  // Read register selected by sel_p0
    p1 <= regs[sel_p1];  // Read register selected by sel_p1
end

// Register write operation
always @ (posedge clock) begin
    regs[15] <= pc_in;      // Update PC (r15) with pc_in
	if (in_enable) begin // Enable or disable writing but not for PC
		regs[sel_in] <= in_reg;     // Write to the register selected by sel_in
		flags <= flags_in;      // Update flags register
	end
end

endmodule
