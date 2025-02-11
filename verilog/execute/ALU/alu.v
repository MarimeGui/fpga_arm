module ALU(
    input [31:0] LHS,
    input [31:0] RHS,
    input [4:0] uop,
    output reg [31:0] out_alu,
    output wire [3:0] flags_out // [Z, C, N, V] (Zero, Carry, Negative, Overflow)
);

reg [3:0] flags;
assign flags_out = (uop == 0) ? flags_out : flags;

always @(*) begin
    // Reset flags
    //flags = 4'b0000;

    case(uop)
        5'b00000: begin // NOP
            out_alu = 0;
        end
        5'b00001: begin  // ADD
            {flags[1], out_alu} = LHS + RHS; // Set Carry flag (C)
            // Overflow flag (for signed addition): Overflow occurs if signs of LHS and RHS are the same, but result sign differs.
            flags[3] = ((LHS[31] == RHS[31]) && (out_alu[31] != LHS[31]));
        end
        5'b00010: begin  // SUB
            {flags[1], out_alu} = LHS - RHS; // Set Carry flag (C) for borrow
            // Overflow flag (for signed subtraction): Overflow occurs if signs of LHS and RHS are different, but result sign differs from LHS.
            flags[3] = ((LHS[31] != RHS[31]) && (out_alu[31] != LHS[31]));
        end
        5'b00011: begin
            out_alu = LHS & RHS;
            flags[1] <= 0; flags[3] <= 0;
        end
        5'b00100: begin
            out_alu = LHS ^ RHS;
            flags[1] <= 0; flags[3] <= 0;
        end
        5'b00101: begin  // CMP (Compare)
            {flags[1], out_alu} = LHS - RHS;  // Calculate difference for flags, but do not store result in `out_alu`
            // Overflow flag for subtraction, same logic as SUB
            flags[3] = ((LHS[31] != RHS[31]) && (out_alu[31] != LHS[31]));
        end
        5'b00110: begin  // LSL (Logical Shift Left)
            {flags[1], out_alu} = LHS << RHS;
            flags[3] <= 0;
        end
        5'b00111: begin
            out_alu = LHS >> RHS;  // LSR (Logical Shift Right)
            flags[1] <= 0; flags[3] <= 0;
        end 
        5'b01000: begin
            out_alu = RHS;  // MOV
            flags[1] <= 0; flags[3] <= 0;
        end
    endcase
    
    // Set the Negative flag (N) based on MSB of the result
    flags[2] = out_alu[31];  

    // Set the Zero flag (Z)
    if (out_alu == 32'b0) 
        flags[0] = 1'b1;  // Zero flag is set if result is zero
    else 
        flags[0] = 1'b0;
end

endmodule
