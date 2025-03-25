/*
    LED = gpio_state
*/
module CPU_tb(
    input CLK100MHZ,
    input [15:0] SW,
    input BTNC, BTNU, BTND, BTNL, BTNR,
    output bit [15:0] LED,
    output [3:0] Disable7Seg,
    output [6:0] Seg,
    output DP
);

    assign DP = 1'b1;
    assign Seg = 7'hFF;
    assign Disable7Seg = 4'hF;
    
    bit download_program;
    bit [7:0] instruction_index;
    bit [15:0] program_in;
    
    wire CLK_CPU;
    wire [31:0] gpio;
    
    assign LED = gpio[15:0];
    
    PLL PLL(
        .CLKin(CLK100MHZ),
        .divider(5000000),
        .CLKout(CLK_CPU) // 20 Hz
    );
    
    CPU CPU(
        .clk(CLK_CPU),
        .write(download_program),
        .write_instruction_index(instruction_index),
        .write_instruction(program_in),
        .gpio_state(gpio)
    );
    
    initial begin
        download_program <= 1'b1; // write the program intructions
        instruction_index <= 10;
    end
    
    always @(posedge CLK_CPU) begin
        if (download_program == 1'b1) begin
            case (instruction_index)
                // WARNING bytes must be reversed
                /*
                10: program_in <= 16'b0000000000100000; // MOV 0 => r0
                11: program_in <= 16'b0000000000100000; // MOV 0 => r0
                12: program_in <= 16'b1101100100100000; // MOV 0b11011001 => r0
                13: program_in <= 16'b0010000000100001; // MOV 32 => r1 (address of GPIO)
                14: program_in <= 16'b0000100001100000; // STR [r1 + 0] <= r0 (update GPIO)
                15: program_in <= 16'b1111111011100111; // B -2 (end of program, loops back to same instruction) 
                16: program_in <= 16'b0000001001000000; // AND r2 <= r2 & r0 (should not be processed)
                17: program_in <= 16'b0000001001000000; // AND r2 <= r2 & r0 (should not be processed)
                20: download_program <= 1'b0;*/
                /*
                10: program_in <= 16'b0010000000100001; // MOV 32 => r1 (address of GPIO)
                11: program_in <= 16'b0000010100100000; // MOV 5 => r0 (loop counter)
                12: program_in <= 16'b0000100001100000; // STR [r1 + 0] <= r0 (update GPIO)
                13: program_in <= 16'b0000000100111000; // SUB r0 <= r0 - 1 (subtract 1 from loop counter)
                14: program_in <= 16'b0000000000101000; // CMP r0, 0 (compare loop counter with 0)
                15: program_in <= 16'b1111101111010001; // BNE -5 (If loop is not equal to 0, loop back up to GPIO update)
                16: program_in <= 16'b1111111011100111; // B -2 (end of program, loops back to same instruction)
                17: program_in <= 16'b0000001001000000; // AND r2 <= r2 & r0 (should not be processed)
                18: program_in <= 16'b0000001001000000; // AND r2 <= r2 & r0 (should not be processed)
                19: download_program <= 1'b0;*/
                
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
            instruction_index <= instruction_index + 1;
        end
    end

endmodule