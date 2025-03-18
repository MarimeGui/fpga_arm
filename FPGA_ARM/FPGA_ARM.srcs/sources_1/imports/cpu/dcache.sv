// Data cache, stores data in a memory-like way to reuse by instructions later.

module DCache #(
    parameter [4:0] STR_UOP = 4'b1001, 
    parameter [4:0] LDR_UOP = 4'b1010
)(
    input clock,
    input [31:0] addr,
    input [31:0] data_in,
    input [4:0] uop,
    output bit [31:0] data_out
);

// This holds exactly 32 values of 32 bits, this means we need (theoretically) 5 bits for addressing
bit [31:0] dcache_block [31:0];

always @(posedge clock) begin
    case (uop)
        LDR_UOP: begin
            // LDR: Reads data stored on addr to data_out
            data_out <= dcache_block[addr];
        end

        default: begin
            // 0 output if neither STR nor LDR 
            data_out <= 32'b0;
        end
    endcase
end

always @(negedge clock) begin
    case (uop)
        STR_UOP: begin
            // STR: Stores data on addr
            dcache_block[addr] <= data_in;
        end

        default: begin
            // 0 output if neither STR nor LDR 
            data_out <= 32'b0;
        end
    endcase
end

endmodule
