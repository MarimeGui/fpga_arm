
module decode_exec_tb();
    reg clk;
	
    reg[15:0] instruction;

    wire num_to_rhs;
    wire [31:0] num;
    wire [3:0] sel_p0;
    wire [3:0] sel_p1;
    wire [3:0] sel_in;
    wire [4:0] uop;
    wire [3:0] branch_cond;
    wire explose;
    wire global_disable;
    wire [31:0] delta_instruction;

    Execute UUT (
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

    Decode uut (
        .clk(clk),
        .instruction(instruction),
        .uop(uop),
        .num_to_rhs(num_to_rhs),
        .num(num),
        .sel_p0(sel_p0),
        .sel_p1(sel_p1),
        .sel_in(sel_in),
        .explose(explose),
        .branch_cond(branch_cond)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Clock toggles every 5ns -> period of 10ns
    end

     initial begin
        // Init inputs
        instruction <= 0;
        #10;
        // mov R0 5
        instruction <=16'b0010000000000101;

        #10;
        // R2 = Rb0 - 7 
        instruction <= 16'b0001111111000010;
        #10;
        // str [Rb1+a] <= Rc2
        instruction <= 16'b0110001010001010;
        #10;
        instruction <= 0;
        #10;
        #10;
        $stop;
     end

endmodule