_readme-Vivado+uVision_project_organization_03.txt wmh 2019-02-11: big picture stuff

This .zip file contains '.\project_2.xpr' which opens in Xilinx Vivado 18.2 Hlx, and  '.\project_2.8051\8051_code\BLINKY.uvproj' which opens in Keil uVision5. 

The Vivado project contains of a number of VHDL modules and other components tied together in a verilog wrapper module 'top_nosch_01.v' which is the content of the Vivado Block Design (BD) 'top_0'. 'top_0' implements an mc8051 microcontroller on the FPGA of the BASYS3 logic board. Vivado is used for the synthesis, implementation, and bitstream generation of the 'top_0' design, which ends with output to the file 'top.bit'.  Vivado can then program top.bit onto the Basys3 board.

The uVision project contains a main() program in BLINKY.c which reads and writes the 8051's ports to  implement 'BLINKY', a Cylon LED scanner.  uVision compiles C and assembly sources in BLINKY.uvproj and generates the file 'BLINKY.hex' containing the binary executable for the mc8051 microcontroller's ROM. The script hex2mem.bat in \project2.8051\tools is then run to generate the file BLINKY.mem which is used by Vivado to initialize contents of the 8051's memory during FPGA compilation. 

The separate Vivado and uVision projects are combined using two different methods -- one for hardware development and the other for software development.

Hardware development:

At the start of hardware development some simple tests of the planned FPGA hardware I/O should be written and compiled in Keil uVision. This will generate 'BLINKY.hex' containing the 8051 test program's binary image. We then run \project_2.8051\tools\hex2mem.bat to translate BLINKY.hex into 'BLINKY.mem' which will be used by Vivado Synthesis. 
  
Next we run Vivado Synthesis to build the initial FPGA structure for our hardware design.  This will include initialization of the contents of the 8051's ROM module 'ROM4Kx8' with the code in BLINKY.mem.  Doing this means that tests we wrote in Keil will run on the FPGA design in Vivado Simulation.  

When our FPGA design synthesizes in Vivado and our software I/O tests are working in Vivado Simulation we proceed to Vivado Implementation and finally, Bitstream generation of 'top.bit' and device programming with it. When top.bit is loaded on the FPGA we should be able to observe on the actual hardware what our design showed us in simulation.  
  
Software development:  
Following Vivado Implementation of our design and the initial run of top.bit on the FPGA the FPGA configuration in top.bit is no longer going to be regenerated in Vivado but will be left as-is unless bugs are discovered in the hardware design. Instead we will develop our software application in Keil uVision and generate new ROM images in BLINKY.hex.  By running '\project_2.8051\tools\update_bit.bat', top.bit is modified to create 'newtop.bit' containing the updated ROM code which is then loaded on the FPGA for testing.  


Note on the 'Fixed' 8051 BRAM4kx8 (8051 ROM) location: 
The 'update_bit.bat' script which inserts new 8051 code into the 8051's ROM in the FPGA .bit file is told to edit it into the BRAM at site RAMB36_X0Y3 by the file '4Kx8_X0Y3_bram.mmi. If Vivado Implementation relocates things then a new .mmi file is required. Currently Implementation is prevented from relocating BRAM4kx8 by \project_2.srcs\constrs_1\new\8051_P0_P1_2.xdc. 
A defect of forcing this type of constraint is that it may make the design inefficient or slow. If the constraint is removed and Implemenation produces a better design, then the new BRAM location can be discovered (ctl-F in the Implementation 'Device' layout window, search for BMEM, highlight ROM/Dout_reg in the 'Find Results' window tht appears, right-click 'Cell Properties' and read off the new Site value. 









 