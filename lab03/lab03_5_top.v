`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/15 17:10:42
// Design Name: 
// Module Name: top_lab03_5
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


module top_lab03_5(clk, rst, ssd, D);
input clk;
input rst;
output [3:0]ssd;
output [7:0]D;

wire clk1Hz;
wire clk_ctl;
wire [11:0]d;

Clk1Hz U1(clk, rst, clk1Hz);
clk_ctl U2(clk, rst, clk_ctl);

Ring_Counter U3(clk1Hz, rst, d);
Refresh_counter U4(clk_ctl, rst, ssd);
Show U5(ssd, d, D);

endmodule
