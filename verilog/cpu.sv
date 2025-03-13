module CPU(
    input clk,
    input download_program,
    input [31:0] instruction_index,
    input [15:0] program_in,
    output wire [31:0] gpio_state
);
    //Download data to i_cache
    wire clk2 = (! download_program) & clk;

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

    ICache i_icache(
        .clk(clk),
        .not_enable(global_disable),
        .index(index),
        .data(instruction),
        .write(download_program),
        .instruction_index(instruction_index),
        .instruction(program_in)
    );

    Fetch i_fetch(
        .clk(clk2),
        .delta_i(delta_instruction),
        .index(index)
    );

    Decode i_decode(
        .clk(clk2),
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
        .clk(clk2),
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

endmodule
