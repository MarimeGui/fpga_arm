`timescale 1ns/1ns

module alu_tb();
    reg [31:0] lhs, rhs;
    reg [4:0] uop;
    wire [31:0] out_alu;
    wire [3:0] flags; // [Z, C, N, V]

    // Instantiate the ALU module
    ALU UUT (
        .lhs(lhs),
        .rhs(rhs),
        .uop(uop),
        .out_alu(out_alu),
        .flags(flags)
    );

    initial begin
        // Test 0: NOP
        lhs <= 32'h00000000;
        rhs <= 32'h00000001;
        uop <= 5'b00000;  // Nothing
        #10;
		
        // Test 1: ADD (0 + 1)
        lhs <= 32'h00000000;
        rhs <= 32'h00000001;
        uop <= 5'b00001;  // ADD operation
        #10;

        // Test 2: SUB (1 - 1)
        lhs <= 32'h00000001;
        rhs <= 32'h00000001;
        uop <= 5'b00010;  // SUB operation
        #10;

        // Test 3: AND (0xF0F0F0F0 & 0x0F0F0F0F)
        lhs <= 32'hF0F0F0F0;
        rhs <= 32'h0F0F0F0F;
        uop <= 5'b00011;  // AND operation
        #10;

        // Test 4: XOR (0xAAAAAAAA ^ 0x55555555)
        lhs <= 32'hAAAAAAAA;
        rhs <= 32'h55555555;
        uop <= 5'b00100;  // XOR operation
        #10;

        // Test 5: CMP (Compare 0x7FFFFFFF and 0xFFFFFFFF)
        lhs <= 32'h7FFFFFFF;
        rhs <= 32'hFFFFFFFF;
        uop <= 5'b00101;  // CMP operation
        #10;

        // Test 6: LSL (0x00000001 << 1)
        lhs <= 32'h00000001;
        rhs <= 32'h00000001;
        uop <= 5'b00110;  // LSL (Logical Shift Left)
        #10;

        // Test 7: LSR (0x80000000 >> 1)
        lhs <= 32'h80000000;
        rhs <= 32'h00000001;
        uop <= 5'b00111;  // LSR (Logical Shift Right)
        #10;

        // Test 8: MOV (Move 0x12345678)
        rhs <= 32'h12345678;
        uop <= 5'b01000;  // MOV operation
        #10;
        
        $stop; // End simulation
    end
endmodule
