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


module count_down(
    input init_to_8,
    input clk,
    output reg [4:0]cnt
    );
    initial cnt = 0;
    always @(posedge clk)
    begin
        if(init_to_8)
        cnt = 5'b10000; 
        else if(cnt>0)
        cnt <= cnt-1;
        else
        cnt <= cnt - 1;
        
    end
endmodule