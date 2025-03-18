module Execute_tb(
        input CLK, CLKBTNC,
        input BTNU, BTND, BTNL, BTNR,
        input [15:0] SW,
        output [7:0] In,
        output [3:0] uOP,
        output [3:0] Flag,
        output [31:0] Out
    );
    
    // ===== Variables =====
    parameter [3:0] STR_UOP = 4'b1001;
    parameter [3:0] LDR_UOP = 4'b1010;
    
    // ===== Wires =====
    assign In = (uOP==9 | uOP==10) ? DCache.data_out : ALU.out_alu;
    assign uOP = SW[3:0];
    
    // ===== Modules =====
    dcache #(
        .STR_UOP(STR_UOP), // Adds the parameters to the instantiated module
        .LDR_UOP(LDR_UOP)
    ) DCache (
        .clock(CLKBTNC),
        .addr(Out),
        .data_in(RegFile.p0),
        .uop(uOP),
        .data_out()
    );
    ALU ALU(
        .LHS(RegFile.p0),
        .RHS(SW[7:4]),
        .uop(uOP),
        .out_alu(),
        .flags_out() // [Z, C, N, V] (Zero, Carry, Negative, Overflow)
    );
    regs RegFile(
        .clock(CLKBTNC), // R/W
        .not_enable(BTNR),
        .sel_p0(SW[15:12]),
        .sel_p1(), // Not used
        .sel_in(SW[11:8]),
        .in_reg(ALU.out_alu),
        .p0(),
        .p1(), // Not used
        .in_flags(ALU.flags),
        .out_flags(Flag)
    );
    
endmodule
