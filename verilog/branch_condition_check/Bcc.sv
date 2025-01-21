module Bcc(
    input [3:0] branch_cond,
    input clk,
    input [3:0] flags, // [Z, C, N, V] (Zero, Carry, Negative, Overflow)
    input not_enable,
    output reg Ok //=0 if not Ok and 1 if Ok
);
wire Z=flags[3];
wire C = flags[2];
wire N = flags[1];
wire V =flags[0];

always @ (posedge clk) begin
    if (not_enable)
        Ok =0;
    else 
        case(branch_cond)
            // ----- BEQ Equal
            //Equal
            4'b0000: begin
                // condition verified if Z = 1
                Ok = Z;
            end
            // ----- BNE Not equal
            //Not equal / unordered
            4'b0001: begin
                // condition verified if Z = 0
                Ok <= !Z;
            end
            // ----- BCS  Carry set
            //Greater than, equal, or unordered
            4'b0010: begin
                // condition verified if C = 1
                Ok <= C;
            end
            // ----- BCC  Carry clear
            //Less than
            4'b0011: begin
                // condition verified if C = 0
                Ok <= !C;
            end
            // ----- BMI Minus, negative
            //Less than
            4'b0100: begin
                // condition verified if N = 1
                Ok <= N;
            end
            // ----- BPL Plus, positive or zero
            //Greater than, equal, or unordered
            4'b0101: begin
                // condition verified if N = 0
                Ok <= !N;
            end
            // ----- BVS Overflow
            //Unordered
            4'b0110: begin
                // condition verified if V = 1
                Ok <= V;
            end
            // ----- BVC No overflow
            //Not unordered
            4'b0111: begin
                // condition verified if V = 0
                Ok <= !V;
            end
            // ----- BHI Unsigned higher
            //Greater than, or unordered
            4'b1000: begin
                // condition verified if C = 1 and Z = 0
                Ok <= (C && !Z);
            end
            // ----- BLS Unsigned lower or same
            //Less than or equal
            4'b1001: begin
                // condition verified if  C = 0 or Z = 1
                Ok <= (!C || Z);
            end
            // ----- BGE Signed greater than or equal
            //Greater than or equal
            4'b1010: begin
                // condition verified if  N = V
                Ok <= (N == V);
            end
            // ----- BLT Signed less than
            //Less than, or unordered
            4'b1011: begin
                // condition verified if N != V
                Ok <= (N != V);
            end
            // ----- BGT Signed greater than
            //Greater than
            4'b1100: begin
                // condition verified if Z=0 and N=V
                Ok <= (!Z && (N==V));
            end
            // ----- BLE Signed less than or equal
            //Less than, equal, or unordered
            4'b1101: begin
                // condition verified if Z=1 or N!=V
                Ok <= (Z || (N!=V));
            end
            // ----- Undefined
            //Always (unconditional)
            4'b1110: begin
                // no need for flags
                Ok <= 1;
            end
        endcase
end

endmodule