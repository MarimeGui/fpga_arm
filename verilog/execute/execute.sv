// TODO: Make sure all synchronous modules have coherent posedge negedge

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
    output wire [31:0] delta_instruction
);

    wire [31:0] reg_p0;
    wire [31:0] num_mux_to_rhs_alu;
    wire [31:0] p1_reg_to_lhs_alu;
    wire [31:0] alu_out;
    wire [3:0] reg_flg_to_bcc;
    wire [31:0] mux_to_reg_in_reg;
    wire [3:0] alu_flags_to_reg_flags;
    wire [31:0] dcache_out;
    wire [31:0] delayed_num;
    wire delayed_num_to_rhs;

    regs i_regs(
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

    Mux32 i_in_reg_mux(
        .a(alu_out),
        .b(dcache_out),
        .sel(uop == 4'd10), // Generally route ALU output into register input, unless instruction is a store
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

    // Delay1 i_num_signal_delay(
    //     .clk(clk),
    //     .in(num_to_rhs),
    //     .out(delayed_num_to_rhs)
    // );

    // Delay32 i_delay(
    //     .clk(clk),
    //     .in(num),
    //     .out(delayed_num)
    // );

    ALU i_alu(
        .LHS(p1_reg_to_lhs_alu),
        .RHS(num_mux_to_rhs_alu),
        .uop(uop),
        .out_alu(alu_out),
        .flags(alu_flags_to_reg_flags)
    );

    // TODO: Shouldn't the link between not_enable and Ok be internal ?
    Bcc i_bcc(
        .clk(clk),
        .branch_cond(branch_cond),
        .flags(reg_flg_to_bcc),
        .Ok(global_disable)
    );

    dcache i_dcache(
        .clock(clk),
        .addr(alu_out),
        .uop(uop),
        .data_in(reg_p0),
        .data_out(dcache_out)
    );

endmodule
