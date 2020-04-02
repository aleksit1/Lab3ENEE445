`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/05/2020 01:59:00 PM
// Design Name: 
// Module Name: ClkDivider
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////     
 

module ClkDivider(clock_in,clock_out
    );
    input clock_in; // input clock on FPGA
    output clock_out; // output clock after dividing the input clock by divisor
    reg[3:0] counter=4'b0000;
    
    always @(posedge clock_in) begin
         counter <= counter + 4'b0001;
         if(counter == 4'b1000) begin
            counter <= 4'b0000;
         end
    end
    assign clock_out = (counter == 4'b0000);
endmodule
