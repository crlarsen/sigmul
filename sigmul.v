`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Copyright:  2021
// Engineer: Chris Larsen
// 
// Create Date: 03/09/2021 03:50:00 PM
// Design Name: 
// Module Name: sigmul
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Fifth version of the significand multiply logic. The code no
//              longer depends on Verilog to generate adder logic. This
//              version is probably slower than the previous version. This
//              loss of speed is to be expected at this stage.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module hadder(a, b, s, c);
  input a, b;
  output s, c;

  assign s = a ^ b;
  assign c = a & b;
endmodule

module fadder(a, b, Cin, s, Cout);
  input a, b, Cin;
  output s, Cout;

  assign s = a ^ b ^ Cin;
  assign Cout = (a & b) | (a & Cin) | (b & Cin);
endmodule

module adder(a, b, s);
  parameter NSIG = 10;
  input [NSIG:0] a, b;
  output [NSIG+1:0] s;

  wire [NSIG:1] c;

  hadder H(a[0], b[0], s[0], c[1]);

  genvar i;
  generate
    for (i = 1; i < NSIG; i = i + 1)
      begin
        fadder Fi(a[i], b[i], c[i], s[i], c[i+1]);
      end
  endgenerate

  fadder Ffinal(a[NSIG], b[NSIG], c[NSIG], s[NSIG], s[NSIG+1]);
endmodule

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
      adder #(NSIG) si(rt[i-1], ({NSIG+1{b[i]}} & a), {rt[i], p[i]});
    end
  endgenerate

  adder #(NSIG) sFinal(rt[NSIG-1], ({NSIG+1{b[NSIG]}} & a), p[2*NSIG+1:NSIG]);
endmodule
