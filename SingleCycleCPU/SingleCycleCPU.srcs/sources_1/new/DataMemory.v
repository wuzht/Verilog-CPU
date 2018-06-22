`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/29 23:47:20
// Design Name: 
// Module Name: DataMemory
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


module DataMemory(
    input clk,
    input [31:0] DAddr,
    input [31:0] DataIn,
    input _RD,
    input _WR,
    output [31:0] DataOut
    );
    reg [7:0] mem[0:127];  //open memory
           
    // read data
    assign DataOut = ( (_RD == 0) ? {mem[DAddr * 4 + 3], mem[DAddr * 4 + 2], mem[DAddr * 4 + 1], mem[DAddr * 4]} : 32'hzzzzzzzz);
    //assign DataOut = 32'hzzzzzzzz;

    // write data
    integer i;
    initial begin
        for (i = 0; i < 32; i = i + 1) mem[i] <= 0;
    end
    always @(negedge clk)  
    begin
        if (!_WR) begin
            mem[DAddr * 4][7:0] = DataIn[7:0];
            mem[DAddr * 4 + 1][7:0] = DataIn[15:8];
            mem[DAddr * 4 + 2][7:0] = DataIn[23:16];
            mem[DAddr * 4 + 3][7:0] = DataIn[31:24];
        end
    end
endmodule
