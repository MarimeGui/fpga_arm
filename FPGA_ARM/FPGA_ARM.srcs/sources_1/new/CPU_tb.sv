/*
    LED = gpio_state
*/
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
    bit [7:0] instruction_index;
    bit [15:0] program_in;
    
    wire [31:0] gpio;
    wire CLK50MHZ, CLK10MHZ;
    
    assign LED = gpio[15:0];
    
    // ===== Module =====
    FrequencyDivider PLL(
        .CLKin(CLK100MHZ),
        .divider(2),
        .CLKout(CLK50MHZ)
    );
    FrequencyDivider PLL2(
        .CLKin(CLK100MHZ),
        .divider(10),
        .CLKout(CLK10MHZ)
    );
    CPU CPU(
        .clk(CLK50MHZ),
        .write(download_program),
        .write_instruction_index(instruction_index),
        .write_instruction(program_in),
        .gpio_state(gpio)
    );
    
    initial begin
        download_program <= 1'b1; // write the program intructions
        instruction_index <= 8'h0A;
    end
    
    always @(negedge CLK10MHZ) begin
        if (download_program == 1'b1) begin 
            case (instruction_index)
                8'h0A: program_in <= 16'b0010000100000000; // MOV 0 => r0
                8'h0B: program_in <= 16'b0010000100000000; // MOV 0 => r0
                8'h0C: program_in <= 16'b0010000100111101; // MOV 63 => r0
                8'h0D: program_in <= 16'b0010000100100000; // MOV 32 => r1 (address of GPIO)
                8'h0E: program_in <= 16'b0110000000001000; // STR [r1 + 0] <= r0 (update GPIO)
                8'h0F: program_in <= 16'b1111111011100111; // B -2 (end of program, loops back to same instruction) 
                8'h10: program_in <= 16'b0000001001000000; // AND r2 <= r2 & r0 (should not be processed)
                8'h11: program_in <= 16'b0000001001000000; // AND r2 <= r2 & r0 (should not be processed)
                8'h12: download_program <= 1'b0;
            endcase
            instruction_index <= instruction_index + 1;
        end
    end

endmodule