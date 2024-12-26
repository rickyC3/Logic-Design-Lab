`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/04 18:37:15
// Design Name: 
// Module Name: button_signCtl2
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


module button_signCtl2(clk ,rst, pb, sign);
input clk, rst, pb;
output sign;

wire _1HzClk;
wire db_out;

_1HzClk Oneclk(.clk(clk), .rst(rst), .clk_out(_1HzClk));
debounce Debounce(.clk(clk), .rst(rst), .pb(pb), .db_out(db_out));
one_pluse OnePulse(.clk(_1HzClk), .rst(rst), .trig(db_out), .sign(sign));

endmodule
