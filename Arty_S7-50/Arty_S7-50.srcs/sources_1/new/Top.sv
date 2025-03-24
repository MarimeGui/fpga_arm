/*
    LED = gpio_state
*/
module Top(
    input CLK100MHZ,
    output bit [3:0] led
);

    bit download_program;
    bit [7:0] instruction_index;
    bit [15:0] program_in;
    
    wire [31:0] gpio;
    
    assign led = gpio[3:0];
    
    CPU CPU(
        .clk(CLK100MHZ),
        .write(download_program),
        .write_instruction_index(instruction_index),
        .write_instruction(program_in),
        .gpio_state(gpio)
    );
    
    initial begin
        download_program <= 1'b1; // write the program intructions
        instruction_index <= 10;
    end
    
    always @(posedge CLK100MHZ) begin
        if (download_program == 1'b1) begin 
            case (instruction_index)
                // WARNING bytes must be reversed
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
            instruction_index <= instruction_index + 1;
        end
    end

endmodule