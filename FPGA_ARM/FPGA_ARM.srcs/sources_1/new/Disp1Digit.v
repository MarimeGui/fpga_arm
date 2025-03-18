module Disp1Digit(
	input [3:0] Num,
	output reg [6:0] Seg
	);
	
	always @(*) begin
		case (Num)
			4'h0: Seg = 7'b0111111; // 0
			4'h1: Seg = 7'b0000110; // 1
			4'h2: Seg = 7'b1011011; // 2
			4'h3: Seg = 7'b1001111; // 3
			4'h4: Seg = 7'b1100110; // 4
			4'h5: Seg = 7'b1101101; // 5
			4'h6: Seg = 7'b1111101; // 6
			4'h7: Seg = 7'b0000111; // 7
			4'h8: Seg = 7'b1111111; // 8
			4'h9: Seg = 7'b1101111; // 9
			4'hA: Seg = 7'b1110111; // A
			4'hB: Seg = 7'b1111100; // b
			4'hC: Seg = 7'b1011000; // c
			4'hD: Seg = 7'b1011110; // d
			4'hE: Seg = 7'b1111001; // E
			4'hF: Seg = 7'b1110001; // F
			default: Seg = 7'h00; // Vide
		endcase
	end
	
endmodule