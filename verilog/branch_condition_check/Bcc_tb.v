`timescale 1ns/1ns

module Bcc_tb();
    reg clock;
    reg [3:0] flags;// [Z, C, N, V] (Zero, Carry, Negative, Overflow),
    reg [3:0] branch_cond;
    wire out;

    // Instantiate the Bcc module
    Bcc UUT (
        .clk(clock),
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
        branch_cond = 4'b1110;// by default condition initialized to always
        flags = 4'b0000;
        #10; // Wait for next clock cycle
        
        // Test BEQ = true

        flags = 4'b1111; // Z =1 , C = 1, N = 1 ,V = 1
        branch_cond = 4'b0000; // BEQ condition (true if Z =1)
        #10;

        // Test BEQ = false
        flags = 4'b0110; // Z =0 , C = 1, N = 1 ,V = 0
        branch_cond = 4'b0000; // BEQ condition (true if Z =1)
        #10;
        
        // Test BNE = true
        flags = 4'b0111; // Z =0 , C = 1, N = 1 ,V = 1
        branch_cond = 4'b0001; // BNE condition (true if Z =0)
        #10;
        
        // Test BCS = false
        flags = 4'b0010; // Z =0 , C = 0, N = 1 ,V = 0
        branch_cond = 4'b0010; // BCS condition (true if C =1)
        #10;
        
        // Test BMI = true
        flags = 4'b0110; // Z =0 , C = 1, N = 1 ,V = 0
        branch_cond = 4'b0100; // BMI condition (true if N =1)
        #10;        
        
        // Test BCC = false
        flags = 4'b1101; // Z =1 , C = 1, N = 0 ,V = 1
        branch_cond = 4'b0011; // BCC condition (true if C =0)
        #10;

        // Test BPL = true
        flags = 4'b0000; // Z =0 , C = 0, N = 0 ,V = 0
        branch_cond = 4'b0101; // BCS condition (true if N =0)
        #10;

        $stop; // End simulation


    end
endmodule
