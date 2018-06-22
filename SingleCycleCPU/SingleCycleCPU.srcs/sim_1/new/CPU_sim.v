`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/29 23:56:51
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
        
    SingleCycleCPU cpu(
        .clk(clk),
        .Reset(Reset),
        .opCode(opCode),
        .Out1(Data1),
        .Out2(Data2),
        .curPC(curPC),
        .result(Result)
    );
      
    always #5 clk = ~clk;

    initial begin
        clk = 0;           
        Reset = 0;         
        #10 Reset = 1;
    end
endmodule
