`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/17 14:05:15
// Design Name: 
// Module Name: Watch_mode
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


module Watch_mode(clk, rst, b0, b1, ssd, D, setting, mode_show, mode_setting, mode_led, alarm, lap_state, b0long, b0short, b1long, b1short);
input clk, rst, b0, b1; 
output b0long, b0short, b1long, b1short;
output [3:0]ssd;
output [7:0]D;
output reg setting;
output reg mode_show;
output reg [1:0]mode_setting;
output reg [3:0]mode_led;
output lap_state;
output reg alarm;
reg b0long_sign, b0short_sign, b1long_sign, b1short_sign;
reg [1:0]mode;
// error --> time_error_setting has same assign(time and date module)
wire time_mode_show;
wire [1:0]time_mode_setting;
wire date_mode_show;
wire [1:0]date_mode_setting;
wire time_setting;
wire date_setting;
wire alarm_mode_setting;
wire alarm_setting;
wire alarm_mode_show;
wire stopwatch_stop;
wire alarm_sign;

wire [3:0]time_cnt3;
wire [3:0]time_cnt2;
wire [3:0]time_cnt1;
wire [3:0]time_cnt0;
wire [3:0]date_cnt3;
wire [3:0]date_cnt2;
wire [3:0]date_cnt1;
wire [3:0]date_cnt0;
wire [3:0]alarm_cnt3;
wire [3:0]alarm_cnt2;
wire [3:0]alarm_cnt1;
wire [3:0]alarm_cnt0;
wire [3:0]stopwatch_cnt3;
wire [3:0]stopwatch_cnt2;
wire [3:0]stopwatch_cnt1;
wire [3:0]stopwatch_cnt0;

reg [3:0]show_cnt0;
reg [3:0]show_cnt1;
reg [3:0]show_cnt2;
reg [3:0]show_cnt3;

wire stop_day;
wire OneClk;
_1HzClk OneClk_watch(.clk(clk), .rst(rst), .clk_out(OneClk));
Button_sign_ctl B0(.clk(clk), .rst(rst), .pb(b0), .bt_short_sign(b0short), .bt_long_sign(b0long));
Button_sign_ctl B1(.clk(clk), .rst(rst), .pb(b1), .bt_short_sign(b1short), .bt_long_sign(b1long));

TIME_Mode Time0(.clk(clk), .rst(rst), .mode(mode), 
.b0long(b0long), .b0short(b0short), .b1long(b1long), .b1short(b1short), 
.cnt3(time_cnt3), .cnt2(time_cnt2), .cnt1(time_cnt1), .cnt0(time_cnt0),
.setting(time_setting), .time_mode_show(time_mode_show), 
.time_mode_setting(time_mode_setting), .stop(stop_day), .alarm(alarm_sign),
.alarm_hour1(alarm_cnt3), .alarm_hour0(alarm_cnt2), .alarm_min1(alarm_cnt1), 
.alarm_min0(alarm_cnt0));

Alarm_Mode Alarm0(.clk(clk), .rst(rst), .mode(mode), 
.b0long(b0long), .b0short(b0short), .b1long(b1long), .b1short(b1short), 
.cnt3(alarm_cnt3), .cnt2(alarm_cnt2), .cnt1(alarm_cnt1), 
.cnt0(alarm_cnt0), .setting(alarm_setting), 
.time_mode_setting(alarm_mode_setting), .time_mode(alarm_mode_show));

DATE_Mode Date0(.clk(clk), .rst(rst), .mode(mode),
.stop(stop_day), .b0long(b0long), .b0short(b0short), .b1long(b1long),
.b1short(b1short), .cnt3(date_cnt3), .cnt2(date_cnt2), .cnt1(date_cnt1),
.cnt0(date_cnt0), .setting(date_setting), .date_mode_show(date_mode_show), 
.date_mode_setting(date_mode_setting));

STOPWATCH_Mode STOPWATCH0(.clk(clk), .rst(rst), .stop(stopwatch_stop), 
.b0short(b0short), .b0long(b0long), .b1short(b1short), .b1long(b1long), .mode(mode), .lap_state(lap_state), 
.show_cnt3(stopwatch_cnt3), .show_cnt2(stopwatch_cnt2), .show_cnt1(stopwatch_cnt1), .show_cnt0(stopwatch_cnt0));

_7SegShow U0(.clk(clk), .rst(rst), 
.cnt3(show_cnt3), .cnt2(show_cnt2), .cnt1(show_cnt1), 
.cnt0(show_cnt0), .ssd_out(ssd), .D(D));

always @*
    case(mode)
        2'b00: begin
            show_cnt3 = time_cnt3;
            show_cnt2 = time_cnt2;
            show_cnt1 = time_cnt1;
            show_cnt0 = time_cnt0;
            mode_show = time_mode_show;
            mode_setting = time_mode_setting;
            setting = time_setting; end
        2'b01: begin
            show_cnt3 = date_cnt3;
            show_cnt2 = date_cnt2;
            show_cnt1 = date_cnt1;
            show_cnt0 = date_cnt0;
            mode_show = date_mode_show;
            mode_setting = date_mode_setting;
            setting = date_setting;end
        2'b10: begin
            show_cnt3 = alarm_cnt3;
            show_cnt2 = alarm_cnt2;
            show_cnt1 = alarm_cnt1;
            show_cnt0 = alarm_cnt0;
            mode_show = alarm_mode_show;
            mode_setting = {0,alarm_mode_setting};
            setting = alarm_setting;end
        2'b11: begin
            show_cnt3 = stopwatch_cnt3;
            show_cnt2 = stopwatch_cnt2;
            show_cnt1 = stopwatch_cnt1;
            show_cnt0 = stopwatch_cnt0;
            mode_show = 0;
            mode_setting = 0;
            setting = stopwatch_stop;end        
        default: begin
            show_cnt3 = 4'b1111;
            show_cnt2 = 4'b1111;
            show_cnt1 = 4'b1111;
            show_cnt0 = 4'b1111;
            mode_show = 0;
            mode_setting = 0;
            setting = 0;end     
    endcase
            
always @(posedge OneClk or negedge rst)
    if (~rst)
        mode <= 2'b00;
    else if (b0short && mode == 2'b11)
        mode <= 2'b00;
    else if (b0short)
        mode <= mode + 1;
    else
        mode <= mode;
always @*
    case(mode)
        2'b00: mode_led = 4'b1000;
        2'b01: mode_led = 4'b0100;
        2'b10: mode_led = 4'b0010;
        2'b11: mode_led = 4'b0001;
        default: mode_led = 4'b0000;
    endcase

// alarm
always @*
    if (alarm_setting)
        alarm = alarm_sign;
    else
        alarm = 0;

endmodule
