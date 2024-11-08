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
        clock = 0;
        forever #5 clock = ~clock; // Clock toggles every 5ns -> period of 10ns
    end

    // Test sequence
    initial begin
        $dumpfile("rom_tb.vcd");
        $dumpvars(0, rom_tb);

		// Read address 32'h08000054
		write_enable = 0;
		data_in = 32'h11111111;
		address = 8'h54;
		#10
		
		// Write 0x12345678 at address 0x08000054
		data_in = 32'h12345678;
		write_enable = 1;
		#10
/*		
		// Try to read address 32'h08100060
		write_enable = 0;
		address = 8'h60;
		data_in = //32'hFEDCBA90;
		#10
		
		// Try to write 0xFEDCBA90 at address 32'h08100060
		write_enable = 1;
		#10
*/		
		// Read address 32'h08000054
		write_enable = 0;
		//address = 32'h08000054;
		#10
		
        $stop;

	end

endmodule