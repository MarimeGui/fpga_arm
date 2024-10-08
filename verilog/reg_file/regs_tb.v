`timescale 1ns/1ns

module regs_tb();
    reg clock;
    reg [31:0] in;
    reg [3:0] sel_in, sel_p0, sel_p1;
    reg [3:0] flags_in;
    wire [31:0] p0, p1, pc_out;
    wire [3:0] flags_out;
    wire [31:0] regs[15:0]; // Register file output for inspection

    // Instantiate the regs module
    regs UUT (
        .clock(clock),
        .in(in),
        .sel_in(sel_in),
        .sel_p0(sel_p0),
        .sel_p1(sel_p1),
        .flags_in(flags_in),
        .p0(p0),
        .p1(p1),
        .pc_out(pc_out),
        .flags_out(flags_out),
        .regs(regs) // Expose regs for testing purposes
    );

    // Clock generation (50% duty cycle, period = 10ns)
    initial begin
        clock = 0;
        forever #5 clock = ~clock; // Clock toggles every 5ns -> period of 10ns
    end

    // Test sequence
    initial begin
        $dumpfile("regs_tb.vcd");
        $dumpvars(0, regs_tb);

        // Initialize inputs
        in = 32'h00000000;
        sel_in = 4'b0000; 
        sel_p0 = 4'b0000;
        sel_p1 = 4'b0001;
        flags_in = 4'b0000;
        
        // Step 1: Write to r0 and r1
        #10; // Wait for clock to stabilize
        in = 32'h12345678; // Data to write
        sel_in = 4'b0000; // Write to r0
        #10; // Wait for positive edge of clock

        in = 32'h87654321; // Data to write
        sel_in = 4'b0001; // Write to r1
        #10;

        // Step 2: Write to PC (r15)
        in = 32'hABCD1234; // Write to r15 (PC)
        sel_in = 4'b1111; // Select PC (r15)
        #10;

        // Step 3: Set flags
        flags_in = 4'b1100; // Set flags to 1100 (arbitrary)
        #10;

        // Step 4: Read from r0 and r1 (via sel_p0 and sel_p1)
        sel_p0 = 4'b0000; // Select r0
        sel_p1 = 4'b0001; // Select r1
        #10;

        // Step 5: Read from PC (via pc_out)
        #10; // PC is automatically updated in pc_out
        
        // Step 6: Read flags (via flags_out)
        #10; 

        // Add more test cases as needed, such as writing to r2-r12, and testing the stack pointer (r13) and link register (r14).
        
        $stop;
    end
endmodule
