// Special mux for selecting what will be fed into in_regs in the Register File.

// Generally select ALU
// If uOP is LDR, check address
// If address is < 31, select D-Cache
// Else if address is 31, select GPIO state
// Else, return only zeroes as this address is not defined

module RegReturnMux (
    input [4:0] uop,
    input [31:0] addr,

    input [31:0] alu,
    input [31:0] d_cache,
    input [31:0] gpio_state,

    output bit [31:0] out
);

always @(*) begin
    if (uop == 5'd10) begin
        if (addr < 32'd31) begin
            out = d_cache;
        end else if (addr == 32'd32) begin
            out = gpio_state;
        end else begin
            out = 32'd0;
        end
    end else begin
        out = alu;
    end
end

endmodule
