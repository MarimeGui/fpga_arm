// Actually executes the instruction, holds memory. Mainly regroups all sub=modules

module Execute(
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
    
    //output wire [31:0] alu_out // only for test bench
);

    wire [31:0] reg_p0;
    wire [31:0] num_mux_to_rhs_alu;
    wire [31:0] p1_reg_to_lhs_alu;
    wire [31:0] alu_out;
    wire [3:0] reg_flg_to_bcc;
    wire [31:0] mux_to_reg_in_reg;
    wire [3:0] alu_flags_to_reg_flags;
    wire [31:0] dcache_out;

    RegisterFile i_regs(
        .clock(clk),
        .not_enable(global_disable),
        .uop(uop),
        .sel_in(sel_in),
        .sel_p0(sel_p0),
        .sel_p1(sel_p1),
        .in_reg(mux_to_reg_in_reg),
        .p0(reg_p0),
        .p1(p1_reg_to_lhs_alu),
        .in_flags(alu_flags_to_reg_flags),
        .out_flags(reg_flg_to_bcc)
    );

    RegReturnMux i_return_mux(
        .uop(uop),
        .addr(alu_out),
        .alu(alu_out),
        .d_cache(dcache_out),
        .gpio_state(gpio_state),
        .out(mux_to_reg_in_reg)
    );

    Mux32 i_rhs_mux(
        .a(reg_p0),
        .b(num),
        .sel(num_to_rhs),
        .out(num_mux_to_rhs_alu)
    );

    Mux32 i_delta_i(
        .a(0),
        .b(num),
        .sel(global_disable),
        .out(delta_instruction)
    );

    ALU i_alu(
        .lhs(p1_reg_to_lhs_alu),
        .rhs(num_mux_to_rhs_alu),
        .uop(uop),
        .out_alu(alu_out),
        .flags_out(alu_flags_to_reg_flags)
    );

    BCC i_bcc(
        .clk(clk),
        .branch_cond(branch_cond),
        .flags(reg_flg_to_bcc),
        .do_branch(global_disable)
    );

    DCache i_dcache(
        .clock(clk),
        .addr(alu_out[4:0]),
        .uop(uop),
        .data_in(reg_p0),
        .data_out(dcache_out)
    );

    GPIO i_gpio(
        .clk(clk),
        .uop(uop),
        .addr(alu_out),
        .state_in(reg_p0),
        .state(gpio_state)
    );

endmodule
