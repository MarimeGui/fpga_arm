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

    reg [4:0] nb_uop;
    
    assign LHS_wire = 3;
    assign RHS_wire = 2;
    
    always @(*) begin
        uop_wire <= 2;
    end
    /*
    always @(posedge next or posedge reset) begin
        if (reset)
            // Reset
            uop_wire <= 8;
        else
            uop_wire <= uop_wire - 1;
    end*/

endmodule

