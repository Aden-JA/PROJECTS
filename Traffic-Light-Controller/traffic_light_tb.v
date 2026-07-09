`timescale 1ns/1ps

module traffic_light_tb;

    reg clk;
    reg reset;
    wire red;
    wire green;
    wire yellow;

// Connect testbench to main module
    traffic_light uut (                  // uut stand for "unit under test", standard naming convention for testbenches
        .clk(clk),
        .reset(reset),
        .red(red),
        .green(green),
        .yellow(yellow)
    );

    // clock generation
    initial clk = 0;
    always #5 clk = ~clk;             // every 5ns, flip the clock signal (0 to 1 to 0 to 1 ...)
                                      // This creates a clock with a period of 10ns (100MHz)
    initial begin
        // Generate waveform file for GTKWave
        $dumpfile("traffic_light.vcd");             // creates a .vcd file that GTKWave reads to show waveforms
        $dumpvars(0, traffic_light_tb);             // tells Icarus to record all signals in the testbench

        // Apply reset
        reset = 1;
        #20;

        // Release reset and run
        reset = 0;
        #200;

        $finish;

    end


    // Print signal values to terminal

    initial begin
        $monitor("Time=%0t reset=%b red=%b green=%b yellow=%b",
                $time, reset, red, green, yellow);
    end

endmodule

// $monitor automatically prints whenever any signal changes