`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/18/2021 02:59:07 PM
// Design Name: 
// Module Name: clk_gen
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


module Clk_gen #(parameter DIV_BY = 17)(
    input clk, rst,
    output clk_div
    );
    
    reg [DIV_BY:0] count;
    initial count = 0;
    
    always @ (posedge clk, posedge rst)
        count <= rst ? 0 : count + 1;

   assign clk_div = count[DIV_BY];

endmodule







