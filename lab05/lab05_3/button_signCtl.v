`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/04 11:56:09
// Design Name: 
// Module Name: button_signCtl
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


module button_signCtl(clk ,rst, pb, sign);
input clk, rst, pb;
output sign;

wire _1HzClk;
wire db_out;

_1HzClk Oneclk(.clk(clk), .rst(rst), .clk_out(_1HzClk));
debounce Debounce(.clk(clk), .rst(rst), .pb(pb), .db_out(sign));
//one_pluse OnePulse(.clk(_1HzClk), .rst(rst), .trig(pb), .sign(sign));


endmodule
