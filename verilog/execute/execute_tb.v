`timescale 1ns/1ns

module execute_tb();
    reg clk;
	
    reg num_to_rhs;
    reg [31:0] num;
    reg [3:0] sel_p0;
    reg [3:0] sel_p1;
    reg [3:0] sel_in;
    reg [4:0] uop;
    reg [3:0] branch_cond;

    wire global_disable;
    wire [31:0] delta_instruction;

    Execute uut (
        .clk(clk),
        .num_to_rhs(num_to_rhs),
        .num(num),
        .sel_p0(sel_p0),
        .sel_p1(sel_p1),
        .sel_in(sel_in),
        .uop(uop),
        .branch_cond(branch_cond),
        .global_disable(global_disable),
        .delta_instruction(delta_instruction)
    );

    initial begin
        clk = 1;
        forever #5 clk = ~clk; // Clock toggles every 5ns -> period of 10ns
    end

    initial begin
        // Init inputs
        num_to_rhs <= 0;
        num <= 0;
        sel_p0 <= 0;
        sel_p1 <= 0;
        sel_in <= 0;
        uop <= 0;
        branch_cond <= 0;
        #10;

        // Try a MOV to load some data in r1
        num_to_rhs <= 1;
        num <= 32'hCAFE;
        sel_p0 <= 0; // Not used
        sel_p1 <= 0; // Not used
        sel_in <= 1; // Choose r1
        uop <= 8;
        branch_cond <= 0; // Not used
        #10;

        // MOV r1 to r2
        num_to_rhs <= 0; // Not used
        num <= 0; // Not used
        sel_p0 <= 1; // From r1
        sel_p1 <= 0; // Not used
        sel_in <= 2; // To r2
        uop <= 8;
        branch_cond <= 0; // Not used
        #10;

        // ADD r1+r2 to r3
        num_to_rhs <= 0; // Unused
        num <= 0; // Unused
        sel_p0 <= 1; // r1
        sel_p1 <= 2; // r2
        sel_in <= 3; // r3
        uop <= 1;
        branch_cond <= 0; // Unused
        #10;

        // AND r2 & r3 to r2
        num_to_rhs <= 0; // Unused
        num <= 0; // Unused
        sel_p0 <= 2; // r1
        sel_p1 <= 3; // r2
        sel_in <= 2; // r3
        uop <= 3;
        branch_cond <= 0; // Unused
        #10;

        // CMP r2 and r3
        num_to_rhs <= 0; // Unused
        num <= 0; // Unused
        sel_p0 <= 2; // r1
        sel_p1 <= 3; // r2
        sel_in <= 0; // Unused
        uop <= 5;
        branch_cond <= 0; // Unused
        #10;

        // NOP
        num_to_rhs <= 0; // Unused
        num <= 0; // Unused
        sel_p0 <= 2; // Unused
        sel_p1 <= 3; // Unused
        sel_in <= 0; // Unused
        uop <= 0;
        branch_cond <= 0; // Unused
        #10;

        // NOP
        num_to_rhs <= 0; // Unused
        num <= 0; // Unused
        sel_p0 <= 2; // Unused
        sel_p1 <= 3; // Unused
        sel_in <= 0; // Unused
        uop <= 0;
        branch_cond <= 0; // Unused
        #10;

        

        #10;
        $stop; // End simulation
    end


endmodule
