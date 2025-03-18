module Tick_1ms(
        input CLK100MHZ,
        output reg CLK2KHZ
    );
    
    reg [31:0] divisor;
    always @(posedge CLK100MHZ) begin
        if (divisor < 49999)
            divisor <= divisor + 1;
        else begin
            divisor <= 0;
            CLK2KHZ <= !CLK2KHZ;
        end
    end
endmodule
