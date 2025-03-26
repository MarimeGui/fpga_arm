module cpu_tb();

    reg clk;
    reg reset;
    reg [7:0] write_instruction_index;
    reg [15:0] write_instruction;

    CPU CPU(
        .clk(clk),
        .reset(reset),
        .write_instruction_index(write_instruction_index),
        .write_instruction(write_instruction),
        /* verilator lint_off PINCONNECTEMPTY */
        .gpio_state(),
        /* verilator lint_off PINCONNECTEMPTY */
        .index()
    );

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars();
        
        clk = 1;
        forever #5 clk = ~clk;
    end
    
    initial begin
        reset = 1;

        // /!\ These are Little-Endian instructions, in other words, the second byte comes first !

        // MOV 32 => r1 (address of GPIO)
        write_instruction_index = 10;
        write_instruction = 16'b0010000000100001;
        #10;

        // MOV 5 => r0 (loop counter)
        write_instruction_index = 11;
        write_instruction = 16'b0000010100100000;
        #10;

        // STR [r1 + 0] <= r0 (update GPIO)
        write_instruction_index = 12;
        write_instruction = 16'b0000100001100000;
        #10;

        // SUB r0 <= r0 - 1 (subtract 1 from loop counter)
        write_instruction_index = 13;
        write_instruction = 16'b0000000100111000;
        #10;

        // CMP r0, 0 (compare loop counter with 0)
        write_instruction_index = 14;
        write_instruction = 16'b0000000000101000;
        #10;

        // BNE -5 (If loop is not equal to 0, loop back up to GPIO update)
        write_instruction_index = 15;
        write_instruction = 16'b1111101111010001;
        #10;

        // B -2 (end of program, loops back to same instruction)
        write_instruction_index = 16;
        write_instruction = 16'b1111111011100111;
        #10;

        // AND r2 <= r2 & r0 (should not be processed)
        write_instruction_index = 17;
        write_instruction = 16'b0000001001000000;
        #10;

        // Finish downloading
        reset = 0;

        // Execute instructions
        #500;

        // Partially change program
        reset = 1;

        // MOV 20 => r0 (loop counter)
        write_instruction_index = 11;
        write_instruction = 16'b0001010000100000;
        #10;

        // Finish downloading
        reset = 0;

        // Execute new instructions
        #500;

        $finish;
    end

endmodule
