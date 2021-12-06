`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/23/2021 08:45:47 PM
// Design Name: 
// Module Name: bin2BCD_4dig_tb
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

`define tick 10
module Calc_4fun_tb;
   reg [3:0] test;
   reg clk;
   reg [3:0] row;
   reg [8:0] count;
   wire [3:0] col;
   wire [6:0] seg;
   wire [3:0] an;
   wire [15:0] led;
   
   // UUD
   Calc_4fun #(.SIMULATING(1)) calc(.clk(clk), .kp_row(row), .kp_col(col), .seg(seg), .an(an), .led(led));
   
   always #(`tick/2) clk = ~clk;
   
   always@ (posedge clk) begin
      // Test keypad input and the keyPress and keyPress_deb pulses
      if (test == 4'h1) begin
         if (col == 4'b1011 && count < 8'h0008)                            // t=8
            row = 4'b1011; // pressing 5
         else if (col == 4'b1011 && count < 8'h000F)                       // t=16
            row = 4'b0111; // pressing 2
         else if (col == 4'b1101 && count >= 8'h000F && count < 8'h0018)   // t=24
            row = 4'b1011; // pressing 6
         else
            row = 4'b1111;
      end
      // test what is displayed when it should be display
      else if (test == 4'h2) begin
         if      (col == 4'b1101 && count < 8'h0009)                       // t=8
            row = 4'b0111; // pressing 3
         else if (col == 4'b1110 && count >= 8'h0009 && count < 8'h0018)   // t=16
            row = 4'b1110; // pressing D (+)
         else if (col == 4'b1101 && count >= 8'h0018 && count < 8'h0020)   // t=24
            row = 4'b0111; // pressing 3
         else if (col == 4'b1101 && count >= 8'h0020 && count < 8'h0028)   // t=32
            row = 4'b1110; // pressing E (=)
         else
            row = 4'b1111;
      end
      count = count + 1'b1;
   end
   
   initial begin test = 4'h2; clk = 0; row = 4'b1111; count = 8'h0000;
      #(`tick*48 + `tick/2) $finish;
   end
endmodule








