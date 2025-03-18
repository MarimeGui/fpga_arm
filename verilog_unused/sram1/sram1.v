/*
Memory's name: SRAM 1
Size: 96 KBytes = 98 304 Bytes
Start address: 0x2000 0000
End address: 0x2001 7FFF

0b 0010 0000 0000 0000 0000 0000 0...0
0b 0010 0000 0000 0001 0111 1111 1...1

0b 0010 0000 0000 0000	 = 16'h2000
0b 0010 0000 0000 0001 0 = 17'h4002

*/

module sram1(
	input clock, read_write,
	input [31:0] address, data_in,
	output reg [31:0] data_out
);

reg [31:0] sram1_block [32767:0]; // 0x7FFF = 32 767

always @(negedge clock) begin
	if ( (address[31:16] == 16'h2000) || (address[31:15] == 17'h4002) ) begin // Check if the address is for SRAM 1
		if(read_write) begin // Write
            sram1_block[address[14:0]+3] <= (data_in >> 24) & 8'hFF;
            sram1_block[address[14:0]+2] <= (data_in >> 16) & 8'hFF;
            sram1_block[address[14:0]+1] <= (data_in >> 8) & 8'hFF;
            sram1_block[address[14:0]] <= data_in & 8'hFF;
        end else begin // Read
            data_out <=
				  sram1_block[address[14:0]+3] << 24
				| sram1_block[address[14:0]+2] << 16
				| sram1_block[address[14:0]+1] << 8
				| sram1_block[address[14:0]];
		end
	end else begin // Adress is not an adress in ROM
		data_out <= 32'bZ;
	end
end

always @(posedge clock) begin
	data_out <= 32'bZ;
end

endmodule
