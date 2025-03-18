`timescale 1ns/1ns

module fetch_icache_tb();
    reg clk;
    reg [31:0] index_in;
    reg [31:0] delta_i;
    wire [15:0] data;
    wire [31:0] index_out;
    
    Fetch UUT_A(
        .clk(clk),
        .delta_i(delta_i),
        .index(index_out)
    );

    ICache UUT_B(
        .clk(clk),
        .write_enable(),
        .write_instruction_index(),
        .write_instruction(),
        .index(index_in),
        .data(data)
    );
    
    always @(*) begin
        index_in <= index_out;
    end
    
    
    // Setup clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        // TODO: Currently does nothing, should add code

        delta_i = 0;
        #10; // index = 10
        #10; // index = 11
        
        delta_i = -2;
        #10; // index = 10 & data = 0x0
        
        delta_i = 0;
        #10; // index = 11
        #10; // index = 12
        
        $stop;
    end

endmodule
