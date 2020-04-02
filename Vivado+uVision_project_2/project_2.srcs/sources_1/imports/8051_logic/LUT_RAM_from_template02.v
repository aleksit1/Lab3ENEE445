`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:42:12 11/24/2012 
// Design Name: 
// Module Name:    LUT_RAM_from_template 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module LUT_RAM_from_template(DIN,DOUT,ADDR,WE,CLK);

	input [7:0] DIN;
	input [6:0] ADDR;
	input WE;
	input CLK;

	output [7:0] DOUT;
	reg [7:0] DOUT;

   (* RAM_STYLE="{AUTO | DISTRIBUTED | PIPE_DISTRIBUTED}" *)
   reg [7:0] RAMDATA [127:0];
	
   always @(posedge CLK)
      if (WE)
         RAMDATA[ADDR] <= DIN;
		else
			DOUT <= RAMDATA[ADDR];  //so data out changes _after_ the clock
endmodule
