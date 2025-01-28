module top (CLOCK_50, SW, KEY, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, LEDR);

    input CLOCK_50;             // DE-series 50 MHz clock signal
    input  [9:0] SW;        // DE-series switches
    input  [3:0] KEY;       // DE-series pushbuttons

    output  [6:0] HEX0;     // DE-series HEX displays
    output  [6:0] HEX1;
    output  [6:0] HEX2;
    output  [6:0] HEX3;
    output  [6:0] HEX4;
    output  [6:0] HEX5;

    output  [9:0] LEDR;     // DE-series LEDs   

    part2 U1 (KEY[1:0], SW, LEDR);

endmodule

