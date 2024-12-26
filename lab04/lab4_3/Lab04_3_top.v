`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/22 18:02:09
// Design Name: 
// Module Name: Lab04_3_top
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


module Lab04_3_top(clk, rst, seg_ctl);
input clk;
input rst;
output [7:0]seg_ctl;
wire [3:0]cnt;
wire _2HzClk;

_2Hz U0(.clk(clk), .rst(rst), .clk_out(_2HzClk));
BCD_DownCnt U1(.clk(_2HzClk), .rst(rst), .cnt(cnt));
BCD_to_7segDec U2(.cnt(cnt), .seg_ctl(seg_ctl));

endmodule
