module regs (
    input clock,
    input [31:0] in, pc_in,
    input [3:0] sel_in, sel_p0, sel_p1,
    input [3:0] flags_in,
    output reg [31:0] p0, p1, pc_out, 
    output reg [3:0] flags_out,
    output reg [31:0] regs [15:0] // r0 - r15 (r13-15 = SP, LR, PC)
);

reg [3:0] flags; 


always @ (negedge clock) begin // Register read operation
    flags_out <= flags; 
    pc_out <= regs[15]; // PC = r15       

    p0 <= regs[sel_p0];
    p1 <= regs[sel_p1];
end

always @ (posedge clock) begin // Register write operation
    regs[sel_in] <= in;         
    flags <= flags_in;
    regs[15] <= pc_in;          
end

endmodule
