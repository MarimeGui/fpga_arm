module ALU(
    input [31:0] LHS,
    input [31:0] RHS,
    input [4:0] uop,
    output reg [31:0] out_alu,
    output reg [3:0] flags_out // 4'bVNCZ : V=Overflow, N=Negative, C=Carry, Z=Zero
);

	reg is_nop;
    reg [3:0] flags;
	
	initial begin
		flags = 4'b0000;
	end

    always @(*) begin
		is_nop = 0;
        case (uop)
			5'b00000: begin // NOP
				out_alu = 32'b0;	
				is_nop = 1; // Flags do not change
			end
            5'b00001: begin  // ADD
                {flags[1], out_alu} = LHS + RHS; // Set Carry flag (C)
                flags[3] = ((LHS[31] == RHS[31]) && (out_alu[31] != LHS[31])); // Set Overflow flag
            end
            5'b00010: begin  // SUB
                {flags[1], out_alu} = LHS - RHS; // Set Carry flag (C)
                flags[3] = ((LHS[31] != RHS[31]) && (out_alu[31] != LHS[31])); // Set Overflow flag
            end
            5'b00011: begin // AND
                out_alu = LHS & RHS;
                flags[1] = 0; // Set Carry (borrow)
				flags[3] = 0; // Set Overflow flag
            end
            5'b00100: begin // XOR
                out_alu = LHS ^ RHS;
                flags[1] = 0; // Set Carry (borrow)
				flags[3] = 0; // Set Overflow flag
            end
            5'b00101: begin  // CMP (Compare)
                {flags[1], out_alu} = LHS - RHS; // Set Carry (borrow)
                flags[3] = ((LHS[31] != RHS[31]) && (out_alu[31] != LHS[31])); // Set Overflow flag
            end
            5'b00110: begin  // LSL (Logical Shift Left)
                {flags[1], out_alu} = LHS << RHS; // Set Carry (borrow)
                flags[3] = flags[1]; // Set Overflow flag
            end
            5'b00111: begin // LSR (Logical Shift Right)
                out_alu = LHS >> RHS;
                flags[1] = 0; // Set Carry (borrow)
				flags[3] = 0; // Set Overflow flag
            end
            5'b01000: begin // MOV
                out_alu = RHS;
                flags[1] = 0; // Set Carry (borrow)
				flags[3] = 0; // Set Overflow flag
            end
			default: begin // NOP
			    out_alu = 32'b0;
				is_nop = 1; // Flags do not change
			end
        endcase

		if (!is_nop) begin
			// Flags Zero (Z) and Negative (N)
			flags[2] = out_alu[31];  // Negative flag (N)
			flags[0] = (out_alu == 32'b0) ? 1'b1 : 1'b0;  // Zero flag (Z)
		end
		
		flags_out = flags;
    end
	
    // flags_out always receives flags
    always @(*) begin
        flags_out = flags;
    end

endmodule
