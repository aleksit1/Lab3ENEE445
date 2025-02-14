//hex2mem3.c wmh 2018-09-22 : converts HEX-80 .hex generated by Keil into .mem used by Vivado 'updatemem'
// note: Keil .hex file data is presented in random order; we do not change Keil order in our .mem file output
//hex2readmemh02.c wmh 2015-02-17 : not finished -- convert intel .hex ASCII format to stripped down (data-ony) verilog readmemh format for use by verilog $readmemh 
// 	What works fine for the stand-alone test example using the file generated by hex2readmemh01.c fails when we try to use it in the 8051 memory;
// 	google indicates that apparently $readmemh only works according to spec for use at the top level of designs.  
//hex2readmemh01.c wmh 2015-02-17 : convert intel .hex ASCII format to verilog readmemh format for use by verilog $readmemh
//hex2mem2.c wmh 05/30/04 convert intel .hex ASCII format to xilinx .mem format for use by xilinx data2mem FPGA bit editing utility
/////////////////////////////////////////////////////////////////////
// based on 
//                    HEX-BIN  v1.0
//					  by
//					  Neil Hancock
//					  Deakin University Computer Services
//					  Geelong
//					  Vic 3220
//					  Australia
//////////////////////////////////////////////////////////////////////
//  hex2mem2.c : gets input file name from command line (assumes .hex extension), outputs .mem file with same prefix
//	hex2mem1.c : queries user for names of input and output files
// todo: put the address-to-numeric conversion from the original program back in so we can bounds check the address
// 		 against that which is allowed in the xilinx RAMB4
//


#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int aton(unsigned char);
int main(int argc, char *argv[])
{
FILE *infile,*outfile;	
 int count=0,u,t;											//count keeps track of number of bytes written, 
															//u is value of the current line's address field
															//t is byte count of current line
 int i;														//loop counter

 if( argc != 3) {
	printf("\n Usage: \n\t\t hex2mem infile.hex outfile.mem\n");
	printf("where 'infile.hex' is an Intel HEX-80 file generated in Keil uVision, and\n");
	printf(" and 'outfile.mem' will be a Xilinx '.mem' file generated byt the program\n");
	exit(0);
 }

 if((infile=fopen(argv[1],"rb"))==NULL) {
	printf("\ncould not open input file %s\n",argv[1]);
	exit(0);
 }

 if((outfile=fopen(argv[2],"wb"))==NULL) { ;
 	printf("\ncould not open output file %s\n",argv[2]);
	exit(0);
 }

 //write identifier comment into .mem file -- !!omit for stripped down version 
 //fprintf(otfile,"// .mem file generated by hex2readmemh.c wmh 2015-02-17 \n");
 while(1)
    {
	//strip away everything up to and including the next ':' character
	while(fgetc(infile)!=':');			 							 

	//get t= byte count field from an input line (HEX-80 file doesn't have 32-bit address extension mode)
    if((t=16*aton(fgetc(infile))+aton(fgetc(infile)))==0) 	//quit program when byte count is 0
	{
		fclose(infile);
		fclose(outfile);
		exit(0);
	}

	//construct address field for new line of mem file
	fputc('@',outfile);		  	  	  	   	  	  	  	//write '@' delim to mem file !!wmh what about the EOF field mark?
	for(i=0; i<4; i++) fputc( fgetc(infile), outfile); 	//copy addressfield from hex file to mem file
	fputc(0x0A, outfile);	  				 		  	//write newline to outfile
		
	//throw away the '00' delimiter field
	fgetc(infile);																						 
	fgetc(infile);																						

	//copy each data byte from the current line to the output (and ignore the checksum)
	while(t>0)			
	{
		fputc(fgetc(infile),outfile);   //copy 1st character of byte
		fputc(fgetc(infile),outfile);   //     2nd
		fputc(0x0A, outfile);			
		t--;
		count++;
	}	
 }//go up for next line of input

}


 int aton(ch) //convert hex character to numeric
 unsigned char ch;
 {
 int n;
 if(ch<0x3A)n=ch-0x30;
 else n=ch-0x37;
 return n;
 }
