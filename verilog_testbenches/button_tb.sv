module button_tb();

    reg clk;

    reg button_center;

    ButtonHandler #(50) i_center(
        .clk(clk),
        .button(button_center),
        /* verilator lint_off PINCONNECTEMPTY */
        .pulse(),
        /* verilator lint_off PINCONNECTEMPTY */
        .state()
    );

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars();
        
        clk = 1;
        forever #5 clk = ~clk;
    end

    initial begin
        #100;

        // ----- Short press

        // Bouncy button
        button_center = 1;
        #1;
        button_center = 0;
        #1;
        button_center = 1;
        #5;
        button_center = 0;
        #2;
        button_center = 1;
        #1;
        button_center = 0;
        #1;
        button_center = 1;
        #9;
        button_center = 0;
        #25;
        button_center = 1;
        #2;
        button_center = 0;
        #8;
        button_center = 1;
        #4;
        button_center = 0;
        #2;
        button_center = 1;
        #1;
        button_center = 0;
        #1;
        button_center = 1;
        #5;
        button_center = 0;
        #2;

        #1000;

        // Bouncy button
        button_center = 1;
        #1;
        button_center = 0;
        #1;
        button_center = 1;
        #5;
        button_center = 0;
        #2;
        button_center = 1;
        #1;
        button_center = 0;
        #1;
        button_center = 1;
        #9;
        button_center = 0;
        #25;
        button_center = 1;
        #2;
        button_center = 0;
        #8;
        button_center = 1;
        #4;
        button_center = 0;
        #2;
        button_center = 1;
        #1;
        button_center = 0;
        #1;
        button_center = 1;
        #5;
        button_center = 0;
        #2;

        #1000;

        // ----- Long press

        button_center = 1;
        #1;
        button_center = 0;
        #1;
        button_center = 1;
        #5;
        button_center = 0;
        #2;
        button_center = 1;
        #1;
        button_center = 0;
        #1;
        button_center = 1;
        #9;
        button_center = 0;
        #25;
        button_center = 1;
        #2;
        button_center = 0;
        #8;
        button_center = 1;
        #4;
        button_center = 0;
        #2;
        button_center = 1;
        #1;
        button_center = 0;
        #1;
        button_center = 1;
        #1000;

        button_center = 0;
        #1;
        button_center = 1;
        #5;
        button_center = 0;
        #2;
        button_center = 1;
        #1;
        button_center = 0;
        #1;
        button_center = 1;
        #9;
        button_center = 0;
        #25;
        button_center = 1;
        #2;
        button_center = 0;
        #21;
        button_center = 1;
        #4;
        button_center = 0;
        #30;
        button_center = 1;
        #1;
        button_center = 0;
        #1;
        button_center = 1;
        #5;
        button_center = 0;
        #1000;

        button_center = 1;
        #1;
        button_center = 0;
        #1;
        button_center = 1;
        #5;
        button_center = 0;
        #2;
        button_center = 1;
        #1;
        button_center = 0;
        #1;
        button_center = 1;
        #9;
        button_center = 0;
        #25;
        button_center = 1;
        #2;
        button_center = 0;
        #8;
        button_center = 1;
        #4;
        button_center = 0;
        #2;
        button_center = 1;
        #1;
        button_center = 0;
        #1;
        button_center = 1;
        #1000;

        button_center = 0;
        #1;
        button_center = 1;
        #5;
        button_center = 0;
        #2;
        button_center = 1;
        #1;
        button_center = 0;
        #1;
        button_center = 1;
        #9;
        button_center = 0;
        #25;
        button_center = 1;
        #2;
        button_center = 0;
        #21;
        button_center = 1;
        #4;
        button_center = 0;
        #30;
        button_center = 1;
        #1;
        button_center = 0;
        #1;
        button_center = 1;
        #5;
        button_center = 0;
        #1000;

        $finish;
    end

endmodule
