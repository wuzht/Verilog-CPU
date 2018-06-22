`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/29 23:54:20
// Design Name: 
// Module Name: SingleCycleCPU
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


module SingleCycleCPU(
    input clk,
    input Reset,
    output wire [5:0] opCode,
    output wire [31:0] Out1,
    output wire [31:0] Out2,
    output wire [31:0] curPC,
    output wire [31:0] result
    );
    wire [2:0] ALUOp;   
    wire [31:0] ExtOut, DMOut;
    wire [15:0] immediate;
    wire [4:0] rs, rt, rd, sa;
    wire [25:0] addr;
    wire [1:0] PCSrc;
    wire zero, PCWre, ALUSrcA, ALUSrcB, DBDataSrc, RegWre, InsMemRW, _RD, _WR, ExtSel, RegDst;
         
    ALU alu(Out1, Out2, ExtOut, sa, ALUSrcA, ALUSrcB, ALUOp, zero, result);

    PC pc(clk, Reset, PCWre, PCSrc, ExtOut, addr, curPC);

    ControlUnit control(opCode, zero, PCWre, ALUSrcA, ALUSrcB, RegWre, InsMemRW, ExtSel, PCSrc, RegDst, _RD, _WR, DBDataSrc, ALUOp);

    DataMemory datamemory(clk, result, Out2, _RD, _WR, DMOut);

    InstructionMemory ins(curPC, InsMemRW, opCode, rs, rt, rd, sa, immediate, addr);

    RegisterFile registerfile(clk, RegWre, RegDst, rs, rt, rd, DBDataSrc, result, DMOut, Out1, Out2);

    SignZeroExtend ext(immediate, ExtSel, ExtOut);
endmodule
