module ALU(
    input [31:0] LHS,
    input [31:0] RHS,
    input [4:0] uop,
    output reg [31:0] out_alu,
    output reg [3:0] flags_out // [Z, C, N, V] (Zero, Carry, Negative, Overflow)
);

    reg [3:0] flags;

    always @(*) begin
        // keeps flag values as standard
        flags = flags_out;

        case (uop)
            5'b00000: begin // NOP
                out_alu = 0;
                // Flags do not change
            end
            5'b00001: begin  // ADD
                {flags[1], out_alu} = LHS + RHS; // Set Carry flag (C)
                flags[3] = ((LHS[31] == RHS[31]) && (out_alu[31] != LHS[31])); // Overflow flag
            end
            5'b00010: begin  // SUB
                {flags[1], out_alu} = LHS - RHS; // Carry (borrow)
                flags[3] = ((LHS[31] != RHS[31]) && (out_alu[31] != LHS[31])); // Overflow
            end
            5'b00011: begin // AND
                out_alu = LHS & RHS;
                flags[1] = 0; flags[3] = 0;
            end
            5'b00100: begin // XOR
                out_alu = LHS ^ RHS;
                flags[1] = 0; flags[3] = 0;
            end
            5'b00101: begin  // CMP (Compare)
                {flags[1], out_alu} = LHS - RHS;
                flags[3] = ((LHS[31] != RHS[31]) && (out_alu[31] != LHS[31]));
            end
            5'b00110: begin  // LSL (Logical Shift Left)
                {flags[1], out_alu} = LHS << RHS;
                flags[3] = 0;
            end
            5'b00111: begin // LSR (Logical Shift Right)
                out_alu = LHS >> RHS;
                flags[1] = 0; flags[3] = 0;
            end 
            5'b01000: begin // MOV
                out_alu = RHS;
                flags[1] = 0; flags[3] = 0;
            end
        endcase

        // Flags Zero (Z) and Negative (N)
        flags[2] = out_alu[31];  // Negative flag (N)
        flags[0] = (out_alu == 32'b0) ? 1'b1 : 1'b0;  // Zero flag (Z)
    end

    // flags_out always receives flags
    always @(*) begin
        flags_out = flags;
    end

endmodule
