`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/17 10:14:59
// Design Name: 
// Module Name: TIME_Mode
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


module TIME_Mode(clk, rst, mode, b0long, b0short, b1long, b1short, cnt3, cnt2, cnt1, cnt0, setting, time_mode_show, time_mode_setting, opr, alarm, alarm_min0, alarm_min1, alarm_hour1, alarm_hour0);
input clk, rst, b0long, b0short, b1long, b1short;
input [1:0]mode;
input [3:0]alarm_min0;
input [3:0]alarm_min1;
input [3:0]alarm_hour0;
input [3:0]alarm_hour1;
output reg alarm;
output reg [3:0]cnt3;
output reg [3:0]cnt2;
output reg [3:0]cnt1;
output reg [3:0]cnt0;
output reg setting;
output reg time_mode_show;
output reg [1:0]time_mode_setting;
output reg opr;
reg stop_sec, stop_min, stop_hour;
wire opr_sec, opr_min, opr_hour;

wire [3:0]sec0;
wire [3:0]sec1;
wire [3:0]min0;
wire [3:0]min1;
wire [3:0]hour0;
wire [3:0]hour1;
wire OneClk;

reg b0long_sign;
reg b0short_sign;
reg b1long_sign;
reg b1short_sign;

_1HzClk Time0(.clk(clk), .rst(rst), .clk_out(OneClk));
Time_CNT Sec(.clk(clk), .rst(rst), .stop(stop_sec), .cnt0(sec0), .cnt1(sec1), .opr(opr_sec));
Time_CNT Min(.clk(clk), .rst(rst), .stop(stop_min), .cnt0(min0), .cnt1(min1), .opr(opr_min));
Time_CNT2 Hour(.clk(clk), .rst(rst), .stop(stop_hour), .cnt0(hour0), .cnt1(hour1), .opr(opr_hour), .max0(4), .max1(2));

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
    else if (mode != 2'b00) // rst
        setting <= 0;
    else if (mode == 2'b00 && b0long_sign) 
        setting <= ~setting;
    else
        setting <= setting;
        
always @(posedge OneClk or negedge rst) // setting
    if (~rst)
        time_mode_setting <= 2'b00;
    else if (setting && time_mode_setting == 2'b10 && b1short_sign)
        time_mode_setting <= 2'b00;
    else if (setting && b1short)
        time_mode_setting <= time_mode_setting + 1;
    else if (~setting)
        time_mode_setting <= 2'b00;
    else
        time_mode_setting <= time_mode_setting;
     
always @(posedge OneClk or negedge rst)
    if (~rst)
        time_mode_show <= 0;
    else if (~setting && b1short_sign)
        time_mode_show <= ~time_mode_show;
    else if (setting)
        time_mode_show <= 0;
    else
        time_mode_show <= time_mode_show;

always @*
    if (~setting)
        stop_sec = 0;
    else if (setting && time_mode_setting == 2'b10 && b1long_sign)
        stop_sec = 0;
    else if (setting && time_mode_setting == 2'b10)
        stop_sec = 1;
    else if (setting && time_mode_setting != 2'b10)
        stop_sec = 1;
    else
        stop_sec = stop_sec;

always @*
    if (~setting)
        stop_min = stop_sec | ~opr_sec;
    else if (setting && time_mode_setting == 2'b01 && b1long_sign)
        stop_min = 0;
    else if (setting && time_mode_setting == 2'b01)
        stop_min = 1;
    else if (setting && time_mode_setting != 2'b01)
        stop_min = 1;
    else
        stop_min = stop_min;    

always @*
    if (~setting)
        stop_hour = stop_min | ~opr_min;
    else if (setting && time_mode_setting == 2'b00 && b1long_sign)
        stop_hour = 0;
    else if (setting && time_mode_setting == 2'b00)
        stop_hour = 1;
    else if (setting && time_mode_setting != 2'b00)
        stop_hour = 1;
    else
        stop_hour = stop_hour;

always @*
    opr = opr_hour & opr_min & opr_sec;


always @* begin
    cnt3 = 0;cnt2 = 0;cnt1 = 0;cnt0 = 0;
    if (setting)
        case(time_mode_setting)
            2'b10: begin
                cnt3 = 4'b1111;cnt2 = 4'b1111;cnt1 = sec1; cnt0 = sec0;end
            2'b00, 2'b01: begin
                cnt3 = hour1;cnt2 = hour0;cnt1 = min1;cnt0 = min0;end
            default: begin
                cnt3 = 4'b1111;cnt2 = 4'b1111;cnt1 = 4'b1111; cnt0 = 4'b1111;end
        endcase
    else 
        case(time_mode_show)
            1'b1: begin
                cnt3 = 4'b1111;cnt2 = 4'b1111;cnt1 = sec1; cnt0 = sec0;end
            1'b0: begin
                cnt3 = hour1;cnt2 = hour0;cnt1 = min1;cnt0 = min0;end
            default: begin
                cnt3 = 4'b1111;cnt2 = 4'b1111;cnt1 = 4'b1111; cnt0 = 4'b1111;end
        endcase      
end               

always @*
    if (alarm_hour0 == hour0 && alarm_hour1 == hour1 && alarm_min0 == min0
        && alarm_min1 == min1)
        alarm = 1;
    else
        alarm = 0;
        

endmodule
