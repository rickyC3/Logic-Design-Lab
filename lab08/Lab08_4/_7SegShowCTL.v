`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/17 15:06:04
// Design Name: 
// Module Name: _7SegShowCTL
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


module _7SegShowCTL(clk, rst, clk_out);
input clk, rst;
output reg [1:0]clk_out;

reg [16:0]cnt_tmp;
reg [14:0]cnt;

always @*
    cnt_tmp = {clk_out, cnt} + 1;
    
always @(posedge clk or posedge rst)
    if (rst)
        {clk_out, cnt} <= 0;
    else
        {clk_out, cnt} <= cnt_tmp;

endmodule
