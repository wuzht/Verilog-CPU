`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/29 23:48:42
// Design Name: 
// Module Name: InstructionMemory
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


module InstructionMemory(
    input [31:0] pc,
    input InsMemRW,
    output [5:0] op,
    output [4:0] rs,
    output [4:0] rt,
    output [4:0] rd,
    output [4:0] shAmount,
    output [15:0] immediate,
    output [25:0] addr
    );
    wire [7:0] mem[0:75];
    
         
    //addi $1,$0,8
    assign mem[0] = 8'b00000100;
    assign mem[1] = 8'b00000001;
    assign mem[2] = 8'b00000000;
    assign mem[3] = 8'b00001000;

    //ori $1,$0,2
    assign mem[4] = 8'b01000000;
    assign mem[5] = 8'b00000010;
    assign mem[6] = 8'b00000000;
    assign mem[7] = 8'b00000010;

    //add $3,$2,$1
    assign mem[8] = 8'b00000000;
    assign mem[9] = 8'b01000001;
    assign mem[10] = 8'b00011000;
    assign mem[11] = 8'b00000000;

    //sub $5,$3,$2
    assign mem[12] = 8'b00001000;
    assign mem[13] = 8'b01100010;
    assign mem[14] = 8'b00101000;
    assign mem[15] = 8'b00000000;

    //and $4,$5,$2
    assign mem[16] = 8'b01000100;
    assign mem[17] = 8'b10100010;
    assign mem[18] = 8'b00100000;
    assign mem[19] = 8'b00000000;

    //or $8,$4,$2
    assign mem[20] = 8'b01001000;
    assign mem[21] = 8'b10000010;
    assign mem[22] = 8'b01000000;
    assign mem[23] = 8'b00000000;

    //sll $8,$8,1
    assign mem[24] = 8'b01100000;
    assign mem[25] = 8'b00001000;
    assign mem[26] = 8'b01000000;
    assign mem[27] = 8'b01000000;

    //bne $8,$1,-2
    assign mem[28] = 8'b11000101;
    assign mem[29] = 8'b00000001;
    assign mem[30] = 8'b11111111;
    assign mem[31] = 8'b11111110;

    //slti $6,$2,8
    assign mem[32] = 8'b01101100;
    assign mem[33] = 8'b01000110;
    assign mem[34] = 8'b00000000;
    assign mem[35] = 8'b00001000;

    //slti $7,$6,0
    assign mem[36] = 8'b01101100;
    assign mem[37] = 8'b11000111;
    assign mem[38] = 8'b00000000;
    assign mem[39] = 8'b00000000;

    //addi $7,$7,8
    assign mem[40] = 8'b00000100;
    assign mem[41] = 8'b11100111;
    assign mem[42] = 8'b00000000;
    assign mem[43] = 8'b00001000;

    //beq $7,$1,-2
    assign mem[44] = 8'b11000000;
    assign mem[45] = 8'b11100001;
    assign mem[46] = 8'b11111111;
    assign mem[47] = 8'b11111110;

    //sw $2,4($1)
    assign mem[48] = 8'b10011000;
    assign mem[49] = 8'b00100010;
    assign mem[50] = 8'b00000000;
    assign mem[51] = 8'b00000100;

    //lw $9,4($1)
    assign mem[52] = 8'b10011100;
    assign mem[53] = 8'b00101001;
    assign mem[54] = 8'b00000000;
    assign mem[55] = 8'b00000100;

    //j 0x00000040  38
    assign mem[56] = 8'b11100000;
    assign mem[57] = 8'b00000000;
    assign mem[58] = 8'b00000000;
    assign mem[59] = 8'b00010000;

    //addi $10,$0,10    3C
    assign mem[60] = 8'b00000100;
    assign mem[61] = 8'b00001010;
    assign mem[62] = 8'b00000000;
    assign mem[63] = 8'b00001010;

    //halt  40
    assign mem[64] = 8'b11111100;
    assign mem[65] = 8'b00000000;
    assign mem[66] = 8'b00000000;
    assign mem[67] = 8'b00000000;
         
    // output       
    assign op = mem[pc[6:2]*4][7:2]; 
    assign rs = {mem[pc[6:2]*4][1:0], mem[pc[6:2]*4+1][7:5]};
    assign rt = mem[pc[6:2]*4+1][4:0];
    assign rd = mem[pc[6:2]*4+2][7:3];
    assign immediate = {mem[pc[6:2]*4+2][7:0],mem[pc[6:2]*4+3][7:0]};
    assign shAmount = {mem[pc[6:2]*4+2][2:0], mem[pc[6:2]*4+3][7:6]};
    assign addr = {mem[pc[6:2]*4][1:0],mem[pc[6:2]*4+1][7:0],mem[pc[6:2]*4+2][7:0],mem[pc[6:2]*4+3][7:0]};
endmodule
