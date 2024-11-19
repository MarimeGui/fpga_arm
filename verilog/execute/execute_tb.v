`timescale 1ns/1ns

module execute_tb();
    reg clock;
    reg [31:0] in_reg, pc_in;
    reg [3:0] sel_in, sel_p0, sel_p1;
    reg [3:0] flags_in;
    wire [31:0] p0, p1, pc_out;
    wire [3:0] flags_out;
    reg [31:0] LHS, RHS;
    reg [4:0] uop;
    wire [31:0] out_alu;
    wire [3:0] flags; // [Z, C, N, V]

    regs UUT_A (
        .clock(clock),
        .in_reg(in_reg),
        .pc_in(pc_in),
        .sel_in(sel_in),
        .sel_p0(sel_p0),
        .sel_p1(sel_p1),
        .flags_in(flags_in),
        .p0(p0),
        .p1(p1),
        .pc_out(pc_out),
        .flags_out(flags_out)
    );

    ALU UUT_B (
        .LHS(LHS),
        .RHS(RHS),
        .uop(uop),
        .out_alu(out_alu),
        .flags(flags)
    );

    initial begin
        clock = 1;
        forever #5 clock = ~clock; // Clock toggles every 5ns -> period of 10ns
    end
    
	always @(*) begin
		LHS <= p0;
		RHS <= p1;
		in_reg <= out_alu;
		flags_in <= flags;
	end

    initial begin
        $dumpfile("execute_tb.vcd"); 
        $dumpvars(0, execute_tb);
        #10;

        in_reg = 32'h2; // Data in r0
        sel_in = 4'b0000;
        #10;

        in_reg = 32'h1; // Data in r1
        sel_in = 4'b0001;
        #10;

        sel_p0 = 4'b0001; // Operation: r1 - r0 stored in r2
        sel_p1 = 4'b0000;
        sel_in = 4'b0010;
        uop <= 5'b00010;  // SUB operation
        #10;
		
        sel_in = 4'b0011;
        sel_p0 = 4'b0010; // Change p0 to r2 to view operation result
        #10;

        $display("P0 value (R2): %h", in_reg);
        $display("Flags: %b", flags_in);
		
        $stop; // End simulation
    end


endmodule