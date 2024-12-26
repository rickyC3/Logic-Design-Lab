`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/04 16:05:33
// Design Name: 
// Module Name: Show_Clk
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


module Show_Clk(clk, rst, clk_out);
input clk, rst;
output reg [1:0]clk_out;

reg [16:0]cnt_tmp;
reg [14:0]cnt;

always @*
    cnt_tmp = {clk_out, cnt} + 1;

always @(posedge clk or negedge rst)
    if (~rst)
        {clk_out, cnt} <= 0;
    else
        {clk_out, cnt} <= cnt_tmp;

endmodule
