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

`define tick 7
module Calc_4fun_tb;
   reg [3:0] test;
   reg clk;
   reg [3:0] row;
   reg [8:0] t;
   wire [3:0] col;
   wire [6:0] seg;
   wire [3:0] an;
   wire [15:0] led;
   
   // UUD
   Calc_4fun #(.SIMULATING(1)) calc(.clk(clk), .kp_row(row), .kp_col(col), .seg(seg), .an(an), .led(led));
   
   always #(`tick/2) clk = ~clk;
   
   always@ (posedge clk) begin
   
      // TEST 1: Test keypad input and the keyPress and keyPress_deb pulses
      if (test == 4'h1) begin
         if (col == 4'b1011 && t < 8'h0008)                        // t=8
            row = 4'b1011; // pressing 5
         else if (col == 4'b1011 && t < 8'h000F)                   // t=16
            row = 4'b0111; // pressing 2
         else if (col == 4'b1101 && t >= 8'h000F && t < 8'h0018)   // t=24
            row = 4'b1011; // pressing 6
         else
            row = 4'b1111;
      end
      
      // TEST 2: test what is displayed when it should be display
      else if (test == 4'h2) begin
         if      (col == 4'b1101 && t < 8'h0009) begin                  //  0 < t <  9
            row = 4'b0111; // pressing 3
            $display("%d Pressing 3", t);
         end
         else if (col == 4'b1110 && t >= 8'h0009 && t < 8'h0018) begin  //  9 < t < 24
            row = 4'b1110; // pressing D (+)
            $display("%d Pressing +", t);
         end
         else if (col == 4'b1101 && t >= 8'h0018 && t < 8'h0020) begin  // 24 < t < 32
            row = 4'b0111; // pressing 3
            $display("%d Pressing 3", t);
         end
         else if (col == 4'b1101 && t >= 8'h0020 && t < 8'h0028) begin  // 32 < t < 40
            row = 4'b1110; // pressing E (=)
            $display("%d Pressing =", t);
         end
         else if (col == 4'b1110 && t >= 8'h0028 && t < 8'h0038) begin  // 40 < t < 56
            row = 4'b1011; // pressing B (*)
            $display("%d Pressing *", t);
         end
         else if (col == 4'b1101 && t >= 8'h0038 && t < 8'h0040) begin  // 56 < t < 64
            row = 4'b1011; // pressing 6
            $display("%d Pressing 6", t);
         end
         else if (col == 4'b1101 && t >= 8'h0048 && t < 8'h0050) begin  // 64 < t < 72
            row = 4'b1110; // pressing E (=)
            $display("%d: Pressing =", t);
         end
         else if (col == 4'b1011 && t >= 8'h0050 && t < 8'h0058) begin  // 72 < t < 80
            row = 4'b0111; // pressing 2
            $display("%d: Pressing 2", t);
         end
         else if (col == 4'b0111 && t >= 8'h0058 && t < 8'h0060) begin  // 88 < t < 96
            row = 4'b1011; // pressing 4
            $display("%d: Pressing 4", t);
         end
         else if (col == 4'b1110 && t >= 8'h0060 && t < 8'h0070) begin  // 96 < t < 112
            row = 4'b0111; // pressing A (/)
            $display("%d: Pressing /", t);
         end
         else if (col == 4'b1011 && t >= 8'h0070 && t < 8'h0078) begin  // 112 < t < 120
            row = 4'b0111; // pressing 2
            $display("%d: Pressing 2", t);
         end
         else if (col == 4'b1101 && t >= 8'h0078 && t < 8'h0080) begin  // 120 < t < 128
            row = 4'b1110; // pressing E (=)
            $display("%d: Pressing =", t);
         end
         else
            row = 4'b1111;
      end
      
      // increment time
      t = t + 1'b1;
   end
   
   initial begin test = 4'h2; clk = 0; row = 4'b1111; t = 8'h0000;
      #(`tick*1000 + `tick/2) $finish;
   end
endmodule








