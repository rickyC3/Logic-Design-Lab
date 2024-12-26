`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/15 17:07:04
// Design Name: 
// Module Name: clk_ctl
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


module clk_ctl(clk, rst, clk_ctl);
input clk;
input rst;
output reg clk_ctl;
reg [17:0]cnt;
reg [18:0]cnt_tmp;

always @*
    cnt_tmp = {clk_ctl, cnt} + 1;

always @(posedge clk or negedge rst)
    if (~rst)
        {clk_ctl, cnt} <= 0;
    else
        {clk_ctl, cnt} <= cnt_tmp;

endmodule
