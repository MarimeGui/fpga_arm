module cpu_tb();

    reg clk;
    reg download_program;
    reg [31:0] instruction_index;
    reg [15:0] program_in;

    CPU CPU(
        .clk(clk),
        .download_program(download_program),
        .instruction_index(instruction_index),
        .program_in(program_in),
        .gpio_state()
    );

    initial begin
        clk = 1;
        forever #5 clk = ~clk;
    end
    
    initial begin
        download_program <= 1;

        // MOV 5 => R0
        instruction_index <= 10;
        program_in <= 16'b0010000000000101;
        #10;

        // SUB r2 <= r0 - 7
        instruction_index <= 11;
        program_in <= 16'b0001111111000010;
        #10;

        // B -2
        instruction_index <= 12;
        program_in <= 16'b1110011111111110;
        #10;

        // Finish downloading
        download_program <= 0;
        #30 // Wait for PC to get to 10

        // Execute instructions
        #40

        $stop;
    end

endmodule
