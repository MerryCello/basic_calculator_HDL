`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company: Digilent Inc 2011
// Engineer: Michelle Yu  
//				 Josh Sackos
// Create Date:    07/23/2012 
//
// Module Name:    Decoder
// Project Name:   PmodKYPD_Demo
// Target Devices: Nexys3
// Tool versions:  Xilinx ISE 14.1 
// Description: This file defines a component Decoder for the demo project PmodKYPD. The Decoder scans
//					 each column by asserting a low to the pin corresponding to the column at 1KHz. After a
//					 column is asserted low, each row pin is checked. When a row pin is detected to be low,
//					 the key that was pressed could be determined.
//
// Revision History: 
// 						Revision 0.01 - File Created (Michelle Yu)
//							Revision 0.02 - Converted from VHDL to Verilog (Josh Sackos)
//
// Source: https://digilent.com/reference/pmod/pmodkypd/start
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////

// ==============================================================================================
// 												Define Module
// ==============================================================================================
module Kypd_decoder(
    input clk,                   // 100MHz onboard clock
    input      [3:0] row,        // Rows on KYPD
    output reg [3:0] col,        // Columns on KYPD
    output reg [3:0] decodeOut   // Output data
    );
	
	// Count register
	reg [19:0] sclk;

// ==============================================================================================
// 												Implementation
// ==============================================================================================

	always @(posedge clk) begin

			// 1ms
			if (sclk == 20'b00011000011010100000) begin
				//C1
				col <= 4'b0111;
				sclk <= sclk + 1'b1;
			end
			
			// check row pins
			else if(sclk == 20'b00011000011010101000) begin
				//R1
				if (row == 4'b0111) begin
					decodeOut <= 4'b0001;		//1
				end
				//R2
				else if(row == 4'b1011) begin
					decodeOut <= 4'b0100; 		//4
				end
				//R3
				else if(row == 4'b1101) begin
					decodeOut <= 4'b0111; 		//7
				end
				//R4
				else if(row == 4'b1110) begin
					decodeOut <= 4'b0000; 		//0
				end
				sclk <= sclk + 1'b1;
			end

			// 2ms
			else if(sclk == 20'b00110000110101000000) begin
				//C2
				col<= 4'b1011;
				sclk <= sclk + 1'b1;
			end
			
			// check row pins
			else if(sclk == 20'b00110000110101001000) begin
				//R1
				if (row == 4'b0111) begin
					decodeOut <= 4'b0010; 		//2
				end
				//R2
				else if(row == 4'b1011) begin
					decodeOut <= 4'b0101; 		//5
				end
				//R3
				else if(row == 4'b1101) begin
					decodeOut <= 4'b1000; 		//8
				end
				//R4
				else if(row == 4'b1110) begin
					decodeOut <= 4'b1111; 		//F
				end
				sclk <= sclk + 1'b1;
			end

			//3ms
			else if(sclk == 20'b01001001001111100000) begin
				//C3
				col<= 4'b1101;
				sclk <= sclk + 1'b1;
			end
			
			// check row pins
			else if(sclk == 20'b01001001001111101000) begin
				//R1
				if(row == 4'b0111) begin
					decodeOut <= 4'b0011; 		//3	
				end
				//R2
				else if(row == 4'b1011) begin
					decodeOut <= 4'b0110; 		//6
				end
				//R3
				else if(row == 4'b1101) begin
					decodeOut <= 4'b1001; 		//9
				end
				//R4
				else if(row == 4'b1110) begin
					decodeOut <= 4'b1110; 		//E
				end

				sclk <= sclk + 1'b1;
			end

			//4ms
			else if(sclk == 20'b01100001101010000000) begin
				//C4
				col<= 4'b1110;
				sclk <= sclk + 1'b1;
			end

			// Check row pins
			else if(sclk == 20'b01100001101010001000) begin
				//R1
				if(row == 4'b0111) begin
					decodeOut <= 4'b1010; //A
				end
				//R2
				else if(row == 4'b1011) begin
					decodeOut <= 4'b1011; //B
				end
				//R3
				else if(row == 4'b1101) begin
					decodeOut <= 4'b1100; //C
				end
				//R4
				else if(row == 4'b1110) begin
					decodeOut <= 4'b1101; //D
				end
				sclk <= 20'b00000000000000000000;
			end

			// Otherwise increment
			else begin
				sclk <= sclk + 1'b1;
			end
			
	end

endmodule
