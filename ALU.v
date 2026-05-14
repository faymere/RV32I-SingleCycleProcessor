`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 04/23/2026 10:57:41 PM
// Design Name:
// Module Name: ALU
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


module ALU(input wire [31:0] A,B,
input wire [3:0] F,
output reg [31:0] C);
always@(*)
begin
case(F)
4'b0000: C=A+B;
4'b0001: C=A-B;
4'b0010: C=A&B;
4'b0011: C=A|B;
4'b0100: C=A^B;
4'b0101: C=A<<B[4:0];
4'b0110: C=A>>B[4:0];
4'b0111: C=$signed(A)>>>B[4:0];
4'b1000: C=A<B?32'b1:32'b0;//SLTU
4'b1001: C=$signed(A) < $signed(B)?32'b1:32'b0;//SLT
default: C=32'b0;
endcase
end
endmodule
