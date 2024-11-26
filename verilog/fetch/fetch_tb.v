`timescale 1ns/1ns

module fetch_tb();
    reg clk;

    wire [31:0] data_from_rom;
    reg [31:0] data_to_rom;
    reg [31:0] address;
    wire [15:0] instruction;

    reg write_enable;

    Fetch UUT(
        .clk(clk),
        .data(data_from_rom),
        .instruction(instruction)
    );

    rom TestRom(
        .clock(clk),
		.write_enable(write_enable),
		.address(address),
		.data_in(data_to_rom),
		.data_out(data_from_rom)
    );

    // Setup clock
    initial begin
        clk = 1;
        forever #5 clk = ~clk;
    end

    initial begin
        // Wait for a full cycle to make display clearer
        #10;

        // Write some data in Rom
        data_to_rom = 32'h67452301; // Data mimicking Little Endian instructions
		write_enable = 1;
		address = 32'h08000010;
		#10;

        // Write some data in Rom again
        data_to_rom = 32'hDDCCBBAA;
		write_enable = 1;
		address = 32'h08000014;
		#10;

        // Set all signals to Hi-Z
        data_to_rom = 32'bZ;
		write_enable = 1'bZ;
		address = 32'bZ;
        write_enable = 0;
        #10;

        // Try to read this data
        address = 32'h08000010;
        #10;
        address <= address + 2;
        #10;
        address <= address + 2;
        #10;
        address <= address + 2;
        #10;
        address <= address + 2;
    end

endmodule
