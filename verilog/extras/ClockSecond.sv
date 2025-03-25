// https://www.fpga4student.com/2017/08/verilog-code-for-clock-divider-on-fpga.html

module ClockSecond #(
    parameter DIVISOR = 32'd100000000
) (
    input clk_in,
    output bit clk_out
);

bit[31:0] counter=32'd0;

always @(posedge clk_in)
begin
    counter <= counter + 32'd1;

    if(counter>=(DIVISOR-1))
        counter <= 32'd0;
    
    clk_out <= (counter<DIVISOR/2)?1'b1:1'b0;

end

endmodule
