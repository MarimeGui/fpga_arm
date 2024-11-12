module Decode(
    input [15:0] instruction,
    input clk,
    output reg [4:0] uop,
    output reg num_to_rhs,
    output reg [31:0] num,
    output reg [3:0] sel_p0,
    output reg [3:0] sel_p1,
    output reg [3:0] sel_in,
    output reg explose
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

    casez(instruction[15:10])
        // Basic Operations
        6'b00????: begin
            casez(instruction[13:9])
                // Add between registers
                5'b01100: begin
                    uop = 5'b00001;
                    sel_p0 = instruction[8:6];
                    sel_p1 = instruction[5:3];
                    sel_in = instruction[2:0];
                end

                // Add Immediate 3 to Register
                5'b01110: begin
                    uop = 5'b00001;
                    num = instruction[8:6];
                    sel_p1 = instruction[5:3];
                    sel_in = instruction[2:0];
                    num_to_rhs = 1;
                end
                //Add Immediate 8 to Register directly
                5'b110??: begin
                    uop = 5'b00001;
                    num = instruction[7:0];
                    sel_p1 = instruction[10:8];
                    sel_in = instruction[10:8];
                    num_to_rhs = 1;
                end
                // Sub between registers
                5'b01101: begin
                    uop = 5'b00001;
                    sel_p0 = instruction[8:6];
                    sel_p1 = instruction[5:3];
                    sel_in = instruction[2:0];
                end
                // Sub Immediate 3 to Register
                5'b01111: begin
                
                end
                // Sub Immediate 8 to Register
                5'b111??: begin
                
                end
                // LSL immediate
                5'b00???: begin
                    uop= 5'b00110;
                    num = instruction[10:6];
                    sel_p1 = instruction[5:3];
                    sel_in = instruction[2:0];
                    num_to_rhs = 1;
                end

                default: explose = 1;
            endcase
        end

        // Data Processing
        // 6'b010000:

        // ...

        default: explose = 1;
    endcase
end

endmodule
