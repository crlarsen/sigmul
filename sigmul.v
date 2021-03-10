`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Copyright:  2021
// Engineer: Chris Larsen
// 
// Create Date: 03/09/2021 03:38:00 PM
// Design Name: 
// Module Name: sigmul
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Fourth version of the significand multiply logic. The code
//              depends on Verilog to generate adder logic. This version of
//              the code should be slightly faster than the previous version
//              because reduces the numbers of bits which need to be added at
//              each iteration from 2*NSIG+2 to just NSIG+1 creating an NSIG+2
//              bit wider result.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module sigmul(a, b, p);
  parameter NSIG = 10;

  input [NSIG:0] a, b;
  output [2*NSIG+1:0] p;

  wire [NSIG:0] rt[NSIG-1:0]; // Running total of partial products
  
  assign {rt[0], p[0]} = {NSIG+1{b[0]}} & a;
  
  genvar i;
  generate
    for (i = 1; i < NSIG; i = i + 1)
    begin
      assign {rt[i], p[i]} = rt[i-1] + ({NSIG+1{b[i]}} & a);
    end
  endgenerate
  
  assign p[2*NSIG+1:NSIG] = rt[NSIG-1] + ({NSIG+1{b[NSIG]}} & a);
endmodule
