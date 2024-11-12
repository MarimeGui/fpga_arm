`timescale 1ns/1ns

module decode_tb();
    reg [15:0] instruction;
    reg clk;
    wire [4:0] uop;
    wire num_to_rhs;
    wire [31:0] num;
    wire [3:0] sel_p0;
    wire [3:0] sel_p1;
    wire [3:0] sel_in;
    wire explose;

    Decode UUT (
        .instruction(instruction),
        .clk(clk),
        .uop(uop),
        .num_to_rhs(num_to_rhs),
        .num(num),
        .sel_p0(sel_p0),
        .sel_p1(sel_p1),
        .sel_in(sel_in),
        .explose(explose)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        // ADD R6 <= R4 + R5
        instruction <= 16'b0001100100101110;
        #10;

        // ADD R7 <= 4 + R2
        instruction <= 16'b0001110100010111;
        #10;

        // ADD R2 <= R2 + 101
        instruction <= 16'b0011001001100101;
        #10;

        // Does not exist
        instruction <= 16'b1110100000000000;
        #10;
    end
endmodule
