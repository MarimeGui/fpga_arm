`timescale 1ns/1ns

module Bcc_tb();
    reg clock;
	reg not_enable;
    reg [3:0] flags;// [Z, C, N, V] (Zero, Carry, Negative, Overflow),
    reg [3:0] branch_cond;
    wire out;

    // Instantiate the Bcc module
    Bcc UUT (
        .clk(clock),
		.not_enable(not_enable),
        .flags(flags),
        .branch_cond(branch_cond),
        .Ok(out)
    );

    // Clock generation (50% duty cycle, period = 10ns)
    initial begin
        clock = 1;
        forever #5 clock = ~clock; // Clock toggles every 5ns -> period of 10ns
    end

    // Test sequence
    initial begin
        // Initialize inputs
		not_enable <= 0;
        branch_cond = 4'b1110;// by default condition initialized to always
        flags = 4'b0000;
        #10; // Wait for next clock cycle
        
        // Test BEQ = true
        flags = 4'b1000; // Z =1 , C = 0, N = 0 ,V = 0
        branch_cond = 4'b0000; // BEQ condition (true if Z =1)
        #10;

        // Test BEQ = false
        flags = 4'b0000; // Z =0 , C = 0, N = 0 ,V = 0
        branch_cond = 4'b0000; // BEQ condition (true if Z =1)
        #10;
        
        // Test BCS = false
        flags = 4'b0000; // Z =0 , C = 0, N = 0 ,V = 0
        branch_cond = 4'b0010; // BEQ condition (true if Z =1)
        #10;
        

        
        
        $stop; // End simulation


    end
endmodule
