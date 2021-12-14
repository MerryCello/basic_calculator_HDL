`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2021 03:46:52 PM
// Design Name: 
// Module Name: adder
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

// Shift register for the remainder
module shift_regR(
    input LD,
    input SE,
    input [15:0]Q,
    input clk,
    input [15:0]diff,
    input sel_diff,
    output reg [15:0]R
    );
    
    initial R = 0;  // Initialize R for test bench purposes
always @ (posedge clk)
begin
    if (LD && !sel_diff) R <= 8'h00;    // This acts as the MUX that passes in 0's if the select is 0
    else if (LD && sel_diff) R <= diff; // This acts as the MUX that passes in diff if the select is 1
    else if (SE) R <= {R[14:0], Q[15]};   // This shifts the output with the output of shift_regQ
    else R <= R;
end
endmodule