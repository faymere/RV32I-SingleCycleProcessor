module instruct_decode (input wire [31:0] instruct,
    output reg rs2_or_imm,//if 0 rs2 else imm.
    output reg [3:0] alu_ctrl,// input for ALU module
    output reg mem_read,//if 1 load else pass
    output reg [2:0]load_type,// LB/LBU/LH/LHU/LW
    output reg mem_write,// if 1 store else pass
    output reg [1:0]store_type,// SB/SH/SW
    output reg [4:0] rs1,
    output reg [4:0] rs2,
    output reg [4:0] rd,
    output reg [31:0] imm,
    output reg [1:0]pc,// pc value normal/branch/JAL/JALR
    output reg [2:0]branch_type,// if branch, BEQ/BNE/BLT/BGE/BLTU/BGEU
    output reg [1:0] rd_value,//value to be return in rd from ALU/mem_read/PC+4/imm
    output reg reg_write
);

always@(instruct)
begin
// default
alu_ctrl=4'b0000;
mem_read=1'b0;
mem_write=1'b0;
rs2_or_imm=1'b0;
pc=2'b00;
reg_write=1'b0;
store_type=2'b00;
load_type=3'b000;
rd_value=2'b00;
branch_type=3'b000;

rs1 = instruct[19:15];
rs2 = instruct[24:20];
rd  = instruct[11:7];
imm = 32'b0;
case(instruct[6:0])
7'b0110011: begin
            reg_write=1'b1;
            rd_value=2'b00;// value from ALU
            case(instruct[14:12])
            3'b000:begin
                   case(instruct[31:25])
                   7'b0000000:alu_ctrl=4'b0000;//add
                   7'b0100000:alu_ctrl=4'b0001;//subtract
                   endcase
                   end
            3'b001:alu_ctrl=4'b0101;
            3'b010:alu_ctrl=4'b1001; //SLT
            3'b011:alu_ctrl=4'b1000; //SLTU
            3'b100:alu_ctrl=4'b0100;
            3'b101:begin
                   case(instruct[31:25])
                   7'b0000000:alu_ctrl=4'b0110;
                   7'b0100000:alu_ctrl=4'b0111;
                   endcase
                   end
            3'b110:alu_ctrl=4'b0011;
            3'b111:alu_ctrl=4'b0010;
            endcase
            end

                     //R
7'b0010011:begin
           reg_write=1'b1;
           rd_value=2'b00;// from ALU
           rs2_or_imm=1'b1;
           imm={{20{instruct[31]}},instruct[31:20]};//sign extended immediate
           case(instruct[14:12])
           3'b000:alu_ctrl=4'b0000;
           3'b010:alu_ctrl=4'b1001;//SLTI
           3'b011:alu_ctrl=4'b1000;//SLTIU
           3'b100:alu_ctrl=4'b0100;
           3'b110:alu_ctrl=4'b0011;
           3'b111:alu_ctrl=4'b0010;
           3'b001:alu_ctrl=4'b0101;
           3'b101:begin
                  case(instruct[31:25])
                  7'b0000000:alu_ctrl=4'b0110;
                  7'b0100000:alu_ctrl=4'b0111;
                  endcase
                  end
           endcase
           end
                    //I(immediate)
7'b0000011:begin
           mem_read=1'b1;
           reg_write=1'b1;
           rs2_or_imm=1'b1;
           rd_value=2'b01;//data from memory
           alu_ctrl=4'b0000;// rd=memory[rs1+imm]
           imm={{20{instruct[31]}},instruct[31:20]};//sign extended immediate
           case(instruct[14:12])
           3'b000:load_type=3'b000;//LB
           3'b001:load_type=3'b001;//LH
           3'b010:load_type=3'b010;//LW
           3'b100:load_type=3'b100;//LBU
           3'b101:load_type=3'b101;//LHU
           endcase
           end
               //I(load)
7'b0100011:begin
           mem_write=1'b1;
           rs2_or_imm=1'b1;
           imm={{20{instruct[31]}},instruct[31:25],instruct[11:7]};//sign extended immediate
           case(instruct[14:12])
           3'b000:begin
                  alu_ctrl=4'b0000;
                  store_type=2'b00; //SB
                  end
           3'b001:begin
                  alu_ctrl=4'b0000;
                  store_type=2'b01; //SH
                  end
           3'b010:begin
                  alu_ctrl=4'b0000;
                  store_type=2'b10; //SW
                  end
            endcase
            end   //S(store)
7'b1100011:begin
           pc=2'b01;
           imm={{20{instruct[31]}},instruct[7],instruct[30:25],instruct[11:8],1'b0};//last bit is always 0 as memory address is always a multiple of 2.
           case(instruct[14:12])
           3'b000:begin
                  alu_ctrl=4'b0001;
                  branch_type=3'b000;//BEQ

                  end
           3'b001:begin
                  alu_ctrl=4'b0001;

                  branch_type=3'b001;//BNE
                  end
           3'b100:begin
                  alu_ctrl=4'b1001;
                  branch_type=3'b010; //BLT

                  end
           3'b101:begin
                  alu_ctrl=4'b1001;
                  branch_type=3'b011;//BGE

                  end
           3'b110:begin
                  alu_ctrl=4'b1000;
                  branch_type=3'b100;//BLTU

                  end
           3'b111:begin
                  alu_ctrl=4'b1000;
                  branch_type=3'b101; //BGEU

                  end
            endcase
            end         //Branches
7'b0110111:begin
           imm={instruct[31:12],12'b0};// first 20 bits are from instruct rest 12 bits are 0.
           reg_write=1'b1;
           rd_value=2'b11;//immediate
           end         //LUI(U)
7'b0010111:begin
           imm={instruct[31:12],12'b0};
           reg_write=1'b1;
           rd_value=2'b00;//ALU result
           end         //AUIPC(U)
7'b1101111:begin
           reg_write=1'b1;
           rd_value=2'b10;//pc+4
           pc=2'b10;
           imm={{12{instruct[31]}},instruct[19:12],instruct[20],instruct[30:21],1'b0};
           end    //JAL(J)
7'b1100111:begin
           reg_write=1'b1;
           rd_value=2'b10;
           pc=2'b11;
           rs2_or_imm=1'b1;
           imm={{20{instruct[31]}},instruct[31:20]};
           end          //JALR(I)

endcase
end
endmodule

