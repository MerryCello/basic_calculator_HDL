`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/29/2021 03:36:28 PM
// Design Name: 
// Module Name: multiplier
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

module Multiplier(
   input [15:0] x, y,
   output [31:0] result
   );
   // Wires nescessary to add the results for the final result
   wire [15:0] p0;
   wire [16:0] p1;
   wire [17:0] p2;
   wire [18:0] p3;
   wire [19:0] p4;
   wire [20:0] p5;
   wire [21:0] p6;
   wire [22:0] p7;
   wire [23:0] p8;
   wire [24:0] p9;
   wire [25:0] p10;
   wire [26:0] p11;
   wire [27:0] p12;
   wire [28:0] p13;
   wire [29:0] p14;
   wire [30:0] p15;

   // Mult x by y
   // As x is multiplied by y from y's LSB to y's MSB,
   // the results are shifted by the position of the
   // bit being ANDed. Then zeros are concatenated,
   // which is what does the shift.
   assign p0[15:0]  =   {16{y[ 0]}} & x;
   assign p1[16:0]  = {({16{y[ 1]}} & x),  1'h0000};
   assign p2[17:0]  = {({16{y[ 2]}} & x),  2'h0000};
   assign p3[18:0]  = {({16{y[ 3]}} & x),  3'h0000};
   assign p4[19:0]  = {({16{y[ 4]}} & x),  4'h0000};
   assign p5[20:0]  = {({16{y[ 5]}} & x),  5'h0000};
   assign p6[21:0]  = {({16{y[ 6]}} & x),  6'h0000};
   assign p7[22:0]  = {({16{y[ 7]}} & x),  7'h0000};
   assign p8[23:0]  = {({16{y[ 8]}} & x),  8'h0000};
   assign p9[24:0]  = {({16{y[ 9]}} & x),  9'h0000};
   assign p10[25:0] = {({16{y[10]}} & x), 10'h0000};
   assign p11[26:0] = {({16{y[11]}} & x), 11'h0000};
   assign p12[27:0] = {({16{y[12]}} & x), 12'h0000};
   assign p13[28:0] = {({16{y[13]}} & x), 13'h0000};
   assign p14[29:0] = {({16{y[14]}} & x), 14'h0000};
   assign p15[30:0] = {({16{y[15]}} & x), 15'h0000};

   assign result = p0 + p1 + p2  + p3  + p4  + p5  + p6  + p7 +
                   p8 + p9 + p10 + p11 + p12 + p13 + p14 + p15;
endmodule








