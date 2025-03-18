module DCache_tb(
        input CLK, CLKBTNC,
        input BTNU, BTND, BTNL, BTNR,
        input [15:0] SW,
        output [31:0] In,
        output [4:0] uOP,
        output [3:0] Flag,
        output [31:0] Out
    );
    
    assign Flag = 4'h0;
    
    CTRLuOP(
        .CLK(CLK),
        .BTNU(BTNU), .BTND(BTND),
        .uOP(uOP)
    );
    
    // ===== Module =====
    assign In = 32'h0 | SW[7:0];
    DCache UUT (
        .clock(CLKBTNC),
        .addr(32'h0 | SW[15:8]),
        .data_in(In),
        .uop(uOP),
        .data_out(Out)
    );
endmodule