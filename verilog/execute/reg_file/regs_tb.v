`timescale 1ns/1ns

module regs_tb();
    reg clock;
	reg not_enable;
    reg [31:0] in_reg;
    reg [3:0] sel_in, sel_p0, sel_p1;
    reg [3:0] in_flags;
    wire [31:0] p0, p1;
    wire [3:0] out_flags;

    // Instantiate the regs module
    regs UUT (
        .clock(clock),
		.not_enable(not_enable),
        .in_reg(in_reg),
        .sel_in(sel_in),
        .sel_p0(sel_p0),
        .sel_p1(sel_p1),
        .in_flags(in_flags),
        .p0(p0),
        .p1(p1),
        .out_flags(out_flags)
    );

    // Clock generation (50% duty cycle, period = 10ns)
    initial begin
        clock = 0;
        forever #5 clock = ~clock; // Clock toggles every 5ns -> period of 10ns
    end

    // Test sequence
    initial begin
        // Initialize inputs
		not_enable <= 0;
        in_reg = 32'h00000000;
        sel_in = 4'b1111; // Should prevent writing to any registers
        sel_p0 = 4'b0000;
        sel_p1 = 4'b0000;
        in_flags = 4'b0000;
        #10; // Wait for next clock cycle
        
        // Write to r5
        in_reg = 32'h12345678; // Data to write
        sel_in = 4'b0101; // Write to r5
        #10;

        // Write to r6
        in_reg = 32'h87654321; // Data to write
        sel_in = 4'b0110; // Write to r6
        #10;

        // Set flags
        sel_in = 4'b1111; // Should prevent writing to anymore registers
        in_flags = 4'b1100; // Set flags to 1100 (arbitrary)
        #10;

        // Read from r5 and r6 (via sel_p0 and sel_p1)
        sel_p0 = 4'b0101; // Select r5
        sel_p1 = 4'b0110; // Select r6
        #10;
		
		// Disable reg & Write to r5
		not_enable <= 1; // Disable write
        sel_p0 = 4'b0101;
        sel_in = 4'b0101; // Select r5
		in_reg = 32'hDEAD;
        #10;

        // Release not_enable, r5 should change
        not_enable <= 0;
        #20;

        // Add more test cases as needed, such as writing to r2-r12, and testing the stack pointer (r13) and link register (r14).
        
        $stop; // End simulation
    end
endmodule
