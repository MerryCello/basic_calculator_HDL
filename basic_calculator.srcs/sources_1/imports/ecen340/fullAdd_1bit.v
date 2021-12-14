`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2021 10:47:01 AM
// Design Name: 
// Module Name: fullAdd
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


module fullAdd(
    input x,
    input y,
    input cin,
    output s,
    output cout
    );
    
    assign s = x ^ y ^ cin;
    assign cout = (x & y) | (x & cin) | (y & cin);
endmodule
