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
        $dumpfile("dump.vcd");
        $dumpvars();
        
        clk = 1;
        forever #5 clk = ~clk;
    end
    
    initial begin
        download_program = 1;

        // /!\ These are Little-Endian instructions, in other words, the second byte comes first !

        // MOV 32 => r1 (address of GPIO)
        instruction_index = 10;
        program_in = 16'b0010000000100001;
        #10;

        // MOV 5 => r0 (loop counter)
        instruction_index = 11;
        program_in = 16'b0000010100100000;
        #10;

        // STR [r1 + 0] <= r0 (update GPIO)
        instruction_index = 12;
        program_in = 16'b0000100001100000;
        #10;

        // SUB r0 <= r0 - 1 (subtract 1 from loop counter)
        instruction_index = 13;
        program_in = 16'b0000000100111000;
        #10;

        // CMP r0, 0 (compare loop counter with 0)
        instruction_index = 14;
        program_in = 16'b0000000000101000;
        #10;

        // BNE -5 (If loop is not equal to 0, loop back up to GPIO update)
        instruction_index = 15;
        program_in = 16'b1111101111010001;
        #10;

        // B -2 (end of program, loops back to same instruction)
        instruction_index = 16;
        program_in = 16'b1111111011100111;
        #10;

        // AND r2 <= r2 & r0 (should not be processed)
        instruction_index = 17;
        program_in = 16'b0000001001000000;
        #10;

        // Finish downloading
        download_program = 0;
        #30 // Wait for PC to get to 10

        // Execute instructions
        #500

        $finish;
    end

endmodule
