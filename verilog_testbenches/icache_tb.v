`timescale 1ns/1ns

module icache_tb();
    reg clk;
    reg [31:0] index;
    wire [15:0] data;

    ICache UUT(
        .clk(clk),
        .write_enable(),
        .write_instruction_index(),
        .write_instruction(),
        .index(index),
        .data(data)
    );
    
    // Clock generation (50% duty cycle, period = 10ns)
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Clock toggles every 5ns -> period of 10ns
    end
    
    // Test sequence
    initial begin
        // TODO: CUrrently does nothing, should write stuff

        index = 10;
        #10 // Read cell number 10
        
        index = 11;
        #10 // Read cell number 11
        
        index = 12;
        #10 // Read cell number 12
        
        index = 13;
        #10 // do nothing
        
        #10; // Read cell number 14
        
        $stop;
    end
endmodule
