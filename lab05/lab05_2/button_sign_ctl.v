`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/27 21:53:59
// Design Name: 
// Module Name: button_sign_ctl
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


module button_sign_ctl(clk, rst, pb, sign);
input clk, rst, pb;
output sign;
wire _1Hzclk;
wire db_out;
_1HzClk U0(.clk(clk), .rst(rst), .clk_out(_1Hzclk));
Debounce U1(.clk(clk), .rst(rst), .pb(pb), .db_out(db_out));
OnePulse U2(.trig(db_out), .clk(_1Hzclk), .rst(rst), .out_pulse(sign));


endmodule
