module rom (
    input [2:0] addr,
    output reg [31:0] data
);

initial begin
    data[0] = 32'h2000;
    data[1] = 32'h3001;
    data[2] = 32'h2864;
    data[3] = 32'hD1FC;
    data[4] = 32'hE7FE;
    data[5] = 32'h2000;
    data[6] = 32'h0000;
    data[7] = 32'h0000;
end

always @(*) begin
    data = (addr == 3'b000) ? data[0] :
           (addr == 3'b001) ? data[1] :
           (addr == 3'b010) ? data[2] :
           (addr == 3'b011) ? data[3] :
           (addr == 3'b100) ? data[4] :
           (addr == 3'b101) ? data[5] :
           (addr == 3'b110) ? data[6] : data[7];
end


endmodule