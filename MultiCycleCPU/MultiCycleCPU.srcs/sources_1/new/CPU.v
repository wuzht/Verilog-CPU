`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/26 17:42:14
// Design Name: 
// Module Name: CPU
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


module CPU(
    input clk,
    input Reset,
    output wire [5:0] opCode,
    output wire [31:0] Out1,
    output wire [31:0] Out2,
    output wire [31:0] curPC,
    output wire [31:0] result,
    output wire [2:0] state,
    output wire [2:0] ALUOp,
    output wire [31:0] ExtOut, DMOut,
    output wire [15:0] immediate,
    output wire [4:0] rs, rt, rd, sa,
    output wire [25:0] addr,
    output wire [1:0] PCSrc,
    output wire [1:0] RegDst,
    output wire zero, sign, PCWre, ALUSrcA, ALUSrcB, DBDataSrc, RegWre, InsMemRW, _RD, _WR, ExtSel, WrRegDSrc, IRWre,
    output wire [31:0] data, dbdrDataOut,
    output wire [31:0] ADR, BDR, resultDR
    );

    assign data = DBDataSrc ? DMOut : result;
    DR dbdr(data, clk, dbdrDataOut);
    DR adr(Out1, clk, ADR);
    DR bdr(Out2, clk, BDR);
    DR aludr(result, clk, resultDR);
         
    ALU alu(ADR, BDR, ExtOut, sa, ALUSrcA, ALUSrcB, ALUOp, zero, sign, result);

    PC pc(clk, Reset, PCWre, PCSrc, ExtOut, addr, Out1, curPC);

    ControlUnit control(clk, opCode, zero, sign, PCWre, ALUSrcA, ALUSrcB, RegWre, InsMemRW, ExtSel, PCSrc, RegDst, _RD, _WR, DBDataSrc, WrRegDSrc, ALUOp, state, IRWre);

    DataMemory datamemory(clk, resultDR, BDR, _RD, _WR, DMOut);

    InstructionMemory ins(clk, curPC, InsMemRW, opCode, rs, rt, rd, sa, immediate, addr);

    RegisterFile registerfile(clk, curPC, RegWre, RegDst, rs, rt, rd, WrRegDSrc, dbdrDataOut, Out1, Out2);

    SignZeroExtend ext(immediate, ExtSel, ExtOut);
endmodule
