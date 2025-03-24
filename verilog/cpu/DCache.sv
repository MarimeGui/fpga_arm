// Data cache, stores data in a memory-like way to reuse by instructions later.

import Utilities::STR;
import Utilities::LDR;

module DCache (
    input clock,
    input [4:0] addr,
    input [31:0] data_in,
    input [4:0] uop,
    output bit [31:0] data_out
);

// This holds exactly 32 values of 32 bits, this means we need (theoretically) 5 bits for addressing
bit [31:0] dcache_block [31:0];

always @(posedge clock) begin
    case (uop)
        LDR: begin
            // LDR: Reads data stored on addr to data_out
            data_out <= dcache_block[addr];
        end

        default: begin
            // Output 0 if not LDR for rising edge
            data_out <= 32'b0;
        end
    endcase
end

always @(negedge clock) begin
    case (uop)
        STR: begin
            // STR: Stores data on addr
            dcache_block[addr] <= data_in;
        end

        default: begin
            // Don't do anything if not STR for falling edge
        end
    endcase
end

endmodule
