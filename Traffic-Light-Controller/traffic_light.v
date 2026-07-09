module traffic_light (
    input clk,
    input reset,
    output reg red,
    output reg green,
    output reg yellow
    );


// State encoding
    parameter RED_STATE = 2'b00;      // RED=00
    parameter GREEN_STATE = 2'b01;    // GREEN=01
    parameter YELLOW_STATE = 2'b10;   // YELLOW=10


    reg [1:0] state;          // a 2-bit register to store the current state.
    reg [3:0] counter;        // a 4-bit counter (counts 0-15) to track how long we r in each state.


// Sequential Logic: runs on every clock edge.

    always @(posedge clk or posedge reset) begin     // This block runs every time the clock ticks (rising edge) or when reset is pressed.
        if (reset) begin                             // If reset is pressed, then ....
            state <= RED_STATE;                      // Reset to RED state
            counter <= 0;                            // set counter to 0
        end
        else begin                                   // If reset is not pressed, then ....
            case (state)                             // Check the current state
                RED_STATE: begin                     // If we are in RED state, then ...
                    if (counter == 5) begin          // If we have been here for 6 clock cycles (0-5), then ...
                        state <= GREEN_STATE;         
                        counter <= 0;
                    end
                    else
                        counter <= counter + 1;
                end
                GREEN_STATE: begin                   // If we are in GREEN state, then ...
                    if (counter == 5) begin          // If we have been here for 6 clock cycles (0-5), then ...
                        state <= YELLOW_STATE;
                        counter <= 0;
                    end
                    else
                        counter <= counter + 1;
                end
                YELLOW_STATE: begin                   // If we are in YELLOW state, then ...
                    if (counter == 1) begin           // If we have been here for 2 clock cycles (0-1), then ...
                        state <= RED_STATE;
                        counter <= 0;
                    end
                    else
                       counter <= counter + 1;
                end
            endcase
        end
    end

// Output Logic - combinational
    always @(*) begin                              // always @(*) - combinational block, runs whenever any signal changes.
        red = 0;
        green = 0;
        yellow = 0;
        case (state)
            RED_STATE: red = 1;                     // If we are in RED state, then turn on RED light
            GREEN_STATE: green = 1;                 // If we are in GREEN state, then turn on GREEN light
            YELLOW_STATE: yellow = 1;               // If we are in YELLOW state, then turn on YELLOW light
        endcase
    end

endmodule
