`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2021 02:27:06 PM
// Design Name: 
// Module Name: divider
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


module Divider(
      input [15:0] x,
      input [15:0] y,
      input Start, //initialize division
      input clk,
      output [7:0]remainder,     // This allows the LEDs to be used as the remainder
      output [15:0]Quo    //quotient output
   );
   // These parameters make the state machine easier to read    
   parameter Init = 2'b00;
   parameter SL = 2'b01;
   parameter LD = 2'b10;
   parameter Done = 2'b11; 
 
   // Declaration of all the wires and regs
   reg Init_reg, EN_SL, EN_LD, sel_diff, EN_SQ, clk_d;
   reg [1:0] state, next_state;
   wire [15:0]Q, diff, D, R;
   wire [4:0]C;
   wire N_GTE_D;
   wire pulse_in;
   
   // Instantiation of all the submodules
   adder add1(.R(R), .Q(Q), .B(D), .cout(N_GTE_D), .s(diff));
   div_register U1(.Div(x), .EN(Init_reg), .clk(clk), .Q(D));
   shift_regQ U2(.par_data(y), .LD(Init_reg), .SE(EN_SQ), .shift_in(N_GTE_D), .clk(clk), .Q(Q));
   shift_regR U3(.LD(EN_LD), .SE(EN_SL), .Q(Q), .clk(clk), .diff(diff), .sel_diff(sel_diff), .R(R));
   count_down U4(.init_to_8(Init_reg), .clk(clk), .cnt(C));
   
   // Flip-flop that moves the state machine along
   initial state = 2'b11;
   always @ (posedge clk)
      state <= next_state;
   
   // Initializing values for test bench purposes
   initial begin
      Init_reg = 0;
      EN_SL = 0;
      EN_LD = 0;
      sel_diff = 0;
      EN_SQ = 0;
   end
   
   // Implementation of a Mealy state machine. This state machine 
   // needs both the current states as well as the next states
   always @ (state, Start, N_GTE_D, C) begin
      case (state)
         Init: if (!Start && !N_GTE_D)          begin next_state = SL;      Init_reg = 0; EN_SL = 1; EN_LD = 0; sel_diff = 0; EN_SQ = 1; end
               else if (!Start && N_GTE_D)      begin next_state = LD;      Init_reg = 0; EN_SL = 0; EN_LD = 1; sel_diff = 1; EN_SQ = 1; end
               else                             begin next_state = Init;    Init_reg = 1; EN_SL = 0; EN_LD = 1; sel_diff = 0; EN_SQ = 0; end
         SL:   if (!N_GTE_D && C!=4'b0000)      begin next_state = SL;      Init_reg = 0; EN_SL = 1; EN_LD = 0; sel_diff = 0; EN_SQ = 1; end
               else if (!N_GTE_D && C==4'b0000) begin next_state = Done;    Init_reg = 0; EN_SL = 0; EN_LD = 0; sel_diff = 0; EN_SQ = 0; end
               else if (N_GTE_D && C!=4'b0000)  begin  next_state = LD;     Init_reg = 0; EN_SL = 0; EN_LD = 1; sel_diff = 1; EN_SQ = 1; end
               else if (N_GTE_D && C==4'b0000)  begin next_state = Done;    Init_reg = 0; EN_SL = 0; EN_LD = 0; sel_diff = 0; EN_SQ = 0; end
               else                             begin next_state = Done;    Init_reg = 0; EN_SL = 0; EN_LD = 0; sel_diff = 0; EN_SQ = 0; end
         LD:   if (!N_GTE_D && C!=4'b0000)      begin next_state = SL;      Init_reg = 0; EN_SL = 1; EN_LD = 0; sel_diff = 0; EN_SQ = 1; end
               else if (!N_GTE_D && C==4'b0000) begin next_state = Done;    Init_reg = 0; EN_SL = 0; EN_LD = 0; sel_diff = 0; EN_SQ = 0; end
               else if (N_GTE_D && C!=4'b0000)  begin next_state = LD;      Init_reg = 0; EN_SL = 0; EN_LD = 1; sel_diff = 1; EN_SQ = 1; end
               else if (N_GTE_D && C==4'b0000)  begin next_state = Done;    Init_reg = 0; EN_SL = 0; EN_LD = 0; sel_diff = 0; EN_SQ = 0; end
               else                             begin next_state = Done;    Init_reg = 0; EN_SL = 0; EN_LD = 0; sel_diff = 0; EN_SQ = 0; end
         Done: if (!Start)                      begin next_state = Done;    Init_reg = 0; EN_SL = 0; EN_LD = 0; sel_diff = 0; EN_SQ = 0; end
               else                             begin next_state = Init;    Init_reg = 1; EN_SL = 0; EN_LD = 1; sel_diff = 0; EN_SQ = 0; end
      endcase
   end
   
   assign Quo = Q;
   assign remainder = R; // Remainder is passed to the LEDs
   
endmodule
