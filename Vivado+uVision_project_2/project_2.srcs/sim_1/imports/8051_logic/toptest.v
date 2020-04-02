// Verilog test fixture created from schematic C:\_umd\_2012-09-01\440_F12\_work\mc8051_design\03\hardware\top.sch - Wed Nov 21 13:19:45 2012

`timescale 1ns / 1ns

module top_top_sch_tb();

	parameter PERIOD = 250;	//4 mHz clock

// Inputs
   reg resetin;
   reg clkin;

// Output
   wire [7:0] P1out;

// Bidirs

// Instantiate the UUT
   top UUT (
		.resetin(resetin), 
		.P1out(P1out), 
		.clkin(clkin)
   );

	initial begin
		resetin = 1;
		clkin = 0;
//		#(1.33*PERIOD) resetin=0; //Input Error : RST on instance top_top_sch_tb.UUT.\XLXI_12.DCM_SP_INST  must be asserted for 3 CLKIN clock cycles.
		#(5.33*PERIOD) resetin=0; //fix for the above
	end
	


   always begin
      clkin = 1'b0;
      #(PERIOD/2) clkin = 1'b1;
      #(PERIOD/2);
   end  
	
endmodule
