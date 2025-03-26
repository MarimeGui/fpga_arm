module BasysRunFixedProgram(
    input sysclk,

    input [15:0] switches,
    input button_up, button_down, button_left, button_right, button_center,

    output bit [15:0] leds,

    output [3:0] digit_disable,
    output [7:0] segments
);

    bit download_program;
    bit reset; // Extra reset signal is REQUIRED as always does not want to be actually sequential today :(
    bit [7:0] current_program; // 0 is when execution just began, first program is 1
    wire [7:0] selected_program = switches[7:0] + 1;
    bit [7:0] instruction_index;
    bit [15:0] program_in;

    wire clk;
    wire [31:0] index;
    wire [15:0] unused;

    // 20Hz clock divisor
    ClockDivisor #(5000000) i_divisor(
        .clk_in(sysclk),
        .clk_out(clk)
    );

    CPU i_cpu(
        .clk(clk),
        .reset(reset),
        .write_instruction_index(instruction_index),
        .write_instruction(program_in),
        .gpio_state({unused, leds}),
        .index(index)
    );

    DisplayDecimalValue i_display(
        .sysclk(sysclk),
        .value(index),
        .dot_pattern(reset), // Right-most dot turns on when CPU is in reset
        .segments(segments),
        .digit_disable(digit_disable)
    );

    always @(posedge clk) begin
        if ((current_program != selected_program) & (selected_program <= 3)) begin
            download_program <= 1; // write the program instructions
            instruction_index <= 10;
            current_program <= selected_program;
        end

        if (download_program == 1) begin
            reset <= download_program;
            case (current_program)
                1: begin
                    // Chaser
                    case (instruction_index)
                        10: program_in <= 16'h2021; // movs
                        11: program_in <= 16'h0022; // movs
                        12: program_in <= 16'h0023; // movs
                        13: program_in <= 16'h202b; // cmp
                        14: program_in <= 16'hfad0; // beq.n
                        15: program_in <= 16'h5200; // lsls
                        16: program_in <= 16'h102b; // cmp
                        17: program_in <= 16'h00da; // bge.n
                        18: program_in <= 16'h0132; // adds
                        19: program_in <= 16'h0133; // adds
                        20: program_in <= 16'h0a60; // str
                        21: program_in <= 16'hf6e7; // b.n
                        22: program_in <= 16'hfee7; // b.n
                        23: download_program <= 1'b0;
                    endcase
                end
                2: begin
                    // Count up
                    case (instruction_index)
                        10: program_in <= 16'b0010000000100001; // MOV 32 => r1 (address of GPIO)
                        11: program_in <= 16'b0000000000100000; // MOV 0 => r0 (loop counter)
                        12: program_in <= 16'b0100000000011100; // ADD r0 <= 1 + r0
                        13: program_in <= 16'b0000100001100000; // STR [r1 + 0] <= r0 (update GPIO)
                        14: program_in <= 16'b1111111100101000; // CMP r0, 255
                        15: program_in <= 16'b1111101111010001; // BNE -5 (As long as we're not up to 255, loop back up)
                        16: program_in <= 16'b1111111011100111; // B -2 (end of program, loops back to same instruction)
                        19: download_program <= 1'b0;
                    endcase
                end
                3: begin
                    // Fixed pattern
                    case (instruction_index)
                        10: program_in <= 16'b0000000000100000; // MOV 0 => r0
                        11: program_in <= 16'b0000000000100000; // MOV 0 => r0
                        12: program_in <= 16'b1101100100100000; // MOV 0b11011001 => r0
                        13: program_in <= 16'b0010000000100001; // MOV 32 => r1 (address of GPIO)
                        14: program_in <= 16'b0000100001100000; // STR [r1 + 0] <= r0 (update GPIO)
                        15: program_in <= 16'b1111111011100111; // B -2 (end of program, loops back to same instruction)
                        16: program_in <= 16'b0000001001000000; // AND r2 <= r2 & r0 (should not be processed)
                        17: program_in <= 16'b0000001001000000; // AND r2 <= r2 & r0 (should not be processed)
                        18: download_program <= 1'b0;
                    endcase
                end
            endcase

            instruction_index <= instruction_index + 1;
        end else begin
            reset <= 0;
        end
    end

endmodule
