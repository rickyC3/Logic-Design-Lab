`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/17 14:16:10
// Design Name: 
// Module Name: Flash_time
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


module Flash_time(clk, rst, clk_out);
input clk, rst;
output reg clk_out;

reg [26:0]cnt_tmp;
reg [25:0]cnt;

always @*
    cnt_tmp = {clk_out, cnt} + 1;

always @(posedge clk or negedge rst)
    if (~rst)
        {clk_out, cnt} <= 0;
    else
        {clk_out, cnt} <= cnt_tmp;


endmodule
