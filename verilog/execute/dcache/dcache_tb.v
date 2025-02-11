`timescale 1ns/1ns

module dcache_tb();
    reg clock;
    reg [4:0] addr;
    reg [31:0] data_in;
    reg [3:0] uop;
    wire [31:0] data_out;

    parameter [3:0] STR_UOP = 4'b1001;
    parameter [3:0] LDR_UOP = 4'b1010;

    dcache #(
        .STR_UOP(STR_UOP), // Adds the parameters to the instantiated module
        .LDR_UOP(LDR_UOP)
    ) UUT (
        .clock(clock),
        .addr(addr),
        .data_in(data_in),
        .uop(uop),
        .data_out(data_out)
    );

    initial begin
        clock = 1'b1; // 10 ns clock
        forever #5 clock = ~clock;
    end

    initial begin
        $dumpfile("dcache_tb.vcd");
        $dumpvars(0, dcache_tb);

        addr <= 5'b11111;   
        data_in <= 32'hDEADBEEF;
        uop <= 4'b0010;     
        #10; 

        $display("1) uop = 4'b0010 -> data_out = %h (expected Z)", data_out);

        addr <= 5'b01010;   
        data_in <= 32'h12345678;
        uop <= STR_UOP;     
        #10; 

       
        uop <= LDR_UOP;    
        #10; 
        $display("2) Reading from addr %b, data_out = %h (expected 0x12345678)", addr, data_out);

        addr <= 5'b00101;  
        data_in <= 32'hAABBCCDD;
        uop <= STR_UOP; 
        #10;

        uop <= LDR_UOP;
        #10;

        $display("3) reading from addr %b, data_out = %h (expected 0xAABBCCDD)", addr, data_out);

        $stop;
    end
endmodule
