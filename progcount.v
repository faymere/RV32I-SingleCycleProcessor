`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 04/23/2026 12:19:37 AM
// Design Name:
// Module Name: progcount
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


module progcount(
    output reg [31:0] pc,
    input clk, rst, btnU,
    input [1:0] pc_mode,
    input [2:0] branch_type,
    input [31:0] rs1, rs2,
    input [31:0] imm
    );
    initial pc = 0;
    always @(negedge clk or posedge rst or posedge btnU)
    begin
        if(rst)
        pc <= 0;
        else if(btnU) // Switch to program 2 when btnU is pressed.
        pc<=528;
        else if(pc_mode == 0) // If PC mode is 0, go to next instruction.
        pc <= pc + 4;
        else if(pc_mode == 1) // If PC mode is 1, branch to an insstruction.
        begin
        case(branch_type)
            0: pc <= (rs1==rs2) ? pc + imm : pc + 4; // Branch if Equal, BEQ
            1: pc <= (rs1!=rs2) ? pc + imm : pc + 4; // Branch if Not Equal, BNE
            2: pc <= ($signed(rs1) < $signed(rs2)) ? pc + imm : pc + 4; // Branch if Less Than, BLT
            3: pc <= ($signed(rs1) >= $signed(rs2)) ? pc + imm : pc + 4; // Branch if Greater than or Equal, BGE
            4: pc <= (rs1 < rs2) ? pc + imm : pc + 4; // Branch if Less than, Unsigned; BLTU
            5: pc <= (rs1 >= rs2) ? pc + imm : pc + 4; // Branch if Greater than or Equal, Unsigned; BGEU
        endcase
        end
        else if(pc_mode == 2) // If PC mode is 2, move ahead by the number of locations specified in the immediate.
        pc <= pc + imm;
        else // If PC mode is 3, Jump and Link Register; JALR
        pc <= rs1 + imm;
    end
endmodule

/*

module progcount_tb;
    wire [31:0] pc;
    reg clk, rst, branchyn;
    reg [31:0] branchloc;
    progcount pctb(pc, clk, rst, branchyn, branchloc);
    always #5 clk = ~clk;
    initial
        begin
        clk = 0; rst = 0; branchyn = 0; branchloc = 37;
        #47 branchyn = 1; #10 branchyn = 0;
        #10 rst = 1;
        end
endmodule

*/

