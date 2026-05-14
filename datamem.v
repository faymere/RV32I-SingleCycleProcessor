`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 04/22/2026 11:28:20 PM
// Design Name:
// Module Name: datamem
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


module datamem(
    output reg [31:0] writeout,
    input clk,
    input readyn, writeyn,
    input [31:0] loc,
    input [2:0] load_type,
    input [1:0] store_type,
    input [31:0] datain,
    output [31:0] mem0out
    );
    reg [7:0] mem [31:0];
    assign mem0out = {mem[3], mem[2], mem[1], mem[0]}; // Write out a word from 4 adjacent memory location
    initial begin                   // Enter data here:
        mem[0] = 32'h12;
        mem[1] = 32'h10;
        mem[2] = 32'haa;
        mem[3] = 32'hbc;
        mem[4] = 32'h12;
        mem[5] = 32'h10;
        mem[6] = 32'haa;
        mem[7] = 32'hbc;
        mem[8] = 32'h12;
        mem[9] = 32'h10;
        mem[10] = 32'haa;
        mem[11] = 32'hbc;
    end
    always @ (*)
    begin
        if(clk) begin // Write at posedge of clk
        if(writeyn)
        begin
        case(store_type)    // Store data according to the store type.
            0: mem [loc] = datain[7:0];     // Store one byte
            1: begin                        // Store one half
                    mem[loc+1] = datain[15:8];
                    mem[loc] = datain[7:0];
               end
            2: begin                        // Store one word
                    mem[loc+3] = datain[31:24];
                    mem[loc+2] = datain[23:16];
                    mem[loc+1] = datain[15:8];
                    mem[loc] = datain[7:0];
               end
        endcase
        end
        end
        else if(~clk) begin // Read at negedge of clk
        if(readyn)
        begin
        //writeout = 0;
        case(load_type)
            0: begin                            // Write one signed byte
                writeout[31:24] = mem[loc];
                writeout = writeout >>> 24;
               end
            4: begin
                writeout[7:0] = mem[loc];       // Write one unsigned byte
               end
            1: begin                            // Write one signed half
                writeout[7:0] = mem[loc];
                writeout[31:24] = mem[loc+1];
                writeout = writeout >>> 16;
               end
            5: begin                            // Write one unsigned half
                writeout[15:8] = mem[loc+1];
                writeout[7:0] = mem[loc];
               end
            2: begin                            // Write one word
                writeout[31:24] = mem[loc+3];
                writeout[23:16] = mem[loc + 2];
                writeout[15:8] = mem[loc + 1];
                writeout[7:0] = mem[loc];
               end
         endcase
        end
        end
    end

    // Test Bench


//    reg clk_tb, readyn_tb, writeyn_tb;
//    reg [31:0] loc_tb;
//    reg [2:0] load_type_tb;
//    reg [1:0] store_type_tb;
//    reg [31:0] datain_tb;
//    assign clk = clk_tb; assign readyn = readyn_tb; assign writeyn = writeyn_tb;
//    assign loc = loc_tb; assign load_type = load_type_tb; assign store_type = store_type_tb;
//    assign datain = datain_tb;
//    always #5 clk_tb = ~clk_tb;
//    initial
//        begin
//        clk_tb = 0; load_type_tb = 4; store_type_tb = 2; readyn_tb = 0; writeyn_tb = 0; #3
//        loc_tb = 0; datain_tb = 32'ha0349bcd; readyn_tb = 1; writeyn_tb = 0; #5
//        loc_tb = 4; datain_tb = 32'h44444444; readyn_tb = 1; writeyn_tb = 0;  #5
//        loc_tb = 0; datain_tb = 32'ha0349bcd; readyn_tb = 0; writeyn_tb = 1;  #5
//        loc_tb = 4; datain_tb = 32'haaaaaaaa; readyn_tb = 0;  writeyn_tb = 1; #5
//        loc_tb = 8; datain_tb = 32'h88888888; readyn_tb = 0;  writeyn_tb = 1; #5
//        #1 loc_tb = 12; #1 loc_tb = 16;
//        #3 readyn_tb = 1;  writeyn_tb = 0; #5 loc_tb = 16; #5 loc_tb = 4; #5 loc_tb = 0;
//    end

endmodule



//module datamem_tb;
//    wire [31:0] writeout_tb;
//    reg clk_tb, readyn_tb, writeyn_tb;
//    reg [31:0] loc_tb;
//    reg [2:0] load_type_tb;
//    reg [1:0] store_type_tb;
//    reg [31:0] datain_tb;
//    datamem dm1(writeout_tb, clk_tb, readyn_tb, writeyn_tb, loc_tb, load_type_tb, store_type_tb, datain_tb);
//    always #5 clk_tb = ~clk_tb;
//    initial
//        begin
//        clk_tb = 0; load_type_tb = 4; store_type_tb = 2; readyn_tb = 0; writeyn_tb = 0; #3
//        loc_tb = 0; datain_tb = 32'ha0349bcd; readyn_tb = 1; writeyn_tb = 0; #5
//        loc_tb = 4; datain_tb = 32'h44444444; readyn_tb = 1; writeyn_tb = 0;  #5
//        loc_tb = 0; datain_tb = 32'ha0349bcd; readyn_tb = 0; writeyn_tb = 1;  #5
//        loc_tb = 4; datain_tb = 32'haaaaaaaa; readyn_tb = 0;  writeyn_tb = 1; #10
//        loc_tb = 8; datain_tb = 32'h88888888; readyn_tb = 0;  writeyn_tb = 1; #10
//        #1 loc_tb = 12; #1 loc_tb = 16;
//        #3 readyn_tb = 1;  writeyn_tb = 0; #10 loc_tb = 8; #10 loc_tb = 4; #10 loc_tb = 0;
//    end
//endmodule

