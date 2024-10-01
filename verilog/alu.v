module ALU(
    input [31:0] LHS,
    input [31:0] RHS,
    input [4:0] uop,
    output reg [31:0] out,
    output reg [3:0] flags // [Z, C, N, V] (Zero, Carry, Negative, Overflow)
);

always @(*) begin
    // Reset flags
    flags = 4'b0000;

    case(uop)
        5'b00001: begin  // ADD
            {flags[1], out} = LHS + RHS; // Set Carry flag (C)
            // Overflow flag (for signed addition): Overflow occurs if signs of LHS and RHS are the same, but result sign differs.
            flags[3] = ((LHS[31] == RHS[31]) && (out[31] != LHS[31])); 
        end
        5'b00010: begin  // SUB
            {flags[1], out} = LHS - RHS; // Set Carry flag (C) for borrow
            // Overflow flag (for signed subtraction): Overflow occurs if signs of LHS and RHS are different, but result sign differs from LHS.
            flags[3] = ((LHS[31] != RHS[31]) && (out[31] != LHS[31]));
        end
        5'b00011: out = LHS & RHS;  
        5'b00100: out = LHS ^ RHS;   
        5'b00101: begin  // CMP (Compare)
            {flags[1], out} = LHS - RHS;  // Calculate difference for flags, but do not store result in `out`
            // Overflow flag for subtraction, same logic as SUB
            flags[3] = ((LHS[31] != RHS[31]) && (out[31] != LHS[31]));
        end
        5'b00110: begin  // LSL (Logical Shift Left)
            {flags[1], out} = LHS << RHS;  
        end
        5'b00111: out = LHS >> RHS;  // LSR (Logical Shift Right) 
        5'b01000: out = RHS;  // MOV 
    endcase
    
    // Set the Negative flag (N) based on MSB of the result
    flags[2] = out[31];  

    // Set the Zero flag (Z)
    if (out == 32'b0) 
        flags[0] = 1'b1;  // Zero flag is set if result is zero
    else 
        flags[0] = 1'b0;
end

endmodule
