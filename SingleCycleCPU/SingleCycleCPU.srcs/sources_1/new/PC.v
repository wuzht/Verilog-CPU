`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/29 23:51:45
// Design Name: 
// Module Name: PC
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


module PC(
    input clk,
    input Reset,
    input PCWre,
    input [1:0] PCSrc,
    input [31:0] immediate, //ExtOut
    input [25:0] addr,
    output reg [31:0] Address
    );

    always @(posedge clk or negedge Reset)  
    begin
        if (Reset == 0) begin
            Address <= 0;
        end  
        else begin if (PCWre) begin
                case(PCSrc)
                    2'b00: Address <= Address + 4;
                    2'b01: Address <= Address + 4 + (immediate * 4);
                    2'b10: begin
                        Address <= Address + 4;
                        Address <= {Address[31:28], addr, 2'b00};
                    end
                endcase
            end
        end
    end
endmodule
