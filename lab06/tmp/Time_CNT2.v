`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/17 10:28:13
// Design Name: 
// Module Name: Time_CNT2
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


module Time_CNT2(clk, rst, stop, cnt0, cnt1, opr, max0, max1);
input clk, rst, stop;
input [3:0]max0;
input [3:0]max1;
output [3:0]cnt0;
output [3:0]cnt1;
output reg opr;
reg opr_rst;
wire OneClk;
wire opr0, opr1;
reg stop0, stop1;
always @* begin
    opr = (opr1 & opr0) | opr_rst;
    stop0 = stop;
    stop1 = ~opr0 | stop0;
end

always @*
    if (cnt0 == max0 && cnt1 == max1 && ~stop0)
        opr_rst = 0;
    else
        opr_rst = 1;

_1HzClk OneCLK0(.clk(clk), .rst(rst), .clk_out(OneClk));
Time_BCD2 time0(.clk(OneClk), .rst(rst), .opr_rst(opr_rst), .stop(stop0), .max(9), .min(0), .cnt(cnt0), .opr(opr0));
Time_BCD2 time1(.clk(OneClk), .rst(rst), .opr_rst(opr_rst), .stop(stop1), .max(2), .min(0), .cnt(cnt1), .opr(opr1));



endmodule
