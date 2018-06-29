`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/26 17:41:31
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
    input [31:0] curPC,
    input RegWre,
    input [1:0] RegDst,
    input [4:0] rs,
    input [4:0] rt,
    input [4:0] rd,
    input WrRegDSrc, 
    input [31:0] dbdrDataOut,
    output [31:0] Data1,
    output [31:0] Data2
    );
    reg [4:0] writeReg;
    wire [31:0] writeData;

    always @(RegDst or rt or rd) begin
        case (RegDst)
            0: writeReg = 5'b11111;
            1: writeReg = rt;
            2: writeReg = rd;
        endcase
    end
    
    // if WrRegDSrc == 0, then write $31 = pc + 4
    assign writeData = WrRegDSrc ? dbdrDataOut : curPC + 4;
    //assign writeReg = RegDst ? rd : rt;
    
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
        if (RegWre && writeReg) register[writeReg] <= writeData;
    end
endmodule
