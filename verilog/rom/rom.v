
// Memory's name: ROM-Flash
// Size: 1 MBytes = 1 048 576 Bytes
// Start address: 0x0800 0000
// End address: 0x080F FFFF

module rom(
	input clock, write_enable,
	input [31:0] address, data_in,
	output reg [31:0] data_out
);

reg [31:0] ram_block [1048576:0]; // 0x10 0000 = 1048576

always @(posedge clock) begin
	if ( address[31:20] == 12'h080 ) begin // Check if the address is for the ROM, so if its start by 0x080
        if(write_enable)
            ram_block[address[19:0]] <= data_in; // Write
        else
            data_out <= ram_block[address[19:0]]; // Read
	end
end

always @(negedge clock) begin
	data_out <= 31'bZ;
end

endmodule