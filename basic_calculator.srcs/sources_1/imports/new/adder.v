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


module adder(
    input [15:0]R,
    input [15:0]Q,
    input [15:0]B,
    output cout,
    output [15:0]s
    );
    
    wire [15:0]T = ~B + 1;   // This creates a two's complement of the 'B' input
    wire [16:0]sum;
    

    assign sum = {R[14:0], Q[15]} + T;    // Sum of the adder -- A + B
    assign {cout,s} = sum;  // The MSB of the sum is passed to the cout
                            // The rest of sum is passed to s, which is diff    
    
endmodule
