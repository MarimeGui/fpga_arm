// Checks if there will be a branch coming up next instruction cycle

import Utilities::*;

module BCC (
    input [3:0] branch_cond,
    input clk,
    input Flags flags,

    output bit do_branch
);

always @ (posedge clk) begin

    case(branch_cond)
        // ----- BEQ Equal
        //Equal
        4'b0000: begin
            // condition verified if Z = 1
            do_branch <= flags.Z;
        end

        // ----- BNE Not equal
        //Not equal / unordered
        4'b0001: begin
            // condition verified if Z = 0
            do_branch <= !flags.Z;
        end

        // ----- BCS  Carry set
        //Greater than, equal, or unordered
        4'b0010: begin
            // condition verified if C = 1
            do_branch <= flags.C;
        end

        // ----- BCC  Carry clear
        //Less than
        4'b0011: begin
            // condition verified if C = 0
            do_branch <= !flags.C;
        end

        // ----- BMI Minus, negative
        //Less than
        4'b0100: begin
            // condition verified if N = 1
            do_branch <= flags.N;
        end

        // ----- BPL Plus, positive or zero
        //Greater than, equal, or unordered
        4'b0101: begin
            // condition verified if N = 0
            do_branch <= !flags.N;
        end

        // ----- BVS Overflow
        //Unordered
        4'b0110: begin
            // condition verified if V = 1
            do_branch <= flags.V;
        end

        // ----- BVC No overflow
        //Not unordered
        4'b0111: begin
            // condition verified if V = 0
            do_branch <= !flags.V;
        end

        // ----- BHI Unsigned higher
        //Greater than, or unordered
        4'b1000: begin
            // condition verified if C = 1 and Z = 0
            do_branch <= (flags.C && !flags.Z);
        end

        // ----- BLS Unsigned lower or same
        //Less than or equal
        4'b1001: begin
            // condition verified if  C = 0 or Z = 1
            do_branch <= (!flags.C || flags.Z);
        end

        // ----- BGE Signed greater than or equal
        //Greater than or equal
        4'b1010: begin
            // condition verified if  N = V
            do_branch <= (flags.N == flags.V);
        end

        // ----- BLT Signed less than
        //Less than, or unordered
        4'b1011: begin
            // condition verified if N != V
            do_branch <= (flags.N != flags.V);
        end

        // ----- BGT Signed greater than
        //Greater than
        4'b1100: begin
            // condition verified if Z=0 and N=V
            do_branch <= (!flags.Z && (flags.N == flags.V));
        end

        // ----- BLE Signed less than or equal
        //Less than, equal, or unordered
        4'b1101: begin
            // condition verified if Z=1 or N!=V
            do_branch <= (flags.Z || (flags.N != flags.V));
        end

        // ----- Undefined
        //Always (unconditional)
        4'b1110: begin
            // no need for flags
            do_branch <= 1;
        end

        4'b1111:begin //Undefined (does not branch)
            do_branch <= 0;
        end
    endcase
end

endmodule
