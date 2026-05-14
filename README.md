# RV32I Single-Cycle Processor
A single-cycle processor implemented in Verilog HDL, supporting 37 of the 40 base RV32I instructions. This implementation excludes the 'FENCE', 'ECALL' and 'EBREAK' system instructions.
Includes a bubble sort program and a basic functionality testing program out of the box, with user-friendly, hexadecimal instruction inputs for running different programs, and a few additional features for monitoring processor execution and easier debugging. 
## Table of Contents
- [Key Features](#key-features)   
- [Additional Features](#additional-features)      
- [Supported Instructions](#supported-instructions)
- [Top Module Description](#top-module-description)
- [Technologies Used](#technologies-used)
- [Hardware Requirements](#hardware-requirements)
- [Installation](#installation)     
- [Team Members](#team-members)   


## Key Features
* Single-Cycle CPU architecture
* Supports all six RV32I instrcution formats: R-type, I-type, S-type, U-type, B-type and J-type.
* Implemented in Verilog HDL
* Simulated and Verified on Vivado

## Additional Features
* Adjustable Clock Speed between 1Hz, 10Hz, 100Hz and 50 MHz, with hold switch for pausing execution.
* Provision to view the values of any of the 32 registers on the on-board LEDs.
* Display of the current instruction number being executed on the on-board seven segment display.
* Supports multiple programs, with the provision to switch between them using the push buttons on board.

## Supported Instructions

Instructions supported by this implementation:

| **Instruction Type** | **Instructions**                                                                 |
|-----------------------|---------------------------------------------------------------------------------|
| **R-Type**            | `add`, `sub`, `sll`, `slt`, `sltu`, `xor`, `srl`, `sra`, `or`, `and`           |
| **I-Type**            | `addi`, `slti`, `sltiu`, `xori`, `ori`, `andi`, `lb`, `lh`, `lw`, `lbu`, `lhu`.`slli`,`srli`,`srai` |
| **S-Type**            | `sb`, `sh`, `sw`                                                              |
| **B-Type**            | `beq`, `bne`, `blt`, `bge`, `bltu`, `bgeu`                                    |
| **U-Type**            | `lui`, `auipc`                                                                |
| **J-Type**            | `jal`, `jalr`                                                                 |

## Top Module Description
Port Description of execution.v module

| S.No | Port | Type | Width | Description |
|------|------|------|--------|-------------|
| 1 | `led` | Output | 16 bits | The 16 on-board LEDs, used for displaying the value of the register selected using switches 0 (LSB) through 4 (MSB).<br><br>**Example:** In order to see the value of `rs19`, the switches must be set as:<br>`sw[4:0] = {1,0,0,1,1}` |
| 2 | `clk` | Input | 1 bit | Clock input. |
| 3 | `btnC` | Input | 1 bit | Reset input. |
| 4 | `btnU` | Input | 1 bit | Button input used to switch to Program 2 when pressed. |
| 5 | `sw` | Input | 16 bits | **Onboard switches usage:**<br>• `sw[4:0]` → Register selection (32 registers = 2⁵)<br>• `sw[6]` → Display upper half (ON) / lower half (OFF)<br>• `sw[13]` → Hold if ON, continue if OFF<br>• `sw[15:14]` → Clock speed selection:<br>&nbsp;&nbsp;&nbsp;&nbsp;`00` = 1 Hz<br>&nbsp;&nbsp;&nbsp;&nbsp;`01` = 10 Hz<br>&nbsp;&nbsp;&nbsp;&nbsp;`10` = 100 Hz<br>&nbsp;&nbsp;&nbsp;&nbsp;`11` = 50 MHz |
| 6 | `seg` | Output | 7 bits | Seven-segment display cathodes. |
| 7 | `an` | Output | 4 bits | Seven-segment display anodes. |

## Technologies Used
* Language: Verilog HDL
* Software: Vivado 2025.2  
* Target Board: Basys 3 (Artix-7 FPGA)
* Simulation: Vivado's built-in XSIM

## Hardware Requirements
*  Basys 3 FPGA Development Board
*  Micro USB cable for programming
*  PC with AMD Vivado 2025.2 or newer installed

## Installation
Follow these steps to simulate or deploy the processor on your FPGA board:
1. Clone this repository:
   ```  bash
   git clone https://github.com/faymere/RV32I-SingleCycleProcessor.git
   cd RV32I-SingleCycleProcessor
   ```
2. Open Vivado and create a new project.
3. Add the Verilog source files from the src/ directory.
4. Set the target FPGA to xc7a35tcpg236-1 (for Basys 3).
5. Add the provided constraints file (.xdc)
6. Run synthesis, implementation, and generate bitstream.
7. Use the Hardware Manager to program the Basys 3 board.


## Team Members
* [Julis Joy](https://github.com/faymere)    
* [Nikhilesh Kurapati](https://github.com/au513)

## References 
* Digital Design and Computer Architecture: MIPS Edition by Sarah L. Harris and David Harris.
* Basic Computer Architecture by Smruti R. Sarangi
- [RISC-V ISA Specification](https://riscv.org/technical/specifications/)
- [Venus RISC-V Simulator](https://venus.cs61c.org/) – used for assembly to machine code conversion




