`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Copyright:  2021
// Engineer: Chris Larsen
// 
// Create Date: 03/09/2021 03:33:00 PM
// Design Name: 
// Module Name: sigmul
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Third version of the significand multiply logic. The code
//              depends on Verilog to generate adder logic. This version of
//              the code should be slightly faster than the previous version
//              because it removes all of the MUXes and by calculating the
//              partial product for every iteration of the loop.
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
  reg [2*NSIG+1:0] p;

  integer i;
  always @(a or b)
  begin
    p = {NSIG+1{b[0]}} & a;

    for (i = 1; i <= NSIG; i = i + 1)
    begin
      p = p + (({NSIG+1{b[i]}} & a) << i);
    end
  end
endmodule
