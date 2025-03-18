// Checks if there will be a branch coming up next instruction cycle

module BCC (
    input [3:0] branch_cond,
    input clk,
    input [3:0] flags, // [Z, C, N, V] (Zero, Carry, Negative, Overflow)
    
    output bit do_branch
);

wire Z = flags[3];
wire C = flags[2];
wire N = flags[1];
wire V = flags[0];

always @ (posedge clk) begin

    case(branch_cond)
        // ----- BEQ Equal
        //Equal
        4'b0000: begin
            // condition verified if Z = 1
            do_branch <= Z;
        end

        // ----- BNE Not equal
        //Not equal / unordered
        4'b0001: begin
            // condition verified if Z = 0
            do_branch <= !Z;
        end

        // ----- BCS  Carry set
        //Greater than, equal, or unordered
        4'b0010: begin
            // condition verified if C = 1
            do_branch <= C;
        end

        // ----- BCC  Carry clear
        //Less than
        4'b0011: begin
            // condition verified if C = 0
            do_branch <= !C;
        end

        // ----- BMI Minus, negative
        //Less than
        4'b0100: begin
            // condition verified if N = 1
            do_branch <= N;
        end

        // ----- BPL Plus, positive or zero
        //Greater than, equal, or unordered
        4'b0101: begin
            // condition verified if N = 0
            do_branch <= !N;
        end

        // ----- BVS Overflow
        //Unordered
        4'b0110: begin
            // condition verified if V = 1
            do_branch <= V;
        end

        // ----- BVC No overflow
        //Not unordered
        4'b0111: begin
            // condition verified if V = 0
            do_branch <= !V;
        end

        // ----- BHI Unsigned higher
        //Greater than, or unordered
        4'b1000: begin
            // condition verified if C = 1 and Z = 0
            do_branch <= (C && !Z);
        end

        // ----- BLS Unsigned lower or same
        //Less than or equal
        4'b1001: begin
            // condition verified if  C = 0 or Z = 1
            do_branch <= (!C || Z);
        end

        // ----- BGE Signed greater than or equal
        //Greater than or equal
        4'b1010: begin
            // condition verified if  N = V
            do_branch <= (N == V);
        end

        // ----- BLT Signed less than
        //Less than, or unordered
        4'b1011: begin
            // condition verified if N != V
            do_branch <= (N != V);
        end

        // ----- BGT Signed greater than
        //Greater than
        4'b1100: begin
            // condition verified if Z=0 and N=V
            do_branch <= (!Z && (N==V));
        end

        // ----- BLE Signed less than or equal
        //Less than, equal, or unordered
        4'b1101: begin
            // condition verified if Z=1 or N!=V
            do_branch <= (Z || (N!=V));
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
