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
    wire [31:0] gpio_state;

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
        .delta_instruction(delta_instruction),
        .gpio_state(gpio_state)
    );

    initial begin
        clk = 0;
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
        branch_cond <= 4'b1111;
        #10;

        // Try a MOV to load some data in r1
        num_to_rhs <= 1;
        num <= 32'hCAFE;
        sel_p0 <= 0; // Not used
        sel_p1 <= 0; // Not used
        sel_in <= 1; // Choose r1
        uop <= 8;
        branch_cond <= 4'b1111; // Not used
        #10;

        // MOV data into r2
        num_to_rhs <= 1;
        num <= 32'hDEAD;
        sel_p0 <= 0; // Not used
        sel_p1 <= 0; // Not used
        sel_in <= 2; // Choose r2
        uop <= 8;
        branch_cond <= 4'b1111; // Not used
        #10;

        // MOV r2 to r3
        num_to_rhs <= 0; // Not used
        num <= 0; // Not used
        sel_p0 <= 2; // From r2
        sel_p1 <= 0; // Not used
        sel_in <= 3; // To r3
        uop <= 8;
        branch_cond <= 4'b1111; // Not used
        #10;

        // ADD r1+r2 to r4
        num_to_rhs <= 0; // Unused
        num <= 0; // Unused
        sel_p0 <= 1; // r1
        sel_p1 <= 2; // r2
        sel_in <= 4; // r4
        uop <= 1;
        branch_cond <= 4'b1111; // Unused
        #10;

        // NOP
        num_to_rhs <= 0; // Unused
        num <= 0; // Unused
        sel_p0 <= 2; // Unused
        sel_p1 <= 3; // Unused
        sel_in <= 0; // Unused
        uop <= 0;
        branch_cond <= 4'b1111; // Unused
        #10;

        // 2nd NOP to test stability
        num_to_rhs <= 0; // Unused
        num <= 0; // Unused
        sel_p0 <= 2; // Unused
        sel_p1 <= 3; // Unused
        sel_in <= 0; // Unused
        uop <= 0;
        branch_cond <= 4'b1111; // Unused
        #10;

        // AND r2 & r4 to r5
        num_to_rhs <= 0; // Unused
        num <= 0; // Unused
        sel_p0 <= 2; // r1
        sel_p1 <= 4; // r2
        sel_in <= 2; // r5
        uop <= 3;
        branch_cond <= 4'b1111; // Unused
        #10;

        // MOV 1 into r6
        num_to_rhs <= 1;
        num <= 32'h1;
        sel_p0 <= 0; // Not used
        sel_p1 <= 0; // Not used
        sel_in <= 6; // Choose r6
        uop <= 8;
        branch_cond <= 4'b1111; // Not used
        #10;

        // MOV 1 into r7
        num_to_rhs <= 1;
        num <= 32'h1;
        sel_p0 <= 0; // Not used
        sel_p1 <= 0; // Not used
        sel_in <= 7; // Choose r7
        uop <= 8;
        branch_cond <= 4'b1111; // Not used
        #10;

        // CMP r6 and r7
        num_to_rhs <= 0; // Unused
        num <= 0; // Unused
        sel_p0 <= 6; // r6
        sel_p1 <= 7; // r7
        sel_in <= 0; // Unused
        uop <= 5;
        branch_cond <= 4'b1111; // Unused
        #10;

        // ADD r1+r7 to r14
        num_to_rhs <= 0; // Unused
        num <= 0; // Unused
        sel_p0 <= 1; // r1
        sel_p1 <= 7; // r7
        sel_in <= 14; // r14
        uop <= 1;
        branch_cond <= 4'b1111; // Unused
        #10;

        // STR r14 to special address for GPIO (31+1)=32
        num_to_rhs <= 1; // RHS contains part of the address
        num <= 32'd31; // RHS of the address to use
        sel_p0 <= 14; // r14, value to write, will be the result of previous add
        sel_p1 <= 6; // r6, LHS of address
        sel_in <= 0; // Unused
        uop <= 9; // STR
        branch_cond <= 4'b1111; // Unused
        #10;

        // LDR from same special address into r8
        num_to_rhs <= 1; // RHS contains part of the address
        num <= 32'd31; // RHS of the address to use
        sel_p0 <= 0; // Unused
        sel_p1 <= 6; // r6, LHS of address
        sel_in <= 8; // r8, register that will receive the value frm memory
        uop <= 10; // LDR
        branch_cond <= 4'b1111; // Unused
        #10;

        // Branch
        num_to_rhs <= 1;
        num <= 10; // Go forward a few instructions
        sel_p0 <= 0; // Unused
        sel_p1 <= 0; // Unused
        sel_in <= 0; // Unused
        uop <= 0; // Set to NOP to prevent undesired behavior
        branch_cond <= 4'b1110; // Unconditional
        #10;

        // Here, we put instructions that would dbe streamed from decode
        
        // EOR r1 <= r1 EOR r3
        num_to_rhs <= 0; // Unused
        num <= 0; // Unused
        sel_p0 <= 1; // r1
        sel_p1 <= 3; // r2
        sel_in <= 1; // r1, also return
        uop <= 4;
        branch_cond <= 4'b1111; // Unused
        #10;

        // LSL r9 <= r8 << 8
        num_to_rhs <= 1;
        num <= 8; // Shift by 8
        sel_p0 <= 0; // Unused
        sel_p1 <= 8; // r8
        sel_in <= 9; // r9
        uop <= 6;
        branch_cond <= 4'b1111; // Unused
        #10;

        #10;
        $stop; // End simulation
    end


endmodule
