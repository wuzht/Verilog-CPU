`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/29 23:50:49
// Design Name: 
// Module Name: RegisterFile
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


module RegisterFile(
    input clk,
    input RegWre,
    input RegDst,
    input [4:0] rs,
    input [4:0] rt,
    input [4:0] rd,
    input DBDataSrc,
    input [31:0] dataFromALU,
    input [31:0] dataFromRW,
    output [31:0] Data1,
    output [31:0] Data2
    );
    wire [4:0] writeReg;
    wire [31:0] writeData;

    assign writeReg = RegDst ? rd : rt;
    assign writeData = DBDataSrc ? dataFromRW : dataFromALU;

    reg [31:0] register[0:31];

    integer i;
    initial begin
        for (i = 0; i < 32; i = i + 1) register[i] <= 0;
    end

    // output
    assign Data1 = register[rs];
    assign Data2 = register[rt];

    // Write Reg 
    always @(negedge clk) begin
        // prevent data from writing into register 0
        if (RegWre && writeReg) register[writeReg] = writeData;
    end
endmodule
