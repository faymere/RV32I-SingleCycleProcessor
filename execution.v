`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 04/23/2026 09:56:00 PM
// Design Name:
// Module Name: execution
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


 module execution(
    output [15:0] led,
    input [15:0] sw,
    input clk, btnC, btnD, btnU, btnL, btnR,
    output [6:0]seg,
    output [3:0]an
    );
    wire rst, clkout;
    assign rst = btnC;

    // Select frequency between 1/10/100 Hz/100Mhz using switches 15 and 14, hold using sw 13.
    clkdivider cd1(clkout, clk, rst, sw[13], sw[15:14]);

    // Store current instruction (from instructionmem)

    wire [31:0] instruction;

    // Instantiating variables for instruction_decode


    wire rs2_or_imm;//if 0 rs2 else imm.
    wire [3:0] alu_ctrl;// input for ALU module
    wire mem_read; //if 1 load else pass
    wire [2:0]load_type;// LB/LBU/LH/LHU/LW
    wire mem_write;// if 1 store else pass
    wire [1:0]store_type;// SB/SH/SW
    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [4:0] rd;
    wire [31:0] imm;
    wire [1:0]pc_mode;// pc value normal/branch/JAL/JALR
    wire [2:0]branch_type;// if branch, BEQ/BNE/BLT/BGE/BLTU/BGEU
    wire [1:0] rd_value; //value to be return in rd from ALU/mem_read/PC+4/imm
    wire reg_write;

   // Instantiating registers

    reg [31:0] rx [31:0];
    wire [31:0] pc;
    wire [31:0] rs1a, rs2a;
    assign rs1a = rx[rs1];
    assign rs2a = rx[rs2];

    wire [31:0] rs2orimm;
    assign rs2orimm = (rs2_or_imm) ? imm : rs2a; // Store rs2 or imm in variable

    wire [31:0] rdwriteoutalu; // Store the output of ALU
    wire [31:0] rdwriteoutmem; // Store the output of mem

    //Instantiating the modules

    progcount pcmod(pc, clkout, rst, btnU, pc_mode, branch_type, rs1a, rs2a, imm);
    instruct_decode idcmod(instruction, rs2_or_imm, alu_ctrl, mem_read, load_type,
                            mem_write, store_type, rs1, rs2, rd, imm, pc_mode, branch_type,
                            rd_value, reg_write);
    instructionmem immod(instruction, pc);
    ALU alu1(rs1a, rs2orimm, alu_ctrl, rdwriteoutalu);
    datamem dmmod(rdwriteoutmem, clkout, mem_read, mem_write, rs1a+imm, load_type, store_type, rs2a);

    initial rx[0] = 0;
    reg [5:0] rst0;

    always @ (posedge clkout or posedge rst)
    begin
        // Resetting all registers to 0
        if(rst)
        begin
        rst0 = 0;
        rx[0] = 0;
        while(rst0!=31)
        begin rx[rst0+1] = 32'b0; rst0 = rst0 + 1; end
        end
        else begin
        rx[0] = 0; // Register 0 is always 0.

        // Only write to rd if reg_write = 1
        if(rd!=0) begin
        if(instruction[6:0]==7'b0110011 || instruction[6:0]==7'b0010011)
        rx[rd] <= rdwriteoutalu;
        else if(instruction[6:0] == 7'b0000011)
        rx[rd] <= rdwriteoutmem;
        // Branch Instructions
        else if(instruction[6:0] == 7'b1101111 || instruction [6:0] == 7'b1100111)
        rx[rd] <= pc + 4;
        // LUI
        else if(instruction[6:0] == 7'b0110111)
        rx[rd] <= imm;
        // AUIPC
        else if(instruction[6:0] == 7'b0010111)
        rx[rd] <= imm+pc;

    end end
    rx[0] <= 0; // Register 0 is always 0.
    end


    // Use Switches [4:0] to select which register is being displayed
    wire [31:0] regledout;
    assign regledout = rx[sw[4:0]];
    // Use Switch [6] to select whether upper or lower half of the bits is being displayed
    assign led = (sw[6]) ? regledout[31:16]:regledout[15:0];
    //seven segment display to display the instruction number being excetuted.
    wire [7:0] instruction_number;
    assign instruction_number=pc>>2; //division of pc by 4 gives instruction number because pc increments by 4.
    seven_seg_display ssd(clk,instruction_number,seg,an);

    // TestBench

//    wire [15:0] led_tb;
//    reg [15:0] sw_tb;
//    reg clk_tb, btnC_tb, btnU_tb;
//    always #10 clk_tb=~clk_tb;
//    assign clk = clk_tb;
//    assign sw = sw_tb;
//    assign btnC = btnC_tb;
//    assign btnU = btnU_tb;
//    //assign led_tb = led;
//    initial begin
//        clk_tb = 0;
//        sw_tb[13:5] = 0;
//        btnC_tb=1'b1; btnU_tb = 0;
//        $monitor("time=%0t | sw[15]=%b |led=%b",$time,sw[15],led);
//        #3 btnC_tb=1'b0;#30 btnU_tb = 1; #30 btnU_tb = 0;
//        sw_tb[4:0]=5'b0;sw_tb[15:14]=2'b11;

//        #10 sw_tb[4:0]=5'b00000;
//        #10 sw_tb[4:0]=5'b00001;
//        #10 sw_tb[4:0]=5'b00010;
//        #20 sw_tb[4:0]=5'b00011;
//        #10 sw_tb[4:0]=5'b00100;
//    end

endmodule




module execution_tb;
wire [15:0] led;
reg [15:0] sw;
reg clk, btnC, btnD, btnU, btnL, btnR;
execution uut(.led(led),
.sw(sw),
.clk(clk), .btnC(btnC), .btnD(btnD), .btnU(btnU), .btnL(btnL), .btnR(btnR));
initial begin
$monitor("time=%0t | sw[15]=%b |led=%b",$time,sw[15],led);
end
always #10 clk=~clk;
initial begin
clk = 0;
sw[13:5] = 0;
btnC=1'b1;
#3 btnC=1'b0;
sw[4:0]=5'b0;sw[15:14]=2'b11;

#10 sw[4:0]=5'd1;
#10 sw[4:0]=5'd2;
#10 sw[4:0]=5'd3;
#20 sw[4:0]=5'd4;
#10 sw[4:0]=5'd1;

#20 $finish;
end
endmodule


