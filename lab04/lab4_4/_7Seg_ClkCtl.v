`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/22 19:55:15
// Design Name: 
// Module Name: _7Seg_ClkCtl
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


module _7Seg_ClkCtl(clk, rst, clk_out);
input clk;
input rst;
output reg [1:0]clk_out;

reg [14:0]cnt;
reg [16:0]cnt_tmp;


always @*
    cnt_tmp = {clk_out, cnt} + 1;

always @(posedge clk or negedge rst)
    if (~rst)
        {clk_out, cnt} <= 0;
    else
        {clk_out, cnt} <= cnt_tmp;

endmodule
