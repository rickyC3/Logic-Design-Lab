`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/22 17:58:06
// Design Name: 
// Module Name: BCD_DownCnt
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


module BCD_DownCnt(clk, rst, cnt);
input clk;
input rst;
output reg [3:0]cnt;

always @(posedge clk or negedge rst)
    if (~rst)
        cnt <= 4'b1001;
    else if (cnt == 0)
        cnt <= 4'b1001;
    else
        cnt = cnt - 1;
        

endmodule
