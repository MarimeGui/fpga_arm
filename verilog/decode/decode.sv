module Decode(
    input [15:0] instruction,
    input clk,
    input reset,
    input [31:0] PC_in,
    output reg [4:0] uop,
    output reg num_to_rhs,
    output reg [31:0] num,
    output reg [31:0] in_reg,
    output reg [31:0] PC_out,
    output reg [3:0] sel_p0,
    output reg [3:0] sel_p1,
    output reg [3:0] sel_in,
    output reg explose,
    output reg in_enable_reg
);

wire [31:0] LR_reg;
wire [2:0] counter;

// Counter for delays on branch operations
always @(posedge clock) begin
    switch(counter):
    case 1:
        in_enable_reg <= 0;
    case 2:
        reset <= 1;
    case 3:
        in_enable_reg <= 1;
end

always @(posedge clock) begin
    if(counter != 4):
        counter +=1;
end

always @ (posedge clk) begin
    // Default outputs
    uop = 0;
    num_to_rhs = 0;
    num = 0;
    sel_p0 = 0;
    sel_p1 = 0;
    sel_in = 0;
    explose = 0;

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
                    sel_p0=instruction[2:0];
                    sel_p1=instruction[5:3];
                    // TODO: Missing offset
                end
            endcase
        end

        // Unconditional Branch
        6'b11100?: begin
            sel_in <= 14;
            in_reg <= PC_out;
            PC_in <= PC_out + instruction[10:0] - 3;
            reset <= 1;
            counter <= 0;
            // TODO: implement counter logic for execution delay


        //     // ----- B
        //     // TODO
        end

        // Conditional Branch
        6'b1101??: begin
            casez(instruction[11:8])
                // ----- BEQ
                4'b0000: begin
                    // TODO
                end

                // ----- BNE
                4'b0001: begin
                    // TODO
                end

                // ----- BCS
                4'b0010: begin
                    // TODO
                end

                // ----- BCC
                4'b0011: begin
                    // TODO
                end

                // ----- BMI
                4'b0100: begin
                    // TODO
                end

                // ----- BPL
                4'b0101: begin
                    // TODO
                end

                // ----- BVS
                4'b0110: begin
                    // TODO
                end

                // ----- BVC
                4'b0111: begin
                    // TODO
                end

                // ----- BHI
                4'b1000: begin
                    // TODO
                end

                // ----- BLS
                4'b1001: begin
                    // TODO
                end

                // ----- BGE
                4'b1010: begin
                    // TODO
                end

                // ----- BLT
                4'b1011: begin
                    // TODO
                end

                // ----- BGT
                4'b1100: begin
                    // TODO
                end

                // ----- BLE
                4'b1101: begin
                    // TODO
                end

                // ----- Undefined
                4'b1110: begin
                    // TODO
                end

                // ----- SVC
                4'b1110: begin
                    // TODO
                end
            endcase
        end

        default: explose = 1;
    endcase
end

endmodule
