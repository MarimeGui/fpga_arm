module CTRLuOP(
    input CLK,
    input BTNU, BTND, BTNR,
    output reg [4:0] uOP
    );
    
    reg BTNUBefore, BTNDBefore, BTNRBefore;
    
	initial begin
		uOP <= 5'b0;
		BTNUBefore <= 0;
		BTNDBefore <= 0;
		BTNRBefore <= 0;
	end
    
    always @(posedge CLK) begin
        if ( (BTNU & !BTNUBefore) & (uOP < 5'h0F) )
            uOP <= uOP + 1;
        else if ( (BTND & !BTNDBefore) & (uOP > 5'h01) )
            uOP <= uOP - 2;
        else if (BTNR & !BTNRBefore)
            uOP <= 5'h00;
        BTNUBefore <= BTNU;
        BTNDBefore <= BTND;
        BTNRBefore <= BTNR;
    end
endmodule
