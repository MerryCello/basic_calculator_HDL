`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/11/2021 03:12:28 PM
// Design Name: 
// Module Name: VII_seg
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


module VII_seg(
    input [3:0] hex_num,
    output reg [6:0] seg,
    output dp
    );
    assign dp = 1'b1;
    
    initial seg = 7'h00;

    always @(hex_num) begin
        // All the cases from 0-15 and the corresponding segments to 'ground' or turn on.
        case (hex_num)
            4'h0: seg = 8'h40;   // 0
            4'h1: seg = 8'hf9;   // 1
            4'h2: seg = 8'h24;   // 2
            4'h3: seg = 8'h30;   // 3
            4'h4: seg = 8'h19;   // 4
            4'h5: seg = 8'h12;   // 5
            4'h6: seg = 8'h02;   // 6
            4'h7: seg = 8'h78;   // 7
            4'h8: seg = 8'h00;   // 8
            4'h9: seg = 8'h18;   // 9
            4'hA: seg = 8'h08;   // 10
            4'hB: seg = 8'h03;   // 11
            4'hC: seg = 8'h27;   // 12
            4'hD: seg = 8'h21;   // 13
            4'hE: seg = 8'h06;   // 14
            4'hF: seg = 8'h0e;   // 15
        endcase
    end
endmodule
