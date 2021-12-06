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
//////////////////////////////////////////////////////////////////////////////////////////////////////////

// ==============================================================================================
// 												Define Module
// ==============================================================================================
module Kypd_decoder #(parameter SIMULATING = 0)(
    clk,
    Row,
    Col,
    DecodeOut,
    keyPress_one
    );

// ==============================================================================================
// 											Port Declarations
// ==============================================================================================
    input clk;						// 100MHz onboard clock
    input [3:0] Row;				// Rows on KYPD
    output [3:0] Col;			// Columns on KYPD
    output [3:0] DecodeOut;	// Output data
    output keyPress_one;      // Single pulse when a key is pressed

// ==============================================================================================
// 							  		Parameters, Regsiters, and Wires
// ==============================================================================================
	
	// Output wires and registers
	reg [3:0] Col;
	reg [3:0] DecodeOut;
	
	// Count register
	reg [(SIMULATING ? 3 : 19):0] sclk;
	
	// Key press pulse registers
	reg keyPress, keyPress_tm1, keyPress_one;

// ==============================================================================================
// 												Implementation
// ==============================================================================================

   initial begin
      DecodeOut = 4'h0;
      keyPress_tm1 = 1'b0;
      keyPress_one = 1'b0;
      keyPress     = 1'b0;
      Col = 4'b0111;
      sclk = 4'h0;
   end
   
	always @(posedge clk) begin

			// 1ms
			if (sclk == (SIMULATING ? 4'h1 : 20'b00011000011010100000)) begin
				//C1
				Col <= 4'b0111;
				sclk <= sclk + 1'b1;
			end
			
			// check row pins
			else if(sclk == (SIMULATING ? 4'h2 : 20'b00011000011010101000)) begin
				//R1
				if (Row == 4'b0111) begin
					DecodeOut <= 4'b0001;		//1
					keyPress <= 1'b1;
				end
				//R2
				else if(Row == 4'b1011) begin
					DecodeOut <= 4'b0100; 		//4
					keyPress <= 1'b1;
				end
				//R3
				else if(Row == 4'b1101) begin
					DecodeOut <= 4'b0111; 		//7
					keyPress <= 1'b1;
				end
				//R4
				else if(Row == 4'b1110) begin
					DecodeOut <= 4'b0000; 		//0
					keyPress <= 1'b1;
				end
				sclk <= sclk + 1'b1;
			end

			// 2ms
			else if(sclk == (SIMULATING ? 4'h3 : 20'b00110000110101000000)) begin
				//C2
				Col<= 4'b1011;
				sclk <= sclk + 1'b1;
			end
			
			// check row pins
			else if(sclk == (SIMULATING ? 4'h4 : 20'b00110000110101001000)) begin
				//R1
				if (Row == 4'b0111) begin
					DecodeOut <= 4'b0010; 		//2
					keyPress <= 1'b1;
				end
				//R2
				else if(Row == 4'b1011) begin
					DecodeOut <= 4'b0101; 		//5
					keyPress <= 1'b1;
				end
				//R3
				else if(Row == 4'b1101) begin
					DecodeOut <= 4'b1000; 		//8
					keyPress <= 1'b1;
				end
				//R4
				else if(Row == 4'b1110) begin
					DecodeOut <= 4'b1111; 		//F
					keyPress <= 1'b1;
				end
				sclk <= sclk + 1'b1;
			end

			//3ms
			else if(sclk == (SIMULATING ? 4'h5 : 20'b01001001001111100000)) begin
				//C3
				Col<= 4'b1101;
				sclk <= sclk + 1'b1;
			end
			
			// check row pins
			else if(sclk == (SIMULATING ? 4'h6 : 20'b01001001001111101000)) begin
				//R1
				if(Row == 4'b0111) begin
					DecodeOut <= 4'b0011; 		//3	
					keyPress <= 1'b1;
				end
				//R2
				else if(Row == 4'b1011) begin
					DecodeOut <= 4'b0110; 		//6
					keyPress <= 1'b1;
				end
				//R3
				else if(Row == 4'b1101) begin
					DecodeOut <= 4'b1001; 		//9
					keyPress <= 1'b1;
				end
				//R4
				else if(Row == 4'b1110) begin
					DecodeOut <= 4'b1110; 		//E
					keyPress <= 1'b1;
				end

				sclk <= sclk + 1'b1;
			end

			//4ms
			else if(sclk == (SIMULATING ? 4'h7 : 20'b01100001101010000000)) begin
				//C4
				Col<= 4'b1110;
				sclk <= sclk + 1'b1;
			end

			// Check row pins
			else if(sclk == (SIMULATING ? 4'h8 : 20'b01100001101010001000)) begin
				//R1
				if(Row == 4'b0111) begin
					DecodeOut <= 4'b1010; //A
					keyPress <= 1'b1;
				end
				//R2
				else if(Row == 4'b1011) begin
					DecodeOut <= 4'b1011; //B
					keyPress <= 1'b1;
				end
				//R3
				else if(Row == 4'b1101) begin
					DecodeOut <= 4'b1100; //C
					keyPress <= 1'b1;
				end
				//R4
				else if(Row == 4'b1110) begin
					DecodeOut <= 4'b1101; //D
					keyPress <= 1'b1;
				end
				
				sclk <= sclk + 1'b1;
				
//				sclk <= (SIMULATING ? 4'h0 : 20'b00000000000000000000);
				
//            // reset because no key is being pressed
//            keyPress <= 1'b0;
			end
			
			//5ms
			else if (sclk == (SIMULATING ? 4'h9 : 20'b1111010000100100000)) begin
			   Col <= 4'b1111;
				sclk <= (SIMULATING ? 4'h0 : 20'b00000000000000000000);
				
            // reset because no key is being pressed
            keyPress <= 1'b0;
			end

			// Otherwise increment
			else begin
				sclk <= sclk + 1'b1;
			end
	end

   // send a pulse the length of the clk when any key was pressed
   always@ (keyPress_tm1, keyPress) keyPress_one = keyPress && !keyPress_tm1;
   always@ (posedge clk) keyPress_tm1 <= keyPress;
   
endmodule
