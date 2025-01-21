module Mux32(
    input [31:0] a,
    input [31:0] b,
    input sel,
    output wire [31:0] out
);

if (sel) begin
    out <= b;
else 
    out <= a;
end

endmodule
