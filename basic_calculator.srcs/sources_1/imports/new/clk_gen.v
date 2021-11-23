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


module Clk_gen(
    input clk,
    input rst,
    output clk_div
    );
    
    reg [26:0] count;
    
    always @ (posedge clk, posedge rst) begin
        if (rst)
            count <= 0;
        else
            count <= count + 1;        
    end
    
    // For hardware
   assign clk_div = count[17];
    // For simulation:
    // assign clk_div = count[0];

endmodule







