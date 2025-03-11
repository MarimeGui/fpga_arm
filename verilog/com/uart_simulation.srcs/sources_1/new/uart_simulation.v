`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.03.2025 14:40:34
// Design Name: 
// Module Name: uart_simulation
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module uart_simulation(
    input clk,
    input RxD,
    //input TxD_start,         
    //input [7:0] TxD_data,
    output TxD,          
    output reg TxD_busy, 
    output reg [7:0] RxD_data,  
    output reg data_ready
    );
    
    wire baud_8tick;
    wire [7:0] rx_data;
    wire rx_ready;
    
    baud_generator#(
        .ClkFrequency(12000000),  // Standard: 12 MHz, 
        .Baud(115200)             
    )baud_gen(
        .clk(clk),           // FPGA main clock
        .BaudTick(baud_8tick)  // Output tick at desired baud rate
    );
    
    uart_rx rx(
        .clk(clk),              
        .Baud8Tick(baud_8tick),        // Oversampling signal (921600 Hz for 115200 baud with 8x oversampling)
        .RxD(RxD),              
        .RxD_data(rx_data),  
        .data_ready(rx_ready)
    );
    
endmodule
