`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2021 10:36:54 AM
// Design Name: 
// Module Name: full_add_sub
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


module Full_add_sub(
    input [15:0] x, y,     // x and y (temporary)
    input sub,             // 0 for add and 1 for subtract
    output [15:0] result,  // temporary output
    output cout
    );
    
    wire [15:0] c;       // carry-in/carry-out for adder
    wire [15:0] B;       // the XOR output for y
    wire [15:0] s;       // sum of x and y
    
    assign result = s;
    assign cout = c[15];

    
    // XOR logic outputs
    xor (B[0], y[0], sub);
    xor (B[1], y[1], sub);
    xor (B[2], y[2], sub);
    xor (B[3], y[3], sub);
    xor (B[4], y[4], sub);
    xor (B[5], y[5], sub);
    xor (B[6], y[6], sub);
    xor (B[7], y[7], sub);
    xor (B[8], y[8], sub);
    xor (B[9], y[9], sub);
    xor (B[10], y[10], sub);
    xor (B[11], y[11], sub);
    xor (B[12], y[12], sub);
    xor (B[13], y[13], sub);
    xor (B[14], y[14], sub);
    xor (B[15], y[15], sub);
    
    // sends each bit to the full adder
    fullAdd a0(x[0], B[0], sub,  s[0], c[0]);
    fullAdd a1(x[1], B[1], c[0], s[1], c[1]);
    fullAdd a2(x[2], B[2], c[1], s[2], c[2]);
    fullAdd a3(x[3], B[3], c[2], s[3], c[3]);
    fullAdd a4(x[4], B[4], c[3], s[4], c[4]);
    fullAdd a5(x[5], B[5], c[4], s[5], c[5]);
    fullAdd a6(x[6], B[6], c[5], s[6], c[6]);
    fullAdd a7(x[7], B[7], c[6], s[7], c[7]);
    fullAdd a8(x[7], B[8], c[7], s[8], c[8]);
    fullAdd a9(x[7], B[9], c[8], s[9], c[9]);
    fullAdd a10(x[10], B[10], c[9], s[10], c[10]);
    fullAdd a11(x[11], B[11], c[10], s[11], c[11]);
    fullAdd a12(x[12], B[12], c[11], s[12], c[12]);
    fullAdd a13(x[13], B[13], c[12], s[13], c[13]);
    fullAdd a14(x[14], B[14], c[13], s[14], c[14]);
    fullAdd a15(x[15], B[15], c[14], s[15], c[15]);
endmodule
