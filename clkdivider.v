`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 04/24/2026 01:33:08 AM
// Design Name:
// Module Name: clkdivider
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////


module clkdivider(
    output reg clkout,
    input clk, rst, hold,
    input [1:0] freqsel
    );
    reg [30:0] count;
    initial begin count = 0; clkout = 0; end
    always @ (posedge clk, posedge rst)
    begin
        if(rst)
        begin count = 0; clkout = 0; end
        else if (~hold) begin
        if (count == 50000000)
        begin clkout = ~clkout; count = 0; end
        else
        case(freqsel)
            0: count = count + 1; // 1 Hz
            1: count = count - (count%10) + 10; // 10 Hz
            2: count = count - (count%100) + 100; // 100 Hz
            3: count = 50000000; // 50 MHz
        endcase
    end end
endmodule
