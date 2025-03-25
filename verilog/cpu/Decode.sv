// Takes in a 16-bit instruction and processes it to extract useful information for easy execution afterwards

import Utilities::*;

module Decode(
    input [15:0] instruction,
    input clk,
    input reset,
    output Uop uop,
    output bit num_to_rhs,
    output bit [31:0] num,
    output bit [3:0] sel_p0,
    output bit [3:0] sel_p1,
    output bit [3:0] sel_in,
    output bit [3:0] branch_cond
);

initial begin
    branch_cond = 4'b1111;
end

always @ (negedge clk) begin
    // Set to default outputs
    uop <= NOP;
    num_to_rhs <= 0;
    num <= 0;
    sel_p0 <= 0;
    sel_p1 <= 0;
    sel_in <= 0;
    branch_cond <= 4'b1111;

    case(reset)
        0: begin
    casez(instruction[15:10])
        // Basic Operations
        6'b00????: begin
            casez(instruction[13:9])
                // ----- ADD
            
                // ADD - between registers
                5'b01100: begin
                    uop <= ADD;
                    sel_p0 <= {1'd0, instruction[8:6]};
                    sel_p1 <= {1'd0, instruction[5:3]};
                    sel_in <= {1'd0, instruction[2:0]};
                end

                // ADD - Immediate 3 to Register
                5'b01110: begin
                    uop <= ADD;
                    num <= {29'd0, instruction[8:6]};
                    sel_p1 <= {1'd0, instruction[5:3]};
                    sel_in <= {1'd0, instruction[2:0]};
                    num_to_rhs <= 1;
                end
                // ADD - Immediate 8 to Register directly
                5'b110??: begin
                    uop <= ADD;
                    num <= {24'd0, instruction[7:0]};
                    sel_p1 <= {1'd0, instruction[10:8]};
                    sel_in <= {1'd0, instruction[10:8]};
                    num_to_rhs <= 1;
                end

                // ----- SUB

                // SUB - between registers
                5'b01101: begin
                    uop <= SUB;
                    sel_p0 <= {1'd0, instruction[8:6]};
                    sel_p1 <= {1'd0, instruction[5:3]};
                    sel_in <= {1'd0, instruction[2:0]};
                end
                // SUB - Immediate 3 to Register
                5'b01111: begin
                    uop <= SUB;
                    num <= {29'd0, instruction[8:6]};
                    sel_p1 <= {1'd0, instruction[5:3]};
                    sel_in <= {1'd0, instruction[2:0]};
                    num_to_rhs <= 1;
                end
                // SUB - Immediate 8 to Register
                5'b111??: begin
                    uop <= SUB;
                    num <= {24'd0, instruction[7:0]};
                    sel_p1 <= {1'd0, instruction[10:8]};
                    sel_in <= {1'd0, instruction[10:8]};
                    num_to_rhs <= 1;
                end

                // ----- LSL / MOV

                // LSL - immediate (also MOV Register when shift is 0)
                5'b00???: begin
                    uop <= LSL;
                    num <= {27'd0, instruction[10:6]};
                    sel_p1 <= {1'd0, instruction[5:3]};
                    sel_in <= {1'd0, instruction[2:0]};
                    num_to_rhs <= 1;
                end

                // MOV - Immediate
                5'b100??: begin
                    uop <= MOV;
                    sel_in <= {1'd0, instruction[10:8]};
                    num_to_rhs <= 1;
                    num <= {24'd0, instruction[7:0]};
                end

                // ----- CMP

                // CMP - Immediate
                5'b101??: begin
                    uop <= CMP;
                    sel_p1 <= {1'd0, instruction[10:8]};
                    num <= {24'd0, instruction[7:0]};
                    num_to_rhs <= 1;
                end

                default: begin
                    // Unknown instruction
                end
            endcase
        end

        // Data Processing
        6'b010000: begin
            casez(instruction[9:6])
                // ----- EOR
                4'b0001: begin
                    uop <= EOR;
                    sel_p0 <= {1'd0, instruction[2:0]};
                    sel_in <= {1'd0, instruction[2:0]};
                    sel_p1 <= {1'd0, instruction[5:3]};
                end

                default: begin
                    // Unknown instruction
                end
            endcase
        end

        // Load / Store single data item
        6'b0110??: begin
            casez(instruction[11:9])
                // ----- LDR
                // Immediate Register
                3'b1??: begin
                    uop <= LDR;
                    sel_in <= {1'd0, instruction[2:0]}; // Register to store value to
                    sel_p1 <= {1'd0, instruction[5:3]}; // LHS of address
                    num_to_rhs <= 1;
                    num <= {27'd0, instruction[10:6]}; // RHS of address
                end

                // ----- STR
                // T1
                3'b0??: begin
                    uop <= STR;
                    sel_p0 <= {1'd0, instruction[2:0]}; // Register that has the value to write
                    sel_p1 <= {1'd0, instruction[5:3]}; // LHS of address
                    num_to_rhs <= 1;
                    num <= {27'd0, instruction[10:6]}; // RHS of address
                end
            endcase
        end

        // Unconditional Branch
        //unconditional branch will be treated like a conditional branch with condition "always":1110 
        6'b11100?: begin
           uop <= NOP;
           branch_cond <= 4'b1110;
           num <= {{21{instruction[10]}},instruction[10:0]};
        end

        // Conditional Branch
        6'b1101??: begin

            //instruction 11:8 correspond to the condition which will be send through  
            //instruction 7:0 correspond to the delta i which will be send through num
            uop <= NOP;
            branch_cond <= instruction[11:8];
            num <= {{24{instruction[7]}},instruction[7:0]};
            
        end

        default: begin
            // Unknown instruction
        end

    endcase
    end
endcase

end

endmodule
