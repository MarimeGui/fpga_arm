

module cpu_tb();
    reg clk;
    reg download_program;
    reg [31:0] instruction_index;
    reg [15:0] program_in;

    CPU CPU(
    .clk(clk),
    .download_program(download_program),
    .instruction_index(instruction_index),
    .program_in(program_in)
    );

    initial begin
        clk = 1;
        forever #5 clk = ~clk;
    end
    
    initial begin
    download_program =1;
    instruction_index =10;
    program_in <=16'b0010000000000101;

    #10;
    instruction_index<=11;
    program_in <= 16'b0001111111000010;;


    #10;
    download_program<=0;
    #10

    #10
    #10
    $stop;
    end


endmodule