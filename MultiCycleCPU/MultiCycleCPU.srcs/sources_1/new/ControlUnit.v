`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/26 17:38:47
// Design Name: 
// Module Name: ControlUnit
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

// ADD_OP =   000000
// SUB_OP =   000001
// ADDI_OP =  000010
// OR_OP =    010000
// AND_OP =   010001
// ORI_OP =   010010
// SLL_OP =   011000
// SLT_OP =   100110
// SLTIU_OP = 100111
// SW_OP =    110000
// LW_OP =    110001
// BEQ_OP =   110100
// BLTZ_OP =  110110
// J_OP =     111000
// JR_OP =    111001
// JAL_OP =   111010
// HALT_OP =  111111

module ControlUnit(
    input CLK,
	input [5:0] opCode,
    input zero,
    input sign,
    output reg PCWre,
    output reg ALUSrcA,
    output reg ALUSrcB,
    output reg RegWre,
    output reg InsMemRW,
    output reg ExtSel,
    output reg [1:0] PCSrc,
    output reg [1:0] RegDst,
    output reg _RD,
    output reg _WR,
    output reg DBDataSrc,
    output reg WrRegDSrc,
    output reg [2:0] ALUOp,
    output reg [2:0] state,
    output reg IRWre
    );

    initial begin
        state = 0;
    end

    always @(posedge CLK) begin
        case(state)
            3'b000: state = 3'b001;
            3'b001: begin
                // j 111000, jal 111010, jr 111001, halt 111111
                if (opCode == 6'b111000 || opCode == 6'b111010 || 
                    opCode == 6'b111001 || opCode == 6'b111111)
                    state = 3'b000;
                else
                    state = 3'b010;
            end
            3'b010: begin
                // beq 110100, bltz 110110
                if (opCode == 6'b110100 || opCode == 6'b110110)
                    state = 3'b000;
                // sw 110000, lw 110001
                else if (opCode == 6'b110000 || opCode == 6'b110001)
                    state = 3'b100;
                else
                    state = 3'b011;
            end
            3'b100: begin
                // sw 110000
                if (opCode == 6'b110000)
                    state = 3'b000;
                else
                    state = 3'b011;
            end
            3'b011: state = 3'b000;
        endcase
    end


    // The true table
    always @(state or opCode) begin
        PCWre = (state == 3'b000 && opCode != 6'b111111) ? 1 : 0;
        // sll 011000
        ALUSrcA = (opCode == 6'b011000 && state == 3'b010) ? 1 : 0;
        // sw 110000, lw 110001, addi 000010, ori 010010, sltiu 100111
        ALUSrcB = ((opCode == 6'b110000 || opCode == 6'b110001 || 
            opCode == 6'b000010 || opCode == 6'b010010 || 
            opCode == 6'b100111) && (state == 3'b010)) ? 1 : 0;
        // lw 110001
        DBDataSrc = (opCode == 6'b110001) ? 1 : 0;
        // jal 111010
        RegWre = (state == 3'b011 || 
            (opCode == 6'b111010 && state == 3'b001)) ? 1 : 0;
        WrRegDSrc = (state == 3'b011) ? 1 : 0;
        InsMemRW = (state == 3'b000) ? 1 : 0;
        // lw 110001
        _RD = (state == 3'b100 && opCode == 6'b110001) ? 1 : 0;
        // sw 110000
        _WR = (state == 3'b100 && opCode == 6'b110000) ? 1 : 0;
        IRWre = (state == 3'b000) ? 1 : 0;
        // ori 010010, sltiu 100111
        ExtSel = (state == 3'b001 && (opCode == 6'b010010 || opCode == 6'b100111)) ? 0 : 1;
        // j 111000, jal 111010, jr 111001
        PCSrc[1] = (opCode == 6'b111000 || opCode == 6'b111010 || opCode == 6'b111001) ? 1 : 0;
        // j 111000, jal 111010
        // beq 110100, bltz 110110
        PCSrc[0] = (opCode == 6'b111000 || opCode == 6'b111010 || 
            (opCode == 6'b110100 && zero == 1) || 
            (opCode == 6'b110110 && zero == 0 && sign == 1)) ? 1 : 0;
        // jal 111010, addi 000010, ori 010010, sltiu 100111, lw 110001
        RegDst[1] = (opCode == 6'b111010 || opCode == 6'b000010 || 
            opCode == 6'b010010 || opCode == 6'b100111 || 
            opCode == 6'b110001) ? 0 : 1;
        // addi 000010, ori 010010, sltiu 100111, lw 110001
        RegDst[0] = (opCode == 6'b000010 || opCode == 6'b010010 || 
            opCode == 6'b100111 || opCode == 6'b110001) ? 1 : 0;
        // or 010000, and 010001, ori 010010, sll 011000
        ALUOp[2] = (opCode == 6'b010000 || opCode == 6'b010001 || 
            opCode == 6'b010010 || opCode == 6'b011000) ? 1 : 0;
        // and 010001, slt 100110, sltiu 100111
        ALUOp[1] = (opCode == 6'b010001 || opCode == 6'b100110 || 
            opCode == 6'b100111) ? 1 : 0;
        // sw 110000, lw 110001, add 000000, addi 000010, 
        // and 010001, sll 011000, sltiu 100111
        ALUOp[0] = (opCode == 6'b110000 || opCode == 6'b110001 || 
            opCode == 6'b000000 || opCode == 6'b000010 || 
            opCode == 6'b010001 || opCode == 6'b011000 ||
            opCode == 6'b100111) ? 0 : 1;            
    end

endmodule
