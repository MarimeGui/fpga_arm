module CPU(
    input clk,
    input download_program,
    input instruction_index,
    input instruction
);

    // Branch and Fetch related
    wire global_disable;
    wire [31:0] delta_instruction;
    wire [31:0] index;
    wire [15:0] instruction;

    // Decode and Execute related
    wire num_to_rhs;
    wire [31:0] num;
    wire [3:0] sel_p0;
    wire [3:0] sel_p1;
    wire [3:0] sel_in;
    wire [4:0] uop;
    wire [3:0] branch_cond;

    icache i_icache(
        .clk(clk),
        .not_enable(global_disable),
        .index(index),
        .data(instruction)
    );

    Fetch i_fetch(
        .clk(clk),
        .delta_i(delta_instruction),
        .index(index)
    );

    Decode i_decode(
        .clk(clk),
        .instruction(instruction),
        .reset(global_disable),
        .uop(uop),
        .num_to_rhs(num_to_rhs),
        .num(num),
        .sel_p0(sel_p0),
        .sel_p1(sel_p1),
        .sel_in(sel_in),
        .branch_cond(branch_cond)
    );

    Execute i_execute(
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

endmodule
