/*
Memory's name: SRAM2
Size: 32 KBytes = 32 768 Bytes
Start address: 0x1000 0000
End address: 0x1000 7FFF
SRAM2: 32K (32768) 0x1000 0000 - 0x1000 7FFF
*/


module sram2(
	input clock, write_enable,
	input [31:0] address,
	input [35:0] data_in,
	output reg [31:0] data_out,
	output parity_error_flag
);

reg [31:0] rom_block [32767:0]; // 0x7FFF = 32767

paritycheck parity(.data(data_in[31:0]), .parity_bits(data_in[35:32]), .error_flag(parity_error_flag));

always @(negedge clock) begin
	if ( address[31:16] == 16'h1000 ) begin // Check if the address is for SRAM2, so if its start by 0x080
		if(write_enable) begin // Write
            rom_block[address[15:0]+3] <= (data_in >> 24) & 8'hFF;
            rom_block[address[15:0]+2] <= (data_in >> 16) & 8'hFF;
            rom_block[address[15:0]+1] <= (data_in >> 8) & 8'hFF;
            rom_block[address[15:0]] <= data_in & 8'hFF;
        end else begin // Read
            data_out <=
				  rom_block[address[15:0]+3] << 24
				| rom_block[address[15:0]+2] << 16
				| rom_block[address[15:0]+1] << 8
				| rom_block[address[15:0]];
		end
	end else begin // Adress is not an adress in SRAM2
		data_out <= 32'bZ;
	end
end

// Tri-state buffer
always @(posedge clock) begin
	data_out <= 31'bZ;
end

endmodule
