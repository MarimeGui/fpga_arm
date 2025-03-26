// Regroups the Fetch, Decode and Execute modules for execution of a program

module CPU(
    input clk,

    // Disables execution and returns to index 5
    input reset,

    input [7:0] write_instruction_index,
    input [15:0] write_instruction,

    output wire [31:0] gpio_state,
    output wire [31:0] index
);
    // For modules deactivated while held in reset
    wire clk2 = (!reset) & clk;

    // Branch and Fetch related
    wire global_disable;
    wire [31:0] delta_instruction;

    // Instruction passing
    wire [15:0] instruction_from_mem;
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
        .write_enable(reset), // When CPU is held in Reset, program ICache
        .write_instruction_index(write_instruction_index),
        .write_instruction(write_instruction),
        .index(index[7:0]),
        .data(instruction_from_mem)
    );

    LittleEndianInverter i_inverter(
        .from_memory(instruction_from_mem),
        .instruction(instruction)
    );

    Fetch i_fetch(
        .clk(clk),
        .reset(reset),
        .delta_i(delta_instruction),
        .index(index)
    );

    Decode i_decode(
        .clk(clk),
        .instruction(instruction),
        .reset(global_disable | reset),
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
