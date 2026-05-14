`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 04/25/2026 03:20:04 AM
// Design Name:
// Module Name: pcsevseg
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


module seven_seg_display(input clk,input [7:0] number,output reg [6:0] seg,output reg [3:0] an);

reg [1:0] refresh = 0;
reg [15:0] counter = 0;

reg [3:0] digit;

wire [3:0] ones;
wire [3:0] tens;
wire [3:0] hundreds;
assign hundreds=number/100;
assign ones=number % 10;
assign tens=(number/10) % 10;



always @(posedge clk) begin

    counter<=counter + 1;

    if(counter==16'd50000) begin
        counter<=0;
        refresh<=refresh+1;
    end

end


always@(*) begin
case(refresh)

2'd0:
begin
    an = 4'b1110;
    digit = ones;
end

2'd1:
begin
    an = 4'b1101;
    digit = tens;
end

2'd2:
begin
    an = 4'b1011;
    digit = hundreds;
end

default:
begin
    an = 4'b1111;
    digit = 0;
end

endcase



    case(digit)

        4'd0: seg = 7'b1000000;
        4'd1: seg = 7'b1111001;
        4'd2: seg = 7'b0100100;
        4'd3: seg = 7'b0110000;
        4'd4: seg = 7'b0011001;
        4'd5: seg = 7'b0010010;
        4'd6: seg = 7'b0000010;
        4'd7: seg = 7'b1111000;
        4'd8: seg = 7'b0000000;
        4'd9: seg = 7'b0010000;

        default: seg = 7'b1111111;

    endcase

end

endmodule
