`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/18/2021 03:14:49 PM
// Design Name: 
// Module Name: digit_selector
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


module Digit_selector(
      input clk,
      input rst,
      output reg [3:0] digit_sel
   );
   reg [1:0] count;
   
   initial begin digit_sel = 4'b1110; count = 2'b00; end
    
    // Count from 0 to 3 repeatedly
    always @ (posedge clk, posedge rst) begin
        if (rst)
            count <= 0;
        else
            // If count is 11 then +1 makes it go to 00
            count <= count + 1;
    end
    
    // select which digit to use based on the count number
    always @(count) begin
        case (count)
            2'b00: digit_sel = 4'b1110;
            2'b01: digit_sel = 4'b1101;
            2'b10: digit_sel = 4'b1011;
            2'b11: digit_sel = 4'b0111;
            default: digit_sel = 4'bxxxx;   // Should never get here, but ya never know!
        endcase
    end
    
endmodule







