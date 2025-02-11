module uart_tx (
    input clk,               
    input BaudTick,         
    input TxD_start,         
    input [7:0] TxD_data,   
    output reg TxD,          
    output reg TxD_busy      
);

    reg [3:0] state = 4'b0000;  
    reg [7:0] shift_reg;        // Shift register for output data
    reg [3:0] bit_count;        

    always @(posedge clk) begin
        case(state)
            4'b0000: begin // Idle
                TxD <= 1; // TXD HIGH when idle
                TxD_busy <= 0;
                if (TxD_start) begin
                    shift_reg <= TxD_data; // Loads data on shift register
                    bit_count <= 0;
                    TxD_busy <= 1;
                    state <= 4'b0100; 
                end
            end

            4'b0100: begin // START bit
                if (BaudTick) begin
                    TxD <= 0; // Sends START bit (LOW)
                    state <= 4'b1000; // Starts sending data
                end
            end

            4'b1000: begin // Sends data bits (0 to 7)
                if (BaudTick) begin
                    TxD <= shift_reg[0]; // Sends LSB
                    shift_reg <= shift_reg >> 1; // Shifts bits for next 
                    bit_count <= bit_count + 1;
                    if (bit_count == 7) 
                        state <= 4'b0001;
                end
            end

            4'b0001: begin // STOP bit
                if (BaudTick) begin
                    TxD <= 1; // Sends STOP bit (HIGH)
                    state <= 4'b0010;
                end
            end

            4'b0010: begin // End of transmission
                if (BaudTick) begin
                    TxD_busy <= 0; 
                    state <= 4'b0000; // Back to IDLE
                end
            end

            default: state <= 4'b0000; // Reset 
        endcase
    end

endmodule
