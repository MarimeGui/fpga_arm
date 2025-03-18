module uart_rx (
    input clk,              
    input Baud8Tick,        // Oversampling signal (921600 Hz for 115200 baud with 8x oversampling)
    input RxD,              
    output reg [7:0] RxD_data,  
    output reg data_ready      
);

    // RxD
    reg [1:0] RxD_sync;
    always @(posedge clk)
        if (Baud8Tick)
            RxD_sync <= {RxD_sync[0], RxD}; // Synchronizes to avoid metastability

    reg [1:0] RxD_cnt;
    reg RxD_bit;

    always @(posedge clk)
    if (Baud8Tick) begin
        if (RxD_sync[1] && RxD_cnt != 2'b11) RxD_cnt <= RxD_cnt + 1;
        else if (~RxD_sync[1] && RxD_cnt != 2'b00) RxD_cnt <= RxD_cnt - 1;

        if (RxD_cnt == 2'b00) RxD_bit <= 0;
        else if (RxD_cnt == 2'b11) RxD_bit <= 1;
    end

    // Data receival state machine
    reg [3:0] state = 4'b0000;
    always @(posedge clk)
    if (Baud8Tick)
        case (state)
            4'b0000: if (~RxD_bit) state <= 4'b1000; 
            4'b1000: if (next_bit) state <= 4'b1001; 
            4'b1001: if (next_bit) state <= 4'b1010; 
            4'b1010: if (next_bit) state <= 4'b1011; 
            4'b1011: if (next_bit) state <= 4'b1100; 
            4'b1100: if (next_bit) state <= 4'b1101; 
            4'b1101: if (next_bit) state <= 4'b1110; 
            4'b1110: if (next_bit) state <= 4'b1111; 
            4'b1111: if (next_bit) state <= 4'b0001; 
            4'b0001: if (next_bit) state <= 4'b0000; 
            default: state <= 4'b0000;
        endcase

    // Overssampling count to verify when to detect next bit
    reg [2:0] bit_spacing;
    always @(posedge clk)
        if (state == 0)
            bit_spacing <= 0;
        else if (Baud8Tick)
            bit_spacing <= bit_spacing + 1;

    wire next_bit = (bit_spacing == 7); // Indicates when to get next bit

    // Shift register for received data
    always @(posedge clk)
        if (Baud8Tick && next_bit && state[3])
            RxD_data <= {RxD_bit, RxD_data[7:1]};

    // Indicates when a byte has been received
    always @(posedge clk)
        data_ready <= (Baud8Tick && next_bit && state == 4'b0001);

endmodule
