# RV32I - Single Cycle Processor
A single-cycle processor implemented in VerilogHDL, supporting 37 of the 40 base RV32I instructions. This implemnetation excludes FENCE, ECALL AND EBREAK system instructions.
## Table of Contents
- [Key Features](#key-features)   
- [Additional Features](#additional-features)      
- [Technologies Used](#technologies-used)   
- [Hardware Requirements](#hardware-requirements)      
- [Team Members](#team-members)   


## Key Features
* Single-Cycle CPU architecture
* Support all six RV32I instrcutions formats: R-type, I-type, S-type, U-type, B-type and J-type.
* Implemented in VerilogHDL
* Simulated and Verified on Vivado

## Additional Features
* Adjustable Clock Speed between 1Hz, 10Hz, 100Hz and 50 MHz, with hold switch for pausing execution.
* Provision to view the values of any of the 32 registers on the on-board LEDs.
* Display of the current instruction number being executed on the on-board seven segment display.
* Supports multiple programs, with the provision to switch between them using the push buttons on board.

## Technologies Used
* Language: Verilog HDL
* Software: Vivado  
* Target Board: Basys 3 (Artix-7 FPGA)
* Simulation: Vivado's built-in XSIM

## Hardware Requirements
*  Basys 3 FPGA Development Board
*  Micro USB cable for programming
*  PC with AMD Vivado 2023.2 or newer installed

## Team Members
* [Julis Joy](https://github.com/faymere)    
* [Nikhilesh Kurapati](https://github.com/au513)  

