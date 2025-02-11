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
        // ----- ADD

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

        // ----- B
        // B -1005
        instruction <= 16'b1110010000010011;
        #10;

        // ----- BXX
        // TODO

        // ----- CMP
        // CMP R3 and 220
        instruction <= 16'b0010101111011100;
        #10;

        // ----- EOR
        // EOR R3 <= R3 XOR R0
        instruction <= 16'b0100000001000011;
        #10;

        // ----- LDR
        // LDR R1 <= [R2] + 4
        instruction <= 16'b0110100100010001;
        #10;

        // ----- LSL
        // LSL R2 <= R3 << 20
        instruction <= 16'b0000010100011010;
        #10;

        // ----- MOV
        // MOV R4 <= 213
        instruction <= 16'b0010010011010101;
        #10;

        // MOV R2 <= R6
        instruction <= 16'b0000000000110010;
        #10;

        // ----- STR
        // STR [R7 + 23] <= R6 
        instruction <= 16'b0110010111111110;
        #10;

        // ----- SUB
        // SUB R5 <= R0 - R1
        instruction <= 16'b0001101001000101;
        #10;

        // SUB R3 <= R2 - 3
        instruction <= 16'b0001111011010011;
        #10;

        // SUB R3 <= R3 - 226
        instruction <= 16'b0011101111100010;
        #10;
    end
endmodule
