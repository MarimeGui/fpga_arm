module ArtyRunFixedProgram(
    input sysclk,

    input [3:0] switches,
    input [3:0] buttons,

    output bit [3:0] leds,
    output bit [2:0] rgb_leds [1:0]
);
    bit download_program;
    bit [7:0] instruction_index;
    bit [15:0] program_in;

    wire clk;
    wire [31:0] index;
    wire [27:0] unused;

    // Blue LED turns on when program is downloading
    assign rgb_leds[0][2] = download_program;

    // 20Hz clock divisor
    ClockDivisor #(5000000) i_divisor(
        .clk_in(sysclk),
        .clk_out(clk)
    );

    CPU i_cpu(
        .clk(clk),
        .reset(download_program),
        .write_instruction_index(instruction_index),
        .write_instruction(program_in),
        .gpio_state({unused, leds}),
        .index()
    );

    initial begin
        download_program <= 1; // write the program instructions
        instruction_index <= 10;
    end
    
    always @(posedge clk) begin
        if (download_program == 1) begin
            case (instruction_index)
                10: program_in <= 16'h2021; // movs 
                11: program_in <= 16'h0022; // movs
                12: program_in <= 16'h0023; // movs
                13: program_in <= 16'h082b; // cmp
                14: program_in <= 16'hfad0; // beq.n
                15: program_in <= 16'h5200; // lsls
                16: program_in <= 16'h042b; // cmp
                17: program_in <= 16'h00da; // bge.n
                18: program_in <= 16'h0132; // adds
                19: program_in <= 16'h0133; // adds
                20: program_in <= 16'h0a60; // str
                21: program_in <= 16'hf6e7; // b.n
                22: program_in <= 16'hfee7; // b.n 
                23: download_program <= 1'b0;
            endcase

            instruction_index <= instruction_index + 1;
        end
    end

endmodule
