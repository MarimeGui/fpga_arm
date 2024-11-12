module paritycheck(
    input [31:0] data,
    input [3:0] parity_bits,
    output error_flag
);

wire [3:0] parity_verify;

assign parity_verify[0] = ^data[7:0];
assign parity_verify[1] = ^data[15:8];
assign parity_verify[2] = ^data[23:16];
assign parity_verify[3] = ^data[31:24];

assign error_flag = |(parity_verify ^ parity_bits);

endmodule