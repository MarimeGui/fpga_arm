`timescale 1ns/1ns

module paritycheck_tb();
    reg [31:0] data;
    reg [3:0] parity_bits;
    wire error_flag;

    // Instantiate the parity check module
    paritycheck UUT (
        .data(data),
        .parity_bits(parity_bits),
        .error_flag(error_flag)
    );

    initial begin
        $dumpfile("paritycheck_tb.vcd");
        $dumpvars(0, paritycheck_tb);

        // Test case: data = 0xFFFFFFFF, expected parity bits = 0b0000 (no errors expected)
        data = 32'hFFFFFFFF;
        parity_bits = 4'b0000; // Expected parity bits for even parity
        #10; // Wait for some time for evaluation

        // Display the results
        $display("Data: %h, Expected Parity: %b, Error Flag: %b", data, parity_bits, error_flag);
        if (error_flag == 0) begin
            $display("Test Passed: No parity error detected.");
        end else begin
            $display("Test Failed: Unexpected parity error detected.");
        end
        #10;

        parity_bits = 4'b0001; // Inducing a parity error
        #10;
        $display("Data: %h, Expected Parity: %b, Error Flag: %b", data, parity_bits, error_flag);
        if (error_flag == 0) begin
            $display("Test Passed: No parity error detected.");
        end else begin
            $display("Test Failed: Unexpected parity error detected.");
        end
        #10;

        $stop;
    end
endmodule
