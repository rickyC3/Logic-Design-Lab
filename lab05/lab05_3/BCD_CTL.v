`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/04 15:50:20
// Design Name: 
// Module Name: BCD_CTL
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


module BCD_CTL(clk, init_rst, rst, stop, setting, min_sign, sec_sign, ssd, D, time_out);
input clk, setting, min_sign, init_rst, sec_sign, rst, stop;
output reg [15:0]time_out = 0;
output [3:0]ssd;
output [7:0]D;

wire _1Hzclk;
wire sec_opr0;
wire [3:0]sec_cnt0;
wire sec_opr1;
wire [3:0]sec_cnt1;

wire min_opr0;
wire [3:0]min_cnt0;
wire min_opr1;
wire [3:0]min_cnt1;

reg stop0, stop1, stop2, stop3;

_1HzClk OneHz0(.clk(clk), .rst(init_rst), .clk_out(_1Hzclk));
// sec
BCD_UpDown_Cnt Sec0(.clk(_1Hzclk), .init_rst(init_rst), .rst(rst), .stop(stop0), .setting(setting), .opr(sec_opr0), .init(0), .min(0), .max(9), .cnt(sec_cnt0));
BCD_UpDown_Cnt Sec1(.clk(_1Hzclk), .init_rst(init_rst), .rst(rst), .stop(stop1), .setting(setting), .opr(sec_opr1), .init(0), .min(0), .max(5), .cnt(sec_cnt1));

// min
BCD_UpDown_Cnt Min0(.clk(_1Hzclk), .init_rst(init_rst), .rst(rst), .stop(stop2), .setting(setting), .opr(min_opr0), .init(0), .min(0), .max(9), .cnt(min_cnt0));
BCD_UpDown_Cnt Min1(.clk(_1Hzclk), .init_rst(init_rst), .rst(rst), .stop(stop3), .setting(setting), .opr(min_opr1), .init(0), .min(0), .max(5), .cnt(min_cnt1));

Show_CTL Show_Func0(.clk(clk), .rst(init_rst), .cnt3(min_cnt1), .cnt2(min_cnt0), .cnt1(sec_cnt1), .cnt0(sec_cnt0), .ssd(ssd), .D(D));

always @* begin
    if (setting == 1 && sec_sign == 1)
        stop0 = 0;
    else if (setting == 1 && sec_sign == 0)
        stop0 = 1;
    else if (sec_cnt0 == 4'b0 && sec_cnt1 == 4'b0 && min_cnt0 == 4'b0 && min_cnt1 == 4'b0) begin
        stop0 = 1;
    end else begin
        stop0 = stop;
    end
        
    stop1 = stop0 | ~sec_opr0;             
end

always @* begin
    if (setting == 1 && min_sign == 1)
        stop2 = 0;
    else if (setting == 1 && min_sign == 0)
        stop2 = 1;
    else 
        stop2 = stop1 | ~sec_opr1;
        
    stop3 = stop2 | ~min_opr0;             
end

always @*
    if (sec_cnt0 == 4'b0 && sec_cnt1 == 4'b0 && min_cnt0 == 4'b0 && min_cnt1 == 4'b0 && ~setting)
        time_out = 16'b1111111111111111;
    else
        time_out = 0;


    
endmodule
