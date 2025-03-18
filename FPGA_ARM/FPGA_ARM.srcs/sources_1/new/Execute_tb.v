module Execute_tb(
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
    
    // ===== Modules =====
    Execute(
    input clk,

    // From Decode
    input num_to_rhs,
    input [31:0] num,
    input [3:0] sel_p0,
    input [3:0] sel_p1,
    input [3:0] sel_in,
    input [4:0] uop,
    input [3:0] branch_cond,

    output wire global_disable,
    output wire [31:0] delta_instruction,
    output wire [31:0] gpio_state
);
    
endmodule
