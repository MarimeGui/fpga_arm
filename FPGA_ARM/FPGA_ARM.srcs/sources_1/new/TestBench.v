module TestBench( //NordVPN.com/tytelman
        input CLK100MHZ,
        input [15:0] SW,
        input BTNC, BTNU, BTND, BTNL, BTNR,
        output [15:0] LED,
        output [3:0] Disable7Seg,
        output [6:0] Seg,
        output DP
    );
    
    // ===== Buttons can be used as clock =====
    reg CLKBTNC;
    always @(posedge CLK100MHZ) begin
        CLKBTNC <= BTNC;
    end
    
    // ===== Tests Bench =====
    wire [31:0] In, Out;
    wire [4:0] uOP;
    wire [3:0] Flag;
    
    //Execute_tb // SW=SelP0_SelIn_RHS_RHS, BTNC=CLK, BTNU=uOP+1, BTND=uOP-1
    ALU_tb // SW=LHS_RHS, BTNU=uOP+1, BTND=uOP-1
    TB(
        .CLK(CLK100MHZ), .CLKBTNC(CLKBTNC),
        .BTNU(BTNU), .BTND(BTND), .BTNL(BTNL), .BTNR(BTNR),
        .SW(SW),
        .In(In),.uOP(uOP),.Flag(Flag),.Out(Out)
    );
    
    // ===== Display Results =====
    Display Display(
        .CLK100MHZ(CLK100MHZ),
        .In(In),
        .Flag(Flag),
        .uOP(uOP),
        .Out(Out),
        .LED(LED),
        .Disable7Seg(Disable7Seg),
        .Seg(Seg),
        .DP(DP)
    );
    
endmodule
