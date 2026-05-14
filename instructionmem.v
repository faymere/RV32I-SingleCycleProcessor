module instructionmem(
    output [31:0] writeout,
    input [31:0] loc
);

reg [7:0] mem [1023:0]; // 1024 bytes of storage (1 KiB)

assign writeout = {mem[loc+3],mem[loc+2],mem[loc+1],mem[loc]}; // Write out outputs 4 bytes (1 word) in each go.

integer i;
integer addr;

reg [31:0] instr [0:138]; // 138 4-bit instructions.

initial begin

for(i=0;i<1024;i=i+1) // Initialize all memory bytes to 0.
    mem[i]=8'h00;

// Bubble Sort Program

// machine code list
instr[0]=32'h02D00093;
instr[1]=32'h00C00113;
instr[2]=32'h04E00193;
instr[3]=32'h00300213;
instr[4]=32'h03200293;
instr[5]=32'h01500313;
instr[6]=32'h00112533;
instr[7]=32'h00050863;
instr[8]=32'h000083B3;
instr[9]=32'h000100B3;
instr[10]=32'h00038133;
instr[11]=32'h0021A533;
instr[12]=32'h00050863;
instr[13]=32'h000103B3;
instr[14]=32'h00018133;
instr[15]=32'h000381B3;
instr[16]=32'h00322533;
instr[17]=32'h00050863;
instr[18]=32'h000183B3;
instr[19]=32'h000201B3;
instr[20]=32'h00038233;
instr[21]=32'h0042A533;
instr[22]=32'h00050863;
instr[23]=32'h000203B3;
instr[24]=32'h00028233;
instr[25]=32'h000382B3;
instr[26]=32'h00532533;
instr[27]=32'h00050863;
instr[28]=32'h000283B3;
instr[29]=32'h000302B3;
instr[30]=32'h00038333;

// pass 2
instr[31]=32'h00112533;
instr[32]=32'h00050863;
instr[33]=32'h000083B3;
instr[34]=32'h000100B3;
instr[35]=32'h00038133;
instr[36]=32'h0021A533;
instr[37]=32'h00050863;
instr[38]=32'h000103B3;
instr[39]=32'h00018133;
instr[40]=32'h000381B3;
instr[41]=32'h00322533;
instr[42]=32'h00050863;
instr[43]=32'h000183B3;
instr[44]=32'h000201B3;
instr[45]=32'h00038233;
instr[46]=32'h0042A533;
instr[47]=32'h00050863;
instr[48]=32'h000203B3;
instr[49]=32'h00028233;
instr[50]=32'h000382B3;
instr[51]=32'h00532533;
instr[52]=32'h00050863;
instr[53]=32'h000283B3;
instr[54]=32'h000302B3;
instr[55]=32'h00038333;

// pass 3
instr[56]=32'h00112533;
instr[57]=32'h00050863;
instr[58]=32'h000083B3;
instr[59]=32'h000100B3;
instr[60]=32'h00038133;
instr[61]=32'h0021A533;
instr[62]=32'h00050863;
instr[63]=32'h000103B3;
instr[64]=32'h00018133;
instr[65]=32'h000381B3;
instr[66]=32'h00322533;
instr[67]=32'h00050863;
instr[68]=32'h000183B3;
instr[69]=32'h000201B3;
instr[70]=32'h00038233;
instr[71]=32'h0042A533;
instr[72]=32'h00050863;
instr[73]=32'h000203B3;
instr[74]=32'h00028233;
instr[75]=32'h000382B3;
instr[76]=32'h00532533;
instr[77]=32'h00050863;
instr[78]=32'h000283B3;
instr[79]=32'h000302B3;
instr[80]=32'h00038333;

// pass 4
instr[81]=32'h00112533;
instr[82]=32'h00050863;
instr[83]=32'h000083B3;
instr[84]=32'h000100B3;
instr[85]=32'h00038133;
instr[86]=32'h0021A533;
instr[87]=32'h00050863;
instr[88]=32'h000103B3;
instr[89]=32'h00018133;
instr[90]=32'h000381B3;
instr[91]=32'h00322533;
instr[92]=32'h00050863;
instr[93]=32'h000183B3;
instr[94]=32'h000201B3;
instr[95]=32'h00038233;
instr[96]=32'h0042A533;
instr[97]=32'h00050863;
instr[98]=32'h000203B3;
instr[99]=32'h00028233;
instr[100]=32'h000382B3;
instr[101]=32'h00532533;
instr[102]=32'h00050863;
instr[103]=32'h000283B3;
instr[104]=32'h000302B3;
instr[105]=32'h00038333;

// pass 5
instr[106]=32'h00112533;
instr[107]=32'h00050863;
instr[108]=32'h000083B3;
instr[109]=32'h000100B3;
instr[110]=32'h00038133;
instr[111]=32'h0021A533;
instr[112]=32'h00050863;
instr[113]=32'h000103B3;
instr[114]=32'h00018133;
instr[115]=32'h000381B3;
instr[116]=32'h00322533;
instr[117]=32'h00050863;
instr[118]=32'h000183B3;
instr[119]=32'h000201B3;
instr[120]=32'h00038233;
instr[121]=32'h0042A533;
instr[122]=32'h00050863;
instr[123]=32'h000203B3;
instr[124]=32'h00028233;
instr[125]=32'h000382B3;
instr[126]=32'h00532533;
instr[127]=32'h00050863;
instr[128]=32'h000283B3;
instr[129]=32'h000302B3;
instr[130]=32'h00038333;
instr[131]=32'h0000006F;

// Program 2, checking basic functions
instr[132]=32'h00500093; // addi x1, x0, 5
instr[133]=32'h00A00113; // addi x2, x0, 10
instr[134]=32'h002081B3; // add x3, x1, x2
instr[135]=32'h00302023; // sw x3, 0x(0)
instr[136]=32'h00002203; // lw x4, 0(x0)
instr[137]=32'h00418263; // beq x3, x4, done
instr[138]=32'h0000006F; // jal x0, done

// store into byte memory (Convert 32 bit instructions to 8 bit memory bytes.
for(i=0;i<139;i=i+1) begin

    addr = i*4;

    mem[addr]   = instr[i][7:0];
    mem[addr+1] = instr[i][15:8];
    mem[addr+2] = instr[i][23:16];
    mem[addr+3] = instr[i][31:24];

end

end

endmodule
