// Simple 32-bit Mux

module Mux32(
    input [31:0] a,
    input [31:0] b,
    input sel,
    output bit [31:0] out
);

always @(*) begin
    if (sel) begin
        out = b;
    end
    else begin
        out = a;
    end
end

endmodule
