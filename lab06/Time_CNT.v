`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/17 09:40:21
// Design Name: 
// Module Name: Time_CNT
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


module Time_CNT(clk, rst, stop, cnt0, cnt1, opr);
input clk, rst, stop;
output [3:0]cnt0;
output [3:0]cnt1;
output reg opr;

wire OneClk;
wire opr0, opr1;
reg stop0, stop1;
always @*
    opr = opr1 & opr0;

always @* begin
    stop0 = stop;
    stop1 = stop0 | ~opr0;
end
_1HzClk OneCLK0(.clk(clk), .rst(rst), .clk_out(OneClk));
Time_BCD time0(.clk(OneClk), .rst(rst), .stop(stop0), .max(9), .min(0), .cnt(cnt0), .opr(opr0));
Time_BCD time1(.clk(OneClk), .rst(rst), .stop(stop1), .max(5), .min(0), .cnt(cnt1), .opr(opr1));

endmodule
