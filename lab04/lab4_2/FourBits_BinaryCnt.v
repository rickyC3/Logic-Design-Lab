`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/22 16:53:28
// Design Name: 
// Module Name: FourBits_BinaryCnt
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


module FourBits_BinaryCnt(clk, rst, cnt);
input clk;
input rst;
output reg [3:0]cnt;

always @(posedge clk or negedge rst)
    if (~rst)
        cnt <= 4'b1111;
    else
        cnt = cnt - 1;

endmodule
