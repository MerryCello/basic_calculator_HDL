`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/04/2021 03:25:13 PM
// Design Name: 
// Module Name: multiplier
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

module multiplier(
    input [15:0] x, y,
    output [15:0] led
    );
    
    // wires a and b are the multiplier and multiplicand
    wire [31:0] product;    
                            
    assign led = product;   // the product will use all 16 lights
    
    // partial products each with a width of 16 bits
    wire [31:0] p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15;
    
    assign p0[15:0] = {8{y[0]}} & x[7:0];  // a times the first bit of b 
    assign p1[16:1] = {8{y[1]}} & x[7:0];    // a times the second bit of b
    assign p2[17:2] = {8{y[2]}} & x[7:0];    // a times the third bit of b
    assign p3[18:3] = {8{y[3]}} & x[7:0];   // a times the fourth bit of b
    assign p4[19:4] = {8{y[4]}} & x[7:0];   // a times the fifth bit of b
    assign p5[20:5] = {8{y[5]}} & x[7:0];   // a times the sixth bit of b
    assign p6[21:6] = {8{y[6]}} & x[7:0];   // a times the seventh bit of b
    assign p7[22:7] = {8{y[7]}} & x[7:0];   // a times the eighth bit of b
    assign p8[23:8] = {8{y[8]}} & x[7:0];   // a times the ninth bit of b
    assign p9[24:9] = {8{y[9]}} & x[7:0];   // a times the tenth bit of b
    assign p10[25:10] = {8{y[10]}} & x[7:0];   // a times the eleventh bit of b
    assign p11[26:11] = {8{y[11]}} & x[7:0];   // a times the twelfth bit of b
    assign p12[27:12] = {8{y[12]}} & x[7:0];   // a times the thirteenth bit of b
    assign p13[28:13] = {8{y[13]}} & x[7:0];   // a times the fourteenth bit of b
    assign p14[29:14] = {8{y[14]}} & x[7:0];   // a times the fifteenth bit of b
    assign p15[30:15] = {8{y[15]}} & x[7:0];   // a times the sixteenth bit of b
    
    // the product is the sum of the partial products
    assign product = p0 + p1 + p2 + p3 + p4 + p5 + p6 + p7 + p8 +p9
                        + p10 + p11 + p12 + p13 + p14 + p15;
    
endmodule