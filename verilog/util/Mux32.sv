module Mux32(
    input [31:0] a,
    input [31:0] b,
    input sel,
    output reg [31:0] out
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
