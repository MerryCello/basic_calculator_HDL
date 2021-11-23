`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/22/2021 03:56:03 PM
// Design Name: 
// Module Name: calc_4fun
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


module calc_4fun(
    input clk,          // 100 MHz clock
    input [7:0] JB,     // Keyboard KYPD
    output [6:0] seg,   // 7 segment stuff
    output an, dp,      // 7 segment stuff
    output [7:0] JA     // for testing
    );

    reg [15:0] x, y, bcd;   // Here for now, but don't know if we need a reg or not

    VII_seg_x4_top(
        .clk(clk),
        .sw(bcd),
        .seg(seg), .an(an), .dp(dp),
        .btnC(1'b0),
    );

endmodule
