`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/17 23:21:42
// Design Name: 
// Module Name: DATE_Mode
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


module DATE_Mode(clk, rst, mode, stop, b0long, b0short, b1long, b1short, cnt3, cnt2, cnt1, cnt0, setting, date_mode_show, date_mode_setting);
input clk, rst, b0long, b0short, b1long, b1short, stop;
input [1:0]mode;
output reg [3:0]cnt3;
output reg [3:0]cnt2;
output reg [3:0]cnt1;
output reg [3:0]cnt0;
output reg setting;
output reg date_mode_show;
output reg [1:0]date_mode_setting;

reg stop_day, stop_month, stop_year;
reg [3:0]max_day1;reg [3:0]max_day0;
wire opr_day, opr_month, opr_year;

wire [3:0]day0;
wire [3:0]day1;
wire [3:0]month0;
wire [3:0]month1;
wire [3:0]year0;
wire [3:0]year1;
wire OneClk;

reg b0long_sign;
reg b0short_sign;
reg b1long_sign;
reg b1short_sign;



_1HzClk Time0(.clk(clk), .rst(rst), .clk_out(OneClk));
Date_CNT2 Day(.clk(clk), .rst(rst), .stop(stop_day), .cnt0(day0), .cnt1(day1), .opr(opr_day), .max0(max_day0), .max1(max_day1));
Date_CNT2 Month(.clk(clk), .rst(rst), .stop(stop_month), .cnt0(month0), .cnt1(month1), .opr(opr_month), .max0(2), .max1(1));
Date_CNT Year(.clk(clk), .rst(rst), .stop(stop_year), .cnt0(year0), .cnt1(year1), .opr(opr_year));

always @*
    case(mode)
        2'b01:begin
            b0long_sign = b0long;
            b1long_sign = b1long;
            b0short_sign = b0short;
            b1short_sign = b1short;end
        default: begin
            b0long_sign = 0;
            b1long_sign = 0;
            b0short_sign = 0;
            b1short_sign = 0;end
    endcase

always @*
    case({month1, month0})
        8'b00000001, 8'b00000011, 8'b00000101, 8'b00000111, 8'b00001000, 8'b00010000, 8'b00010010: begin max_day0 = 4'b0001; max_day1 = 4'b0011;end
        8'b00000100, 8'b00000110, 8'b00001001, 8'b00010001: begin  max_day0 = 4'b0000; max_day1 = 4'b0011;end
        8'b00000010: begin max_day0 = 4'b1000; max_day1 = 4'b0010; end
        default: begin max_day0 = 4'b1000;max_day1 = 4'b0010;end
    endcase

 

always @(posedge OneClk or negedge rst)
    if (~rst)
        setting <= 0;
    else if (mode != 2'b01) // rst
        setting <= 0;
    else if (mode == 2'b01 && b0long_sign) 
        setting <= ~setting;
    else
        setting <= setting;
        
always @(posedge OneClk or negedge rst) // setting
    if (~rst)
        date_mode_setting <= 2'b00;
    else if (setting && date_mode_setting == 2'b10 && b1short_sign)
        date_mode_setting <= 2'b00;
    else if (setting && b1short_sign)
        date_mode_setting <= date_mode_setting + 1;
    else if (~setting)
        date_mode_setting <= 2'b00;
    else
        date_mode_setting <= date_mode_setting;
     
always @(posedge OneClk or negedge rst)
    if (~rst)
        date_mode_show <= 0;
    else if (~setting && b1short_sign)
        date_mode_show <= ~date_mode_show;
    else if (setting)
        date_mode_show <= 0;
    else
        date_mode_show <= date_mode_show;

always @*
    if (~setting)
        stop_day = stop;
    else if (setting && date_mode_setting == 2'b00 && b1long_sign)
        stop_day = 0;
    else if (setting && date_mode_setting == 2'b00)
        stop_day = 1;
    else if (setting && date_mode_setting != 2'b00)
        stop_day = 1;
    else
        stop_day = stop_day;

always @*
    if (~setting)
        stop_month = stop_day | ~opr_day;
    else if (setting && date_mode_setting == 2'b01 && b1long_sign)
        stop_month = 0;
    else if (setting && date_mode_setting == 2'b01)
        stop_month = 1;
    else if (setting && date_mode_setting != 2'b01)
        stop_month = 1;
    else
        stop_month = stop_month;    

always @*
    if (~setting)
        stop_year = stop_month | ~opr_month;
    else if (setting && date_mode_setting == 2'b10 && b1long_sign)
        stop_year = 0;
    else if (setting && date_mode_setting == 2'b10)
        stop_year = 1;
    else if (setting && date_mode_setting != 2'b10)
        stop_year = 1;
    else
        stop_year = stop_year; 
    
always @* begin
    cnt3 = 0;cnt2 = 0;cnt1 = 0;cnt0 = 0;
    if (setting)
        case(date_mode_setting)
            2'b10: begin
                cnt3 = 4'b1111;cnt2 = 4'b1111;cnt1 = year1; cnt0 = year0;end
            2'b00, 2'b01: begin
                cnt3 = month1;cnt2 = month0;cnt1 = day1;cnt0 = day0;end
            default: begin
                cnt3 = 4'b1111;cnt2 = 4'b1111;cnt1 = 4'b1111; cnt0 = 4'b1111;end
        endcase
    else 
        case(date_mode_show)
            1'b1: begin
                cnt3 = 4'b1111;cnt2 = 4'b1111;cnt1 = year1; cnt0 = year0;end
            1'b0: begin
                cnt3 = month1;cnt2 = month0;cnt1 = day1;cnt0 = day0;end
            default: begin
                cnt3 = 4'b1111;cnt2 = 4'b1111;cnt1 = 4'b1111; cnt0 = 4'b1111;end
    endcase     
end               

endmodule
