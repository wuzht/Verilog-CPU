`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/29 16:24:23
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


module ControlUnit(
	input [5:0] opCode,
    input zero,
    output PCWre,
    output ALUSrcA,
    output ALUSrcB,
    output RegWre,
    output InsMemRW,
    output ExtSel,
    output [1:0] PCSrc,
    output RegDst,
    output _RD,
    output _WR,
    output DBDataSrc,
    output [2:0] ALUOp
    );
    assign PCWre = (opCode == 6'b111111) ? 0 : 1;

    // sll 	6'b011000
    assign ALUSrcA = (opCode == 6'b011000) ? 1 : 0;
    // addi 6'b000001
	// ori	6'b010000
	// slti	6'b011011
	// sw	6'b100110
	// lw	6'b100111
	//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    assign ALUSrcB = (opCode == 6'b000001 || opCode == 6'b010000 || 
    	opCode == 6'b100110 || opCode == 6'b100111 || opCode == 6'b011011) ? 1 : 0;

    // lw	6'b100111
    assign DBDataSrc = (opCode == 6'b100111) ? 1 : 0;

    // beq	6'b110000
	// bne	6'b110001
	// sw	6'b100110
	// halt	6'b111111
	// j	6'b111000
    assign RegWre = (opCode == 6'b110000 || opCode == 6'b110001 || 
    	opCode == 6'b110010 || opCode == 6'b100110 || 
    	opCode == 6'b111111 || opCode == 6'b111000) ? 0 : 1;

    assign InsMemRW = 1; 

    assign ExtSel = (opCode == 6'b010000) ? 0 : 1;
    // beq	6'b110000
	// bne	6'b110001
    assign PCSrc[0] = ((opCode == 6'b110000 && zero == 1) || 
    	(opCode == 6'b110001 && zero == 0)) ? 1 : 0;
    // j 	6'b111000
    assign PCSrc[1] = (opCode == 6'b111000) ? 1 : 0;
    // addi 6'b000001
	// ori	6'b010000
	// lw	6'b100111
	// slti	6'b011011
    assign RegDst = (opCode == 6'b000001 || opCode == 6'b010000 || 
    	opCode == 6'b100111 || opCode == 6'b011011) ? 0 : 1;

    // and	6'b010001
    //* slt 6'b011100
    //* bgtz 6'b110010
    // slti 6'b011011
    assign ALUOp[2] = (opCode == 6'b010001 || opCode == 6'b011100 || 
    	opCode == 6'b110010 || opCode == 6'b011011) ? 1 : 0;
    // sll 	6'b011000
    //* 		6'b011100
    // ori	6'b010000
    // or	6'b010010
    //* bgtz	6'b110010
    // slti 6'b011011
    assign ALUOp[1] = (opCode == 6'b011000 || opCode == 6'b011100 || 
    	opCode == 6'b010000 || opCode == 6'b010010 || 
    	opCode == 6'b110010 || opCode == 6'b011011) ? 1 : 0;

    // sub	6'b000010
    // ori	6'b010000
    // or	6'b010010
    // beq	6'b110000
    // bne	6'b110001
    assign ALUOp[0] = (opCode == 6'b000010 || opCode == 6'b010000 || 
    	opCode == 6'b010010 || opCode == 6'b110000 || 
    	opCode == 6'b110001) ? 1 : 0;

    assign _RD = (opCode == 6'b100111) ? 0 : 1;

    assign _WR = (opCode == 6'b100110) ? 0 : 1;
	/*
    input [5:0] opCode,
    input zero,
    output PCWre,
    output ALUSrcA,
    output ALUSrcB,
   	output DBDataSrc,
   	output RegWre,
   	output InsMemRW,
   	output mRD,
   	output mWR,
   	output RegDst,
   	output ExtSel,
   	output [1:0] PCSrc,
   	output [2:0] ALUOp
    );
	// halt	6'b111111
	assign PCWre = (opCode == 6'b111111) ? 0 : 1;
	// sll	6'b011000
	assign ALUSrcA = (opCode == 6'b011000) ? 1 : 0;
	// addi 6'b000001
	// ori	6'b010000
	// slti	6'b011011
	// sw	6'b100110
	// lw	6'b100111
	assign ALUSrcB = (opCode == 6'b000001 || opCode == 6'b010000 || 
		opCode == 6'b011011 || opCode == 6'b100110 || 
		opCode == 6'b100111) ? 1 : 0;
	// lw	6'b100111
	assign DBDataSrc = (opCode == 6'b100111) ? 1 : 0;
	// beq	6'b110000
	// bne	6'b110001
	// sw	6'b100110
	// halt	6'b111111
	// j	6'b111000
	assign RegWre = (opCode == 6'b110000 || opCode == 6'b110001 ||
		opCode == 6'b100110 || opCode == 6'b111111 ||
		opCode == 6'b111000) ? 0 : 1;
	assign InsMemRW = 0;
	// lw	6'b100111
	assign mRD = (opCode == 6'b100111) ? 1 : 0;
	// sw	6'b100110
	assign mWR = (opCode == 6'b100110) ? 1 : 0;
	// addi 6'b000001
	// ori	6'b010000
	// lw	6'b100111
	// slti	6'b011011
	assign RegDst = (opCode == 6'b000001 || opCode == 6'b010000 ||
		opCode == 6'b100111 || opCode == 6'b011011) ? 0 : 1;
	// ori	6'b010000
	assign ExtSel = (opCode == 6'b010000) ? 0 : 1;
	// beq	6'b110000
	// bne	6'b110001
	assign PCSrc[0] = ((opCode == 6'b110000 && zero == 1) || 
		(opCode == 6'b110001 && zero == 0)) ? 1 : 0;
	// j	6'b111000
	assign PCSrc[1] = (opCode == 6'b111000) ? 1 : 0;
	assign ALUOp[2] = (opCode == 6);*/
endmodule
