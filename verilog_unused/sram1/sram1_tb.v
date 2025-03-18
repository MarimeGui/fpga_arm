`timescale 1ns/1ns

module sram1_tb();
	reg clock, read_write;
	reg [31:0] address, data_in;
	wire [31:0] data_out;

    // Instantiate the ALU module
    sram1 UUT(
		.clock(clock),
		.read_write(read_write),
		.address(address),
		.data_in(data_in),
		.data_out(data_out)
	);


    // Clock generation (50% duty cycle, period = 10ns)
	initial begin
        clock = 0;
        forever #5 clock = ~clock; // Clock toggles every 5ns -> period of 10ns
    end

    // Test sequence
    initial begin
        $dumpfile("sram1_tb.vcd");
        $dumpvars(0, sram1_tb);

		// Write 0x01234567 at address 0x20000000
		data_in = 32'h01234567;
		read_write = 1;
		address = 32'h20000000;
		#10
		// Read address 0x20000000
		read_write = 0;
		data_in = 32'h11111111;
		#10
		
		// Try to write 0xFEDCBA90 at address 0x20018000
		address = 32'h20018000;
		read_write = 1;
		data_in = 32'hFEDCBA90;
		#10
		// Try to read address 0x20018000
		read_write = 0;
		#10
		
		// Write 0x89ABCDEF at address 0x20017FFF
		data_in = 32'h89ABCDEF;
		read_write = 1;
		address = 32'h20017FFF;
		#10
		// Read address 0x89ABCDEF
		read_write = 0;
		data_in = 32'h11111111;
		#10
		
		// Try to write 0x55555555 at address 0x1FFFFFFC
		address = 32'h1FFFFFFC;
		read_write = 1;
		data_in = 32'h55555555;
		#10
		// Try to read address 0x1FFFFFFF
		read_write = 0;
		#10
		
        $stop;
	end
endmodule
