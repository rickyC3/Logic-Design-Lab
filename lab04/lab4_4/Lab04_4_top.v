`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/22 20:07:30
// Design Name: 
// Module Name: Lab04_4_top
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


module Lab04_4_top(clk, rst, ssd, D);
input clk;
input rst;
output [3:0]ssd;
output [7:0]D;
wire _1HzClk;
wire [1:0]seg_ctl;
wire [3:0]cnt0; wire [3:0]cnt1; wire [3:0]cnt2; wire [3:0]cnt3;
wire inc0, inc1, inc2, inc3;

_1HzClk U0(.clk(clk), .rst(rst), .clk_out(_1HzClk));
_7Seg_ClkCtl U1(.clk(clk), .rst(rst), .clk_out(seg_ctl));

BCD0_UpCnt U2(.clk(_1HzClk), .rst(rst), .cnt(cnt0), .nxt_inc0(inc0));
BCD1_UpCnt U3(.clk(_1HzClk), .rst(rst), .inc0(inc0), .cnt(cnt1), .nxt_inc1(inc1));
BCD2_UpCnt U4(.clk(_1HzClk), .rst(rst), .inc0(inc0), .inc1(inc1), .cnt(cnt2), .nxt_inc2(inc2));
BCD3_UpCnt U5(.clk(_1HzClk), .rst(rst), .inc0(inc0), .inc1(inc1), .inc2(inc2), .cnt(cnt3));

SegShow_Ctl U6(.seg_ctl(seg_ctl), .cnt0(cnt0), .cnt1(cnt1), .cnt2(cnt2), .cnt3(cnt3), .ssd(ssd), .D(D));


endmodule
