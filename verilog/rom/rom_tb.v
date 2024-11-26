`timescale 1ns/1ns

module rom_tb();
	reg clock, write_enable;
	reg [31:0] address, data_in;
	wire [31:0] data_out;

    // Instantiate the ALU module
    rom UUT(
		.clock(clock),
		.write_enable(write_enable),
		.address(address),
		.data_in(data_in),
		.data_out(data_out)
	);


    // Clock generation (50% duty cycle, period = 10ns)
	initial begin
        clock = 1;
        forever #5 clock = ~clock; // Clock toggles every 5ns -> period of 10ns
    end

    // Test sequence
    initial begin
        $dumpfile("rom_tb.vcd");
        $dumpvars(0, rom_tb);

		// Write 0x01234567 at address 0x08000000
		data_in = 32'h01234567;
		write_enable = 1;
		address = 32'h08000000;
		#10
		// Read address 0x08000000
		write_enable = 0;
		data_in = 32'h11111111;
		#10
		
		// Try to write 0xFEDCBA90 at address 0x08100000
		address = 32'h08100000;
		write_enable = 1;
		data_in = 32'hFEDCBA90;
		#10
		// Try to read address 0x08100000
		write_enable = 0;
		#10
		
		// Write 0x89ABCDEF at address 0x080FFFFC
		data_in = 32'h89ABCDEF;
		write_enable = 1;
		address = 32'h080FFFFC;
		#10
		// Read address 0x89ABCDEF
		write_enable = 0;
		data_in = 32'h11111111;
		#10
		
        $stop;

	end

endmodule