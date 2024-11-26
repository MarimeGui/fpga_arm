/*
Memory's name: ROM-Flash
Size: 1 MBytes = 1 048 576 Bytes
Start address: 0x0800 0000
End address: 0x080F FFFF
*/

module rom(
	input clock, write_enable,
	input [31:0] address, data_in,
	output reg [31:0] data_out
);

reg [7:0] rom_block [1048575:0]; // 0xF FFFF * 4 = 1048575 * 4 = 4194300

always @(negedge clock) begin
	if (address[31:20] == 12'h080) begin // Check if the address is for the ROM, so if its start by 0x080
        if(write_enable) begin // Write
            rom_block[address[19:0]+3] <= (data_in >> 24) & 8'hFF;
            rom_block[address[19:0]+2] <= (data_in >> 16) & 8'hFF;
            rom_block[address[19:0]+1] <= (data_in >> 8) & 8'hFF;
            rom_block[address[19:0]] <= data_in & 8'hFF;
        end else begin // Read
            data_out <=
				  rom_block[address[19:0]+3] << 24
				| rom_block[address[19:0]+2] << 16
				| rom_block[address[19:0]+1] << 8
				| rom_block[address[19:0]];
		end
	end else begin // Adress is not an adress in ROM
		data_out <= 32'bZ;
	end
end

always @(posedge clock) begin
	data_out <= 32'bZ;
end

endmodule