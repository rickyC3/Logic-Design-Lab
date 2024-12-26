`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/22 19:39:51
// Design Name: 
// Module Name: BCD0_DownCnt
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


module BCD0_UpCnt(clk, rst, cnt, nxt_inc0);
input clk;
input rst;
output reg nxt_inc0; // increase opr 
output reg [3:0]cnt;

always @*
    if (cnt == 4'd9)
        nxt_inc0 = 1;
    else
        nxt_inc0 = 0;

always @(posedge clk or negedge rst)
    if (~rst) begin
        cnt <= 0;
    end else if (cnt == 4'd9)
        cnt <= 0;
    else
        cnt <= cnt + 1;
        
    
endmodule
