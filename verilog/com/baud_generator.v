module baud_generator #(
    parameter ClkFrequency = 12000000,  // Standard: 12 MHz, 
    parameter Baud = 115200             
)(
    input clk,           // FPGA main clock
    output reg BaudTick  // Output tick at desired baud rate
);

    // Sets accumulator size according to clock speed
    localparam BaudGeneratorAccWidth = (ClkFrequency > 50000000) ? 20 : 16;

    // Calculates necessary increment to acc to generate BaudTick
    localparam BaudGeneratorInc = ((Baud << (BaudGeneratorAccWidth - 4)) + (ClkFrequency >> 5)) / (ClkFrequency >> 4);

    // Accumulator register
    reg [BaudGeneratorAccWidth:0] BaudGeneratorAcc = 0;

    always @(posedge clk) begin
        BaudGeneratorAcc <= BaudGeneratorAcc[BaudGeneratorAccWidth-1:0] + BaudGeneratorInc;
        BaudTick <= BaudGeneratorAcc[BaudGeneratorAccWidth]; // Overflow bit output
    end

endmodule
