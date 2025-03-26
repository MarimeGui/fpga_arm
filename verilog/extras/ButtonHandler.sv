module ButtonHandler #(
    parameter PERIOD = 32'd1000000
) (
    input clk,

    input button,
    output bit pulse,
    output bit state
);

    bit low_part;
    bit allowed = 1;
    bit [31:0] counter;

    always @(posedge clk) begin
        if (allowed & button) begin
            counter <= PERIOD;
            pulse <= 1;
            state <= !state;
            allowed <= 0;
            low_part <= 0;
        end

        // If counter is running, decrease until 0
        if (counter != 0) begin
            counter <= counter - 1;
            pulse <= 0;
        end

        // After counter for high state of button, wait for button to go down and trigger counter again for low state
        if ((counter == 0) & !low_part & !allowed & !button) begin
            low_part <= 1;
            counter <= PERIOD;
        end

        // Once counter for low state is over, a new press is allowed
        if ((counter == 0) & low_part & !allowed) begin
            allowed <= 1;
            low_part <= 0;
        end
    end

endmodule
