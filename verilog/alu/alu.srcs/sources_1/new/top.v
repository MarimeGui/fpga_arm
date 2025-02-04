`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.01.2025 16:32:36
// Design Name: 
// Module Name: top
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


module top(
    input CLK100MHZ,
    input next,
    input reset,
    output [3:0] out_alu_top,
    output [3:0] flags_wire
    );
    
    wire [3:0] LHS_wire, RHS_wire;
    reg [4:0] uop_wire;
    
    ALU alu(
        .LHS(LHS_wire),
        .RHS(RHS_wire),
        .uop(uop_wire),
        .out_alu(out_alu_top),
        .flags(flags_wire) // [Z, C, N, V] (Zero, Carry, Negative, Overflow)
    );
    
    assign LHS_wire = 2;
    assign RHS_wire = 3;
    
    reg next_sync, next_sync_prev;
    wire next_pulse;
    
    always @(posedge CLK100MHZ) begin
        next_sync_prev <= next_sync;
        next_sync <= next;
    end
    
    assign next_pulse = next_sync & ~next_sync_prev;
    
    always @(posedge CLK100MHZ or posedge reset) begin
        if (reset)
            uop_wire <= 8;
        else if (next_pulse)
            uop_wire <= uop_wire - 1;
    end

endmodule

