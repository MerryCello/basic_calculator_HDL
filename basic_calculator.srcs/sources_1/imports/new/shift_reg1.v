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

// shift register for the dividend/quotient
module shift_regQ(
    input [15:0]par_data,
    input LD,
    input SE,
    input shift_in,
    input clk,
    output reg [15:0]Q
    );
    initial Q = 0;
    always @ (posedge clk)
begin
    if (LD) Q <= par_data;  // If load is enabled, the input(dividend)
                            // is passed to the ouput of the flip-flop
    
    else if (SE) Q <= {Q[14:0], shift_in};   // If shift is enabled, the output gets
                                            // shifted with the carry-out from adder
end
endmodule