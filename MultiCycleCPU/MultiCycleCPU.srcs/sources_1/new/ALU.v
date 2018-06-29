`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/26 17:36:24
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [31:0] ReadData1,
    input [31:0] ReadData2,
    input [31:0] InExt,
    input [4:0] sa,
    input ALUSrcA,
    input ALUSrcB,
    input [2:0] ALUOP,
    output reg _zero,
    output reg _sign,
    output reg [31:0] result
    );
    wire [31:0] B;
    wire [31:0] A;
    wire [31:0] satemp;

    assign satemp[4:0] = sa;
    assign satemp[31:5] = 27'b000000000000000000000000000;
    assign B = ALUSrcB ? InExt : ReadData2;
    assign A = ALUSrcA ? satemp : ReadData1;

    always @(ReadData1 or ReadData2 or InExt or ALUSrcA or ALUSrcB or ALUOP or B or A)  
    begin
        case(ALUOP)  
            // A + B
            3'b000: begin
                result = A + B;
                _zero = (result == 0) ? 1 : 0;
                _sign = (result[31] == 1) ? 1 : 0;
            end
            // A - B
            3'b001: begin
                result = A - B;
                _zero = (result == 0) ? 1 : 0;
                _sign = (result[31] == 1) ? 1 : 0;
            end  
            // B << A
            3'b100: begin
                result = B << A;
                _zero = (result == 0) ? 1 : 0;
                _sign = (result[31] == 1) ? 1 : 0;
            end  
            // A | B
            3'b101: begin
                result = A | B;
                _zero = (result == 0) ? 1 : 0;
                _sign = (result[31] == 1) ? 1 : 0;
            end  
            // A & B
            3'b110: begin 
                result = A & B;
                _zero = (result == 0) ? 1 : 0;
                _sign = (result[31] == 1) ? 1 : 0;
            end  
            // A < B unsigned
            3'b010: begin 
                result = A < B;
                _zero = (result == 0) ? 1 : 0;
                _sign = (result[31] == 1) ? 1 : 0;
            end   
            // A < B signed
            3'b011: begin
                result = ((A[31] == B[31] && A < B) || (A[31] == 1 && B[31] == 0)) ? 1 : 0;
                _zero = (result == 0) ? 1 : 0;
                _sign = (result[31] == 1) ? 1 : 0;
            end
            // A XOR B
            3'b111: begin
                result = A ^ B;
                _zero = (result == 0) ? 1 : 0;
                _sign = (result[31] == 1) ? 1 : 0;
            end            
        endcase
    end
endmodule

