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

reg [31:0] rom_block [1048575:0]; // 0xF FFFF = 1048575

always @(posedge clock) begin
	if ( address[31:20] == 12'h080 ) begin // Check if the address is for the ROM, so if its start by 0x080
        if(write_enable)
            rom_block[address[19:0]] <= data_in; // Write
        else
            data_out <= rom_block[address[19:0]]; // Read
	end
end

always @(negedge clock) begin
	data_out <= 32'bZ;
end

endmodule

// ----- Old version

// module rom (
//     input [2:0] addr,
//     output reg [31:0] data
// );

// initial begin
//     data[0] = 32'h2000;
//     data[1] = 32'h3001;
//     data[2] = 32'h2864;
//     data[3] = 32'hD1FC;
//     data[4] = 32'hE7FE;
//     data[5] = 32'h2000;
//     data[6] = 32'h0000;
//     data[7] = 32'h0000;
// end

// always @(*) begin
//     data = (addr == 3'b000) ? data[0] :
//            (addr == 3'b001) ? data[1] :
//            (addr == 3'b010) ? data[2] :
//            (addr == 3'b011) ? data[3] :
//            (addr == 3'b100) ? data[4] :
//            (addr == 3'b101) ? data[5] :
//            (addr == 3'b110) ? data[6] : data[7];
// end


// endmodule
