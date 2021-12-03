`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/01/2021 02:51:00 PM
// Design Name: 
// Module Name: Memory
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

// 8 bit word Memory with default of 2 to-the-power-of 4 memory locations
module Memory_x16
    #(
        parameter ADDR_BIT_SIZE = 4
    )(
        inout wire [15:0] data,
        input wire oe, we, clk, // oe => output enable // we => write enable
        input wire [(ADDR_BIT_SIZE - 1):0] addr
    );
    reg [15:0] mem [0:2**ADDR_BIT_SIZE];
    reg [15:0] data_temp;
    
    initial data_temp = 0;
    
    assign data = (oe && !we) ? data_temp : 16'hzzzz;
    
    always@(posedge clk) begin 
        if (we) mem[addr] <= data; 
        else if (oe) data_temp <= mem[addr]; 
    end
endmodule
    
    
    
    
    
    
    
