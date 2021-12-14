`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2021 03:56:06 PM
// Design Name: 
// Module Name: register
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

// This simple module passes the divisor through to the output
module div_register(
    input [15:0]Div,
    input clk,
    input EN,
    output reg [15:0]Q
    );
    initial Q = 0;
    
    // Flip-flop passes the input to the output on the clk
    always @ (posedge clk)
    Q<=Div;
    
endmodule
