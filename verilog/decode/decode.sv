module Decode(
    input [15:0] instruction,
    input clk,
    input reset,
    output reg [4:0] uop,
    output reg num_to_rhs,
    output reg [31:0] num,
    output reg [3:0] sel_p0,
    output reg [3:0] sel_p1,
    output reg [3:0] sel_in,
    output reg explose,
    output reg [3:0] branch_cond
);

always @ (posedge clk) begin
    // Default outputs
    uop = 0;
    num_to_rhs = 0;
    num = 0;
    sel_p0 = 0;
    sel_p1 = 0;
    sel_in = 0;
    explose = 0;
    branch_cond = 4'b1111;

    casez(instruction[15:10])
        // Basic Operations
        6'b00????: begin
            casez(instruction[13:9])
                // ----- ADD
            
                // ADD - between registers
                5'b01100: begin
                    uop = 5'b00001;
                    sel_p0 = instruction[8:6];
                    sel_p1 = instruction[5:3];
                    sel_in = instruction[2:0];
                end

                // ADD - Immediate 3 to Register
                5'b01110: begin
                    uop = 5'b00001;
                    num = instruction[8:6];
                    sel_p1 = instruction[5:3];
                    sel_in = instruction[2:0];
                    num_to_rhs = 1;
                end
                // ADD - Immediate 8 to Register directly
                5'b110??: begin
                    uop = 5'b00001;
                    num = instruction[7:0];
                    sel_p1 = instruction[10:8];
                    sel_in = instruction[10:8];
                    num_to_rhs = 1;
                end

                // ----- SUB

                // SUB - between registers
                5'b01101: begin
                    uop = 2;
                    sel_p0 = instruction[8:6];
                    sel_p1 = instruction[5:3];
                    sel_in = instruction[2:0];
                end
                // SUB - Immediate 3 to Register
                5'b01111: begin
                    uop = 2;
                    num = instruction[8:6];
                    sel_p1 = instruction[5:3];
                    sel_in = instruction[2:0];
                    num_to_rhs = 1;
                end
                // SUB - Immediate 8 to Register
                5'b111??: begin
                    uop =2;
                    num = instruction[7:0];
                    sel_p1 = instruction[10:8];
                    sel_in = instruction[10:8];
                    num_to_rhs = 1;
                end

                // ----- LSL

                // LSL - immediate
                5'b00???: begin
                    uop= 5'b00110;
                    num = instruction[10:6];
                    sel_p1 = instruction[5:3];
                    sel_in = instruction[2:0];
                    num_to_rhs = 1;
                end

                // ----- MOV

                // MOV - Register
                5'b00000: begin
                    uop=8;
                    sel_p0=instruction[5:3];
                    sel_in=instruction[2:0];
                end
                // MOV - Immediate
                5'b100??: begin
                    uop=8;
                    sel_in=instruction[10:8];
                    num_to_rhs=1;
                    num=instruction[7:0];
                end

                // ----- CMP

                // CMP - Immediate
                5'b101??: begin
                    uop=5;
                    sel_p1=instruction[10:8];
                    num=instruction[7:0];
                    num_to_rhs=1;
                end

                default: explose = 1;
            endcase
        end

        // Data Processing
        6'b010000: begin
            casez(instruction[9:6])
                // ----- EOR
                4'b0001: begin
                    uop=4;
                    sel_p0=instruction[2:0];
                    sel_in=instruction[2:0];
                    sel_p1=instruction[5:3];
                end
            endcase
        end

        // Load / Store single data item
        6'b0110??: begin
            casez(instruction[11:9])
                // ----- LDR
                3'b0??: begin
                    uop=10;
                    sel_in=instruction[2:0];
                    sel_p1=instruction[5:3];
                    // TODO: Missing offset
                end

                // ----- STR
                3'b1??: begin
                    uop=9;
                    sel_p0=instruction[2:0]; // Register that has the value to write
                    sel_p1=instruction[5:3]; // LHS of address
                    num_to_rhs = 1;
                    num = instruction[10:6]; // RHS of address
                end
            endcase
        end

        // Unconditional Branch
        //unconditional branch will be treated like a conditional branch with condition "always":1110 
        6'b11100?: begin
           uop=0;
           branch_cond=4'b1110;
           num= instruction[10:0];
        end

        // Conditional Branch
        6'b1101??: begin

            //instruction 11:8 correspond to the condition which will be send through  
            //instruction 7:0 correspond to the delta i which will be send through num
            uop = 0;
            branch_cond = instruction[11:8];
            num = instruction[7:0];
            
        end

        default: explose = 1;
    endcase
end

endmodule
