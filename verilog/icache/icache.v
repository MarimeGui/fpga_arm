module icache (
	input clock,
	input not_enable, // high = disable
	input [31:0] index,
	output reg [15:0] data
);

// 1000 16-bit memory cells
reg [15:0] cache_memory [999:0];

initial begin
	data <= 1'b0;
	cache_memory[0] <= 16'h0123;
	cache_memory[1] <= 16'h4567;
	cache_memory[2] <= 16'h89AB;
	cache_memory[3] <= 16'hCDEF;
end

always @(posedge clock) begin
	if (!not_enable) begin
		// Send the selected (index) memory cell
		data <= cache_memory[index];
	end else begin
		// Module disable
		data <= 1'b0;
	end
end

endmodule