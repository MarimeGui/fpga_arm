`timescale 1ns/1ns

module sram2_tb();
    reg clock, write_enable;
    reg [31:0] address;
    reg [35:0] data_in;
    wire [31:0] data_out;
    wire parity_error_flag;

    // Instantiate the sram2 module
    sram2 UUT (
        .clock(clock),
        .write_enable(write_enable),
        .address(address),
        .data_in(data_in),
        .data_out(data_out),
        .parity_error_flag(parity_error_flag)
    );

    // Clock generation (50% duty cycle, period = 10ns)
    initial begin
        clock = 1;
        forever #5 clock = ~clock; 
    end

    initial begin
        $dumpfile("sram2_tb.vcd");
        $dumpvars(0, sram2_tb);

        write_enable = 0;
        address = 32'h10000000; // Base address within SRAM2 range
        data_in = 36'h0;         // Initialize data_in

        // Step 1: Write data with correct parity to address 0x1000_0000
        #10;
        write_enable = 1;
        data_in = {4'b0000, 32'hA5A5A5A5}; // Correct parity bits (0000) for all even bits data
        address = 32'h10000000;
        #10; 

        // Step 2: Read data back and check parity
        write_enable = 0;
        #10; 
        $display("Data: %h, Parity Error Flag: %b (expected 0)", data_out, parity_error_flag);

        // Step 3: Write data with incorrect parity bits to same address
        write_enable = 1;
        data_in = {4'b1111, 32'hA5A5A5A5}; // Intentionally incorrect parity bits
        address = 32'h10000000;
        #10; 

        // Step 4: Read data back and check parity
        write_enable = 0;
        #10; 
        $display("Data: %h, Parity Error Flag: %b (expected 1)", data_out, parity_error_flag);

        // Step 5: Write data to another address with correct parity
        write_enable = 1;
        data_in = {4'b1010, 32'h5A5A5A5A}; // Correct parity bits
        address = 32'h10000004; 
        #10;

        // Step 6: Read back from new address and check parity
        write_enable = 0;
        #10;
        $display("Data: %h, Parity Error Flag: %b (expected 0)", data_out, parity_error_flag);

        $stop; 
    end
endmodule
