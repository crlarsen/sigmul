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
// Description: First version of the significand multiply logic. The code
//              depends on Verilog to generate adder logic. This version of
//              the code uses MUXes to control which of 11 possible partial
//              products need to be added to get the final result.
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
    p = 0;
    
    for (i = 0; i <= NSIG; i = i + 1)
    begin
      if (b[i] == 1'b1)
        p = p + (a << i);
    end
  end
endmodule
