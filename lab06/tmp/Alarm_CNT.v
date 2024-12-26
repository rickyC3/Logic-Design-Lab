`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/18 03:17:01
// Design Name: 
// Module Name: Alarm_CNT
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


module Alarm_Mode(clk, rst, mode, b0long, b0short, b1long, b1short, cnt3, cnt2, cnt1, cnt0, setting, time_mode_setting, time_mode);
input clk, rst, b0long, b0short, b1long, b1short;
input [1:0]mode;

output [3:0]cnt3;
output [3:0]cnt2;
output [3:0]cnt1;
output [3:0]cnt0;

output reg setting, time_mode_setting, time_mode;
wire OneClk;
wire opr_min, opr_hour;
reg stop_min, stop_hour;
reg b0long_sign, b0short_sign, b1long_sign, b1short_sign;


_1HzClk Time1(.clk(clk), .rst(rst), .clk_out(OneClk));
Time_CNT Minalarm(.clk(clk), .rst(rst), .stop(stop_min), .cnt0(cnt0), .cnt1(cnt1), .opr(opr_min));
Time_CNT2 Houralarm(.clk(clk), .rst(rst), .stop(stop_hour), .cnt0(cnt2), .cnt1(cnt3), .opr(opr_hour), .max0(4), .max1(2));

always @*
    if (b0short) begin
        b0long_sign = 0;
        b0short_sign = 1;
        b1long_sign = 0;
        b1short_sign = 0;
    end else if (b0long) begin
        b0long_sign = 1;
        b0short_sign = 0;
        b1long_sign = 0;
        b1short_sign = 0;
    end else if (b1short) begin
        b0long_sign = 0;
        b0short_sign = 0;
        b1long_sign = 0;
        b1short_sign = 1;
    end else if (b1long)begin
        b0long_sign = 0;
        b0short_sign = 0;
        b1long_sign = 1;
        b1short_sign = 0;
    end else begin
        b0long_sign = 0;
        b0short_sign = 0;
        b1long_sign = 0;
        b1short_sign = 0;
    end

always @(posedge OneClk or negedge rst)
    if (~rst)
        setting <= 0;
    else if (mode != 2'b10)
        setting <= 0;
    else if (mode == 2'b10 && b0long_sign)
        setting <= ~setting;
    else
        setting <= setting;
        
always @(posedge OneClk or negedge rst)
    if (~rst)
        time_mode_setting <= 0; // 0: setting hour, 1: setting min
    else if (!setting)
        time_mode_setting <= 0;
    else if (setting && b1short_sign)
        time_mode_setting <= ~time_mode_setting;
    else
        time_mode_setting <= time_mode_setting;

always @*
    if (setting && ~time_mode_setting && b1long_sign)
        stop_hour = 0;
    else
        stop_hour = 1;
        
always @*
    if (setting && time_mode_setting && b1long_sign)
        stop_min = 0;
    else
        stop_min = 1;
always @*
    time_mode = 0;
    
    
endmodule
