`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2021 04:07:07 PM
// Design Name: 
// Module Name: calc_4fun_top
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

/*********************************************************************************
 * This module is necessary to wrap the main Calc_4fun module so we can test it.
 * Without this wrapper issues arise with the inout [7:0] JA, which the simulator
 * does not know how to interpret.
 ********************************************************************************/
module calc_4fun_top(
      input clk,
      inout [7:0] JA,
      output [6:0] seg,
      output [3:0] an,
      output dp,
      output [15:0] led
   );
    
    Calc_4fun calc(.clk(clk), .kp_row(JA[7:4]), .kp_col(JA[3:0]), .seg(seg), .an(an), .dp(dp), .led(led));
    
endmodule
