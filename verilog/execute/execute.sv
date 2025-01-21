// TODO: Need to know from decode if instruction carried a num or not
// TODO: Make sure all synchronous modules have coherent posedge negedge

module Execute(
    input clk,

    // From Decode
    input num_to_rhs,
    input num,
    input sel_p0,
    input sel_p1,
    input sel_in,
    input uop,
    input branch_cond,

    output reg global_disable,
    output reg delta_instruction,
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

    regs i_regs(
        .p0(reg_p0)
        .in_reg(mux_to_reg_in_reg)
        .in_flags(alu_flags_to_reg_flags)
        .out_flags(reg_flg_to_bcc)
    );

    Mux32 i_in_reg_mux(
        .a(alu_out)
        .b(dcache_out)
        .sel() // TODO: Flow data into reg either from Data Cache or ALU depending on uOp
        .out(mux_to_reg_in_reg)
    );

    Mux32 i_rhs_mux(
        .a(reg_p0)
        .b(delayed_num)
        .sel() // TODO: Should uOp control the RHS ?
        .out(num_mux_to_rhs_alu)
    );

    Mux32 i_delta_i(
        .a(0)
        .b(delayed_num)
        .sel(global_disable)
        .out(delta_instruction)
    );

    // TODO: Might require an enable and/or reset for branches
    Delay32 i_delay(
        .clk(clk)
        .in(num)
        .out(delayed_num)
    );

    alu i_alu(
        .LHS(p1_reg_to_lhs_alu)
        .RHS(num_mux_to_rhs_alu)
        .uop(uop)
        .out_alu(alu_out)
        .flags(alu_flags_to_reg_flags)
    );

    // TODO: Shouldn't the link between not_enable and Ok be internal ?
    Bcc i_bcc(
        .clk(clk)
        .branch_cond(branch_cond)
        .flags(reg_flg_to_bcc)
        .not_enable(global_disable)
        .Ok(global_disable)
    );

    dcache i_dcache(
        .clock(clk)
        .addr(alu_out)
        .uop(uop)
        .data_in(reg_p0)
        .data_out(dcache_out)
    );

endmodule
