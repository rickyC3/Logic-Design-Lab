`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/22 16:59:10
// Design Name: 
// Module Name: Lab04_1_top
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


module Lab04_2_top(clk, rst, seg_ctl, led_ctl);
input clk;
input rst;
output [7:0]seg_ctl;
output [3:0]led_ctl;
wire _1HzClk;
wire [3:0]cnt;

_1Hz U0(.clk(clk), .rst(rst), .clk_out(_1HzClk));
FourBits_BinaryCnt U1(.clk(_1HzClk), .rst(rst), .cnt(cnt));
SevenSeg_Ctl U2(.cnt(cnt), .seg_ctl(seg_ctl));
LED_ctl U3(.cnt(cnt), .led_ctl(led_ctl));

endmodule
