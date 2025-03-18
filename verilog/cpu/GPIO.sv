// This code is very similar to D-Cache, except that the internal state is always at the output

import Utilities::STR;

module GPIO(
    input clk,
    input [4:0] uop,
    input [31:0] addr,
    input [31:0] state_in,

    // Holds the state of the 32 outputs
    output bit [31:0] state
);

// On down edge
always @(negedge clk) begin
    // If op is a STR and address is 32
    if ((uop == STR) & (addr == 32'd32)) begin
        state <= state_in;
    end
end

endmodule
