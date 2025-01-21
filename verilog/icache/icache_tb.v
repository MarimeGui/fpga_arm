`timescale 1ns/1ns

module icache_tb();
	reg clk;
	reg not_enable;
	reg [31:0] index;
	wire [15:0] data;

	icache UUT(
		.clk(clk),
		.not_enable(not_enable),
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
        $dumpfile("icache_tb.vcd");
        $dumpvars(0, icache_tb);

		not_enable = 0; // Enable

		index = 0;
		#10 // Read 1st cell
		
		index = 1;
		#10 // Read 2nd cell
		
		index = 2;
		#10 // Read 3rd cell
		
		not_enable = 1; // Disable
		#10 // out must be at 0x0
		
		index = 3;
		#10 // do nothing
		
		not_enable = 0;
		#10; // Read the 4 cell
		
        $stop;
	end
endmodule