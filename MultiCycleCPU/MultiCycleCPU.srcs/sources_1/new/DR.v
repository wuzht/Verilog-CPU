`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/26 22:12:11
// Design Name: 
// Module Name: DR
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


module DR(in, clk, out);
    input [31:0] in;
    input clk;
    output reg[31:0] out;
    
    always@(posedge clk) begin
        out = in;
    end
endmodule
