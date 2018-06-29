`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/26 17:40:51
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
    input clk,
    input [31:0] pc,
    input InsMemRW,
    output reg [5:0] op,
    output reg [4:0] rs,
    output reg [4:0] rt,
    output reg [4:0] rd,
    output reg [4:0] shAmount,
    output reg [15:0] immediate,
    output reg [25:0] addr
    );
    wire [7:0] mem[0:127];

    //addi $1,$0,8  00
    //1 00001000 00000001 00000000 00001000 08010008
    assign mem[0] = 8'b00001000;
    assign mem[1] = 8'b00000001;
    assign mem[2] = 8'b00000000;
    assign mem[3] = 8'b00001000;

    //ori  $2,$0,2  04
    //2 01001000 00000010 00000000 00000010 48020002
    assign mem[4] = 8'b01001000;
    assign mem[5] = 8'b00000010;
    assign mem[6] = 8'b00000000;
    assign mem[7] = 8'b00000010;

    //or  $3,$2,$1  08
    //3 01000000 01000001 00011000 00000000 40411800
    assign mem[8] = 8'b01000000;
    assign mem[9] = 8'b01000001;
    assign mem[10] = 8'b00011000;
    assign mem[11] = 8'b00000000;

    //sub  $4,$3,$1 0C
    //4 00000100 01100001 00100000 00000000 04612000
    assign mem[12] = 8'b00000100;
    assign mem[13] = 8'b01100001;
    assign mem[14] = 8'b00100000;
    assign mem[15] = 8'b00000000;

    //and  $5,$4,$2 10
    //5 01000100 10000010 00101000 00000000 44822800
    assign mem[16] = 8'b01000100;
    assign mem[17] = 8'b10000010;
    assign mem[18] = 8'b00101000;
    assign mem[19] = 8'b00000000;

    //sll   $5,$5,2 14
    //6 01100000 00000101 00101000 10000000 60052880
    assign mem[20] = 8'b01100000;
    assign mem[21] = 8'b00000101;
    assign mem[22] = 8'b00101000;
    assign mem[23] = 8'b10000000;

    //beq  $5,$1,-2 18
    //7 11010000 10100001 11111111 11111110 D0A1FFFE
    assign mem[24] = 8'b11010000;
    assign mem[25] = 8'b10100001;
    assign mem[26] = 8'b11111111;
    assign mem[27] = 8'b11111110;

    //jal  0x00000040   1C
    //8 11101000 00000000 00000000 00010000 E8000010
    assign mem[28] = 8'b11101000;
    assign mem[29] = 8'b00000000;
    assign mem[30] = 8'b00000000;
    assign mem[31] = 8'b00010000;

    //slt  $8,$12,$1    20
    //9 10011001 10000001 01000000 00000000 99814000
    assign mem[32] = 8'b10011001;
    assign mem[33] = 8'b10000001;
    assign mem[34] = 8'b01000000;
    assign mem[35] = 8'b00000000;

    //addi  $13,$0,-2   24
    //10 00001000 00001101 11111111 11111110 080DFFFE
    assign mem[36] = 8'b00001000;
    assign mem[37] = 8'b00001101;
    assign mem[38] = 8'b11111111;
    assign mem[39] = 8'b11111110;

    //slt  $9,$8,$13    28
    //11 10011001 00001101 01001000 00000000 990D4800
    assign mem[40] = 8'b10011001;
    assign mem[41] = 8'b00001101;
    assign mem[42] = 8'b01001000;
    assign mem[43] = 8'b00000000;

    //sltiu  $10,$9,2   2C
    //12 10011101 00101010 00000000 00000010 9D2A0002
    assign mem[44] = 8'b10011101;
    assign mem[45] = 8'b00101010;
    assign mem[46] = 8'b00000000;
    assign mem[47] = 8'b00000010;

    //sltiu  $11,$10,0  30
    //13 10011101 01001011 00000000 00000000 9D4B0000
    assign mem[48] = 8'b10011101;
    assign mem[49] = 8'b01001011;
    assign mem[50] = 8'b00000000;
    assign mem[51] = 8'b00000000;

    //addi  $13,$13,1   34
    //14 00001001 10101101 00000000 00000001 09AD0001
    assign mem[52] = 8'b00001001;
    assign mem[53] = 8'b10101101;
    assign mem[54] = 8'b00000000;
    assign mem[55] = 8'b00000001;

    //bltz $13,-2   38
    //15 11011001 10100000 11111111 11111110 D9A0FFFE
    assign mem[56] = 8'b11011001;
    assign mem[57] = 8'b10100000;
    assign mem[58] = 8'b11111111;
    assign mem[59] = 8'b11111110;

    //j  0x000004C  3C
    //16 11100000 00000000 00000000 00010011 E0000013
    assign mem[60] = 8'b11100000;
    assign mem[61] = 8'b00000000;
    assign mem[62] = 8'b00000000;
    assign mem[63] = 8'b00010011;

    //sw  $2,4($1)  40
    //17 11000000 00100010 00000000 00000100 C0220004
    assign mem[64] = 8'b11000000;
    assign mem[65] = 8'b00100010;
    assign mem[66] = 8'b00000000;
    assign mem[67] = 8'b00000100;

    //lw  $12,4($1) 44
    //18 11000100 00101100 00000000 00000100 C42C0004
    assign mem[68] = 8'b11000100;
    assign mem[69] = 8'b00101100;
    assign mem[70] = 8'b00000000;
    assign mem[71] = 8'b00000100;

    //jr  $31   48
    //19 11100111 11100000 00000000 00000000 E7E00000
    assign mem[72] = 8'b11100111;
    assign mem[73] = 8'b11100000;
    assign mem[74] = 8'b00000000;
    assign mem[75] = 8'b00000000;

    //halt  4C
    //20 11111100 00000000 00000000 00000000 FC000000
    assign mem[76] = 8'b11111100;
    assign mem[77] = 8'b00000000;
    assign mem[78] = 8'b00000000;
    assign mem[79] = 8'b00000000;
         
    // output
    always @(posedge clk) begin
        if (InsMemRW) begin
            op = mem[pc[6:2]*4][7:2]; 
            rs = {mem[pc[6:2]*4][1:0], mem[pc[6:2]*4+1][7:5]};
            rt = mem[pc[6:2]*4+1][4:0];
            rd = mem[pc[6:2]*4+2][7:3];
            immediate = {mem[pc[6:2]*4+2][7:0],mem[pc[6:2]*4+3][7:0]};
            shAmount = {mem[pc[6:2]*4+2][2:0], mem[pc[6:2]*4+3][7:6]};
            addr = {mem[pc[6:2]*4][1:0],mem[pc[6:2]*4+1][7:0],mem[pc[6:2]*4+2][7:0],mem[pc[6:2]*4+3][7:0]};     
        end     
    end       
    
endmodule
