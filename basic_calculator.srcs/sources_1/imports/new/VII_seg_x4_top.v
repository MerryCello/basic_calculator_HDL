`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/18/2021 03:01:54 PM
// Design Name: 
// Module Name: sseg_x4_top
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

module VII_seg_x4_top #(parameter SIMULATING = 0)(
    input clk,          // Clock
    input btnC,         // Reset button
    input [15:0] sw,    // Switches divided in 4 nibles
    output [3:0] an,    // Digit selector
    output [6:0] seg,   // Digit segments
    output dp,          // Decimal point
    output [4:0] JA     // For testing with the osciloscope
);
    wire clkd;              // Slowed down clock
    wire [3:0] digit_sel;   // The digit to turn on
    reg [3:0] hex_num;      // The number to display (from the switches)
    reg [3:0] anSel;        // The anode(s) that is/are to be on/off
    
    // Bring down the clock frequency, so the display won't
    // seem to flicker to the human eye
    Clk_gen #(.DIV_BY(SIMULATING ? 0 : 17)) clk_gen(
        .clk(clk),
        .rst(btnC),
        .clk_div(clkd)
    );
    
    // Turn off digits that are leading zeros
    always@ (sw) begin
      if (sw[15:12] == 4'h0) begin
         anSel = 4'b0111;
         if (sw[11:8] == 4'h0) begin
            anSel = 4'b0011;
            if (sw[7:4] == 4'h0) begin
               anSel = 4'b0001;
               if (sw[3:0] == 4'h0)
                  anSel = 4'b0000;
            end
         end
      end
      else
         anSel = 4'b1111;
    end
    
    // Select which 7 seg digit to use
    Digit_selector d_sel(
        .clk(clkd),
        .rst(btnC),
        .anSel(anSel),
        .digit_sel(digit_sel)
    );

    // Select which switch nibles to display
    always @(digit_sel) begin
        case (digit_sel)
            4'b1110: hex_num = sw[3:0];
            4'b1101: hex_num = sw[7:4];
            4'b1011: hex_num = sw[11:8];
            4'b0111: hex_num = sw[15:12];
            default: hex_num = 4'bxxxx; // Should never get here, but ya never know!
        endcase
    end
    
    // Turn on the right segments to display the right digit
    VII_seg vii_seg(
        .hex_num(hex_num),  // the number to represent
        .seg(seg),          // drives the seven LEDs for the display
        .dp(dp)             // decimal place assigned permanently to 1'b1
    );
    
    assign an = digit_sel;
    assign JA = {clkd, an[3:0]};

endmodule







