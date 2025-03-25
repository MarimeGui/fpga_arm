`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.03.2025 16:25:55
// Design Name: 
// Module Name: PLL
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


module PLL(
        input bit CLKin,
        input bit [31:0] divider,
        output bit CLKout
    );
    
    bit [31:0] i;
    
    initial begin
        i <= 0;
    end
    
    always @(posedge CLKin) begin
        if (i < divider) begin
            i <= i + 1;
        end else begin
            i <= 0;
            CLKout <= !CLKout;
        end
    end
endmodule
