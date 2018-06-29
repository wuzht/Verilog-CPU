`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/26 17:45:19
// Design Name: 
// Module Name: CPU_sim
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


module CPU_sim(

    );
    reg clk, Reset;
       
    wire [5:0] opCode;
    wire [31:0] Data1, Data2, curPC, Result;
    wire [2:0] state;
    wire [2:0] ALUOp;

    wire [31:0] ExtOut, DMOut;
    wire [15:0] immediate;
    wire [4:0] rs, rt, rd, sa;
    wire [25:0] addr;
    wire [1:0] PCSrc;
    wire [1:0] RegDst;
    wire zero, sign, PCWre, ALUSrcA, ALUSrcB, DBDataSrc, RegWre, InsMemRW, _RD, _WR, ExtSel, WrRegDSrc, IRWre;
    wire [31:0] data, dbdrDataOut;
    wire [31:0] ADR, BDR, resultDR;
        
    CPU cpu(
        .clk(clk),
        .Reset(Reset),
        .opCode(opCode),
        .Out1(Data1),
        .Out2(Data2),
        .curPC(curPC),
        .result(Result),
        .state(state),
        .ALUOp(ALUOp),
        .ExtOut(ExtOut),
        .DMOut(DMOut),
        .immediate(immediate),
        .rs(rs),
        .rt(rt),
        .rd(rd),
        .sa(sa),
        .addr(addr),
        .PCSrc(PCSrc),
        .RegDst(RegDst),
        .zero(zero),
        .sign(sign),
        .PCWre(PCWre),
        .ALUSrcA(ALUSrcA),
        .ALUSrcB(ALUSrcB),
        .DBDataSrc(DBDataSrc),
        .RegWre(RegWre),
        .InsMemRW(InsMemRW),
        ._RD(_RD),
        ._WR(_WR),
        .ExtSel(ExtSel),
        .WrRegDSrc(WrRegDSrc),
        .IRWre(IRWre),
        .data(data),
        .dbdrDataOut(dbdrDataOut),
        .ADR(ADR),
        .BDR(BDR),
        .resultDR(resultDR)
    );
      
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        Reset = 1;
    end
endmodule
