module CPU_tb(
    input CLK100MHZ,
    input [15:0] SW,
    input BTNC, BTNU, BTND, BTNL, BTNR,
    output [15:0] LED,
    output [3:0] Disable7Seg,
    output [6:0] Seg,
    output DP
);

assign DP = 1'b1;
assign Seg = 7'hFF;
assign Disable7Seg = 4'hF;

bit download_program;
bit [31:0] instruction_index;
bit [15:0] program_in;

assign LED = CPU.gpio_state[15:0];

// ===== Module =====
CPU CPU(
    .clk(CLK100MHZ),
    .write(download_program),
    .write_instruction_index(instruction_index),
    .write_instruction(program_in),
    .gpio_state()
);

initial begin
    download_program = 1'b1; // write the program intructions
    instruction_index = 32'h9;
    program_in = 16'b0010000100000000; // MOV 0 => r0
end

always @(posedge CLK100MHZ) begin
    if (download_program == 1'b1) begin
        instruction_index += 1;
        case (instruction_index)
            10: program_in = 16'b0010000100111111; // MOV 63 => r0
            11: program_in = 16'b0010000100100000; // MOV 32 => r1 (address of GPIO)
            12: program_in = 16'b0110000000001000; // STR [r1 + 0] <= r0 (update GPIO)
            13: download_program = 1'b0;
        endcase
    end
end

endmodule