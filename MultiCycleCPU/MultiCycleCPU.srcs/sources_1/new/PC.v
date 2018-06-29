`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/26 17:41:04
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
    input [31:0] data1_rs,
    output reg [31:0] Address
    );
    initial begin
        Address = 0;
    end

    always @(negedge clk)  
    begin
        if (Reset == 0) begin
            Address <= 0;
        end  
        else begin 
            if (PCWre) begin
                case(PCSrc)
                    2'b00: Address <= Address + 4;
                    2'b01: Address <= Address + 4 + (immediate * 4);
                    2'b10: Address <= data1_rs;
                    2'b11: begin
                        Address <= Address + 4;
                        Address <= {Address[31:28], addr, 2'b00};
                    end
                endcase
            end
        end
    end
endmodule
