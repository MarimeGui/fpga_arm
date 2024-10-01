module alu_tb();
    reg [31:0] LHS, RHS;
    reg [4:0] uop;
    wire [31:0] out;
    wire [3:0] flags; // [Z, C, N, V]

    // Instantiate the ALU module
    ALU UUT (
        .LHS(LHS),
        .RHS(RHS),
        .uop(uop),
        .out(out),
        .flags(flags)
    );

    initial begin
        $dumpfile("dump.vcd"); 
        $dumpvars(0, alu_tb);

        // Test 1: ADD (0 + 1)
        LHS <= 32'h00000000;
        RHS <= 32'h00000001;
        uop <= 5'b00001;  // ADD operation
        #10;

        // Test 2: SUB (1 - 1)
        LHS <= 32'h00000001;
        RHS <= 32'h00000001;
        uop <= 5'b00010;  // SUB operation
        #10;

        // Test 3: AND (0xF0F0F0F0 & 0x0F0F0F0F)
        LHS <= 32'hF0F0F0F0;
        RHS <= 32'h0F0F0F0F;
        uop <= 5'b00011;  // AND operation
        #10;

        // Test 4: XOR (0xAAAAAAAA ^ 0x55555555)
        LHS <= 32'hAAAAAAAA;
        RHS <= 32'h55555555;
        uop <= 5'b00100;  // XOR operation
        #10;

        // Test 5: CMP (Compare 0x7FFFFFFF and 0xFFFFFFFF)
        LHS <= 32'h7FFFFFFF;
        RHS <= 32'hFFFFFFFF;
        uop <= 5'b00101;  // CMP operation
        #10;

        // Test 6: LSL (0x00000001 << 1)
        LHS <= 32'h00000001;
        RHS <= 32'h00000001;
        uop <= 5'b00110;  // LSL (Logical Shift Left)
        #10;

        // Test 7: LSR (0x80000000 >> 1)
        LHS <= 32'h80000000;
        RHS <= 32'h00000001;
        uop <= 5'b00111;  // LSR (Logical Shift Right)
        #10;

        // Test 8: MOV (Move 0x12345678)
        RHS <= 32'h12345678;
        uop <= 5'b01000;  // MOV operation
        #10;
        
        // End simulation
        $finish;
    end
endmodule
