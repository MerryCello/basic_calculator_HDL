`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/22/2021 05:28:02 PM
// Design Name: 
// Module Name: bin2BCD_4dig
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


module Bin2BCD_4dig(
    input clk,
    input [15:0] bin,
    output [15:0] bcd,
    output reg done
    );
        
    reg [3:0] bit_cnt;
    wire [3:0] dout;
    wire [3:0] BCD3, BCD2, BCD1, BCD0;
    reg [3:0] out3, out2, out1, out0;
    reg din;
//    reg done;
    wire overflow;
    assign bcd = {out3, out2, out1, out0};

    Bin2BCD_1dig dig0 (.done(done), .d_in(din),     .clk(clk), .d_out(dout[0]), .Q(BCD0));
    Bin2BCD_1dig dig1 (.done(done), .d_in(dout[0]), .clk(clk), .d_out(dout[1]), .Q(BCD1));
    Bin2BCD_1dig dig2 (.done(done), .d_in(dout[1]), .clk(clk), .d_out(dout[2]), .Q(BCD2));
    Bin2BCD_1dig dig3 (.done(done), .d_in(dout[2]), .clk(clk), .d_out(dout[3]), .Q(BCD3));

   assign overflow = !(bin > 16'h270F);
   
   // Count down
   initial bit_cnt = 4'hF;
   always @ (posedge clk) begin
     bit_cnt <= bit_cnt - 1;
   end
   
   initial {out3, out2, out1, out0} = 16'h0000;
   always @ (posedge clk) begin 
     if (done)
        {out3, out2, out1, out0} <= {BCD3[2:0], BCD2[3:0], BCD1[3:0], BCD0[3:0], din};
   end
   
   always @ (bit_cnt, bin) begin
     din = bin[bit_cnt];
     done = (bit_cnt == 4'b0000);
   end
    
endmodule








