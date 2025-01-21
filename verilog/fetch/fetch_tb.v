`timescale 1ns/1ns

module fetch_tb();
    reg clk;
	reg [31:0] delta_i;
	wire [31:0] index;
	
    Fetch UUT(
        .clk(clk),
        .delta_i(delta_i),
        .index(index)
    );

    // Setup clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $dumpfile("fetch_tb.vcd");
        $dumpvars(0, fetch_tb);
		
		delta_i = 0;
		#10;
		#10;
		
		delta_i = 10;
		#10;
		
		delta_i = -5;
		#10;
		#10;
		
		$stop;
    end

endmodule
