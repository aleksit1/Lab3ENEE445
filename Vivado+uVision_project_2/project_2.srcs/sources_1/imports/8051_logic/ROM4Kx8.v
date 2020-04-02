//ROM4Kx8.v wmh 2018-09-12 : update of example below to replace BRAM4kx8.v and allow use of $readmemh() function for loading initial 8051 test routine
//BRAM2kx8.v wmh 2014-1-16 : example of inferring a BRAM and giving it initial contents
// http://forums.xilinx.com/t5/Synthesis/Distributed-RAM-automatic-inference-in-XST/td-p/221553 (see 1st reply)

`timescale 1ns / 1ps

module BRAM4kx8(
    input clkin,
    input [11:0] Addr,
    output reg [7:0] Dout
    );

	parameter RAM_WIDTH = 8;
   parameter RAM_ADDR_BITS = 12;

   (* RAM_STYLE="BLOCK" *)
   reg [RAM_WIDTH-1:0] BRAM4kx8 [(2**RAM_ADDR_BITS)-1:0];
   reg [RAM_WIDTH-1:0] Adat_reg, Bdat;	//!!wmh: using 'reg' to reflect BRAM; its single port -> Bdat, Badr are not used
   reg [RAM_ADDR_BITS-1:0] Aadr_reg, Badr;		//!!wmh 	""
   reg [RAM_WIDTH-1:0] Adatin;					//!!wmh: its a ROM -> Adatin not used

   //  The following code is only necessary if you wish to initialize the RAM
   //  contents via an external file (use $readmemb for binary data)

   initial begin
//      $readmemh("Blinky.memh", BRAM4kx8); //Value 242245916 found at line 1 is not hexadecimal in call of system task $readmemh.
 //	  $readmemb("Blinky.bin", BRAM4kx8,0,4095); //Value 261108876 found at line 1 is not binary in call of system task $readmemb.
 //     $readmemh("Blinkyrawhex.txt", BRAM4kx8,0,4095); 
	 $readmemh("BLINKY.mem", BRAM4kx8,0,4095);
	end

   always @(posedge clkin) begin
 //     if (enab) begin
 //        if (<write_enableA>) <ram_name>[<addressA>] <= <input_dataA>; 	!!wmh: omit -- this is ROM -> read-only
           Dout <=BRAM4kx8[Addr];
//      end
//    if (<enableB>)  <output_dataB> <= <ram_name>[<addressB>]; 				!!wmh: omit -- this is not dual-port
   end

endmodule
