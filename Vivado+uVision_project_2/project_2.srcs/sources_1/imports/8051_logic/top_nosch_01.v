//top_nosch01.v -- verison eliminating all by P0 and P1 pins 
//top_nosch01.v -- derived from top.vf for replacing top.sch
// 
////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____ 
//  /   /\/   / 
// /___/  \  /    Vendor: Xilinx 
// \   \   \/     Version : 14.7
//  \   \         Application : sch2hdl
//  /   /         Filename : top.vf
// /___/   /\     Timestamp : 09/20/2017 09:23:45
// \   \  /  \ 
//  \___\/\___\ 
//
//Command: sch2hdl -intstyle ise -family spartan3e -verilog C:/_umd/_2017-09-01/445_F17/_labs/lab2/8051Cylon_Ncount/8051Cylon_Ncount/8051Cylon_3count/8051_logic/top.vf -w C:/_umd/_2017-09-01/445_F17/_labs/lab2/8051Cylon_Ncount/8051Cylon_Ncount/8051Cylon_3count/8051_logic/top.sch
//Design Name: top
//Device: spartan3e
//Purpose:
//    This verilog netlist is translated from an ECS schematic.It can be 
//    synthesized and simulated, but it should not be modified. 
//
`timescale 1ns / 1ps

module top(clkin, 
           resetin,
				P0in,P1in,  //P2in,P3in,
				P0out,P1out, //P2out,P3out,
				// Tin0,   //Tin1,
				// INT0,INT1,
				RXDin,TXDout
				//XWR,XDIN,XDOUT,XADR
	);

    input clkin;
    input resetin;

	 input [7:0] P0in;	 
	 input [7:0] P1in;
//	 output cam_clk;
//	 input cam_data;
//	 input [7:0] P2in;
//	 input [7:0] P3in;
	 
   output [7:0] P0out;
   output [7:0] P1out;
//   output [7:0] P2out;
//   output [7:0] P3out;
	
//   input [0:0] Tin0;
 //  input [0:0] Tin1;
	
//	input INT0;
//	input INT1;
	
//	input [7:0] XDIN;
//	output [7:0] XDOUT;
//	output [15:0] XADR;
//	output XWR;
	
	input [0:0] RXDin;
//	output [0:0] RXDWRout;
	output [0:0] TXDout;
//	output [0:0] TXDout;
	
    assign clkout = clkin;	
   wire clk10mHz;
   wire [6:0] ram_addr;
   wire [7:0] ram_datain;
   wire [7:0] ram_dataout;
   wire [15:0] ROMaddr;
   wire [7:0] ROMdata;
   wire RAM_WR;
   wire RAM_EN;
   wire RAM_WE;
   wire clk_div;
   
   ClkDivider clk (.clock_in(clkin),
                   .clock_out(clk_div)
   );
   
   mc8051_core  MC8051 (
                       .all_rxd_i(RXDin[0]), 
                       .all_t0_i(), 
                       .all_t1_i(), 
                       .clk(clk_div), 
                       .datax_i(), 
                       .int0_i(), 
                       .int1_i(), 
                       .p0_i(P0in[7:0]), 
                       .p1_i(P1in[7:0]), 
                       .p2_i(), 
                       .p3_i(), 
                       .ram_data_i(ram_dataout[7:0]), 
                       .reset(resetin), 
                       .rom_data_i(ROMdata[7:0]), 
                       .adrx_o(), 
                       .all_rxdwr_o(), 
                       .all_rxd_o(), 
                       .all_txd_o(TXDout[0]), 
                       .datax_o(), 
                       .p0_o(P0out[7:0]), 
                       .p1_o(P1out[7:0]), 
                       .p2_o(), 
                       .p3_o(), 
                       .ram_adr_o(ram_addr[6:0]), 
                       .ram_data_o(ram_datain[7:0]), 
                       .ram_en_o(RAM_EN), 
                       .ram_wr_o(RAM_WR), 
                       .rom_adr_o(ROMaddr[15:0]), 
                       .wrx_o()
  );
   AND2  XLXI_5 (.I0(RAM_EN), 
                .I1(RAM_WR), 
                .O(RAM_WE));
   LUT_RAM_from_template  RAM (.ADDR(ram_addr[6:0]), 
                                 .CLK(clk_div), 
                                 .DIN(ram_datain[7:0]), 
                                 .WE(RAM_WE), 
                                 .DOUT(ram_dataout[7:0]));
   BRAM4kx8  ROM (.Addr(ROMaddr[11:0]), 
                     .clkin(clk_div), 
                     .Dout(ROMdata[7:0]));
//   wiz_clkgen  CLKGEN (.CLKIN_IN(clkin), 
//                       .RST_IN(resetin), 
//                       .CLKDV_OUT(clk10mHz), 
//                       .CLKIN_IBUFG_OUT(), 
//                       .CLK0_OUT(), 
//                       .LOCKED_OUT());
endmodule
