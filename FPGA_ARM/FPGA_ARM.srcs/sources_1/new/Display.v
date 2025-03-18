module Display(
        input CLK100MHZ,
        input [31:0] In,
        input [3:0] Flag,
        input [4:0] uOP,
        input [31:0] Out,
        output [15:0] LED,
        output [3:0] Disable7Seg,
        output [6:0] Seg,
        output DP
    );
    
    // ===== Clock 1KHz =====
    wire CLK2KHZ;
    Tick_1ms Tick(
        .CLK100MHZ(CLK100MHZ),
        .CLK2KHZ(CLK2KHZ)
    );
    
    // ===== Switch Sel =====
    reg [1:0] sel;
    always @(posedge CLK2KHZ) begin
        if (sel < 3)
            sel <= sel + 1;
        else
            sel <= 0;
    end
    
    // ===== Display Results =====
    
    wire [6:0] Digit [3:0];
    
    assign LED[15:12] = uOP[3:0];
    assign LED[11:8] = 4'h0;
    assign LED[7:0] = In[7:0];
    assign DP = !Flag[sel];
    assign Seg = 7'hFF ^ Digit[sel];
    assign Disable7Seg = 4'hF ^ (1 << sel);
    
    Disp1Digit DispDigit0(
	   .Num(Out[3:0]),
	   .Seg(Digit[0])
	);
    Disp1Digit DispDigit1(
	   .Num(Out[7:4]),
	   .Seg(Digit[1])
	);
    Disp1Digit DispDigit2(
	   .Num(Out[11:8]),
	   .Seg(Digit[2])
	);
    Disp1Digit DispDigit3(
	   .Num(Out[15:12]),
	   .Seg(Digit[3])
	);
	
endmodule
