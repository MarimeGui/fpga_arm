module ALU_tb(
        input CLK, CLKBTNC,
        input BTNU, BTND, BTNL, BTNR,
        input [15:0] SW,
        output [31:0] In,
        output [4:0] uOP,
        output [3:0] Flag,
        output [31:0] Out
    );
    
    // ===== uOP =====
    CTRLuOP CTRLuOP(
        .CLK(CLK),
        .BTNU(BTNU), .BTND(BTND), .BTNR(BTNR),
        .uOP(uOP)
    );
    
    // ===== Module =====
    assign In = 32'b0 | SW[7:0];
    ALU ALU(
        .lhs(32'b0 | SW[15:8]),
        .rhs(In),
        .uop(uOP),
        .out_alu(Out),
        .flags_out(Flag) // [Z, C, N, V] (Zero, Carry, Negative, Overflow)
    );
endmodule
