`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/22/2021 03:56:03 PM
// Design Name: 
// Module Name: calc_4fun
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


module Calc_4fun #(
      // When simulating, clock dividers only divide once and
      // data is set so it is readable in the timing diagram
      parameter SIMULATING = 0,
      // Signal codes (to make things easier to read and keep things consistent)
      parameter DIVIDE    = 4'hA,
      parameter MULTIPLY  = 4'hB,
      parameter SUBSTRACT = 4'hC,
      parameter ADD       = 4'hD,
      parameter EXECUTE   = 4'hE,
      parameter CLEAR     = 4'hF,
      parameter NULL      = 4'h0
   )(
      input clk,           // 100 MHz clock
      input [3:0] kp_row,  // Keypad row
      output [3:0] kp_col, // Keypad column
      output [6:0] seg,    // 7 segment stuff
      output [3:0] an,     // 7 segment stuff
      output dp,           // 7 segment stuff
      output [15:0] led // temporary for debugging
   );

   reg [15:0] x_input, y_input;     // The inputs as they are types
   reg [15:0] num_disp;             // The digits to display
   reg [3:0] operation;             // The math function that was selected
   reg E_pressed;                   // Track whether E (=) was pressed previously
   reg keyPress_deb, keyPress_tm1;  // Debounced keyPress pulse and timing register
   wire keyPress;                   // Pulse when key is pressed
   wire deb_clk;                    // debounce clock for keyPress
   wire [3:0] keyValue;             // Value of the last key pressed
   
   // If no functions selected and execute was pressed then send data to display
   // else send X to write to memory
   // If a function was selected then send Y to write to memory
//   assign data = mem_writeAndNotRead ? mem_in : mem_out;
   assign led = {keyValue, 10'b0000000000, keyPress_deb, deb_clk};
   
   // Initial values for simulations
   initial begin
      x_input  = 16'h0000;
      y_input  = 16'h0000;
      num_disp = 16'h0000;
      operation = 4'h0;
      E_pressed = 1'b0;
      keyPress_deb = 1'b0;
      keyPress_tm1 = 1'b0;
   end

   // Keypad decoder
   // Reads coordinate of button pressed and
   // gives its value and pulse of when it was pressed
   Kypd_decoder #(.SIMULATING(SIMULATING)) kp_decoder(
      .clk(clk),
      .Row(kp_row),
      .Col(kp_col),
      .DecodeOut(keyValue),
      .keyPress_one(keyPress)
   );
   
   // Elongate the keyPress pulse (debounce it)
   Clk_gen #(.DIV_BY(SIMULATING ? 0 : 20)) deb_clk_divider(.clk(clk), .rst(1'b0), .clk_div(deb_clk));
   always@ (posedge keyPress, posedge deb_clk) begin
      if (keyPress)
         keyPress_tm1 <= 1'b1;
      else if (deb_clk) begin
         keyPress_deb <= keyPress_tm1;
         keyPress_tm1 <= 1'b0;
      end
   end
   
   /////////////////////////////////////////////////////////////////////////////////////////////////
   ///////////////////////////////////// INTERFACE LOGIC ///////////////////////////////////////////
   /////////////////////////////////////////////////////////////////////////////////////////////////
   always@ (posedge keyPress_deb) begin
   
      // Number input (0-9)
      if (keyValue >= 4'h0 && keyValue <= 4'h9) begin
         E_pressed = 1'b0;
         // X input
         if (operation == NULL || x_input == 16'h0000) begin
            x_input = {x_input[11:0], keyValue};
         num_disp = x_input;
         end
         // Y input
         else begin
            y_input = {y_input[11:0], keyValue};
            num_disp = y_input;
         end
      end
      
      // Function input (A-B)
      else if (keyValue == DIVIDE    ||
               keyValue == MULTIPLY  ||
               keyValue == SUBSTRACT ||
               keyValue == ADD         ) begin
         if (operation == NULL || E_pressed)
            operation = keyValue;
         else begin
            operationMUX4to1(
               .x(x_input),
               .op(operation),
               .y(y_input),
               .result(x_input)
            );
            operation = keyValue;
         end
         
         E_pressed = 1'b0;
         num_disp = x_input;
         y_input = 16'h0000;
      end
      
      // Perform math operation (E)
      else if (keyValue == EXECUTE) begin
         E_pressed = 1'b1;
         // perform math operation
         operationMUX4to1(
            .x(x_input),
            .op(operation),
            .y(y_input),
            .result(x_input)
         );
         
         // make sure the result is displayed
         num_disp = x_input;
      end
      
      // Clear inputs and states (F)
      else if (keyValue == CLEAR) begin
         E_pressed = 1'b0;
         x_input = 16'h0000;
         y_input = 16'h0000;
         num_disp = 16'h0000;
         operation = NULL;
      end
   end
   /////////////////////////////////////////////////////////////////////////////////////////////////
   /////////////////////////////////////////////////////////////////////////////////////////////////
   /////////////////////////////////////////////////////////////////////////////////////////////////

   task operationMUX4to1;
      input [15:0] x, y;
      input op;
      output [15:0] result;
      case (operation)
         DIVIDE:    result = x / y;
         MULTIPLY:  result = x * y;
         SUBSTRACT: result = x - y;
         ADD:       result = x + y;
         default:   result = 16'h0000;
      endcase
   endtask
   
   VII_seg_x4_top #(.SIMULATING(SIMULATING)) vii_seg_x4(
      .clk(clk),
      .sw(num_disp),
      .seg(seg), .an(an), .dp(dp),
      .btnC(1'b0)
   );

endmodule








