`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/15 13:42:29
// Design Name: 
// Module Name: top_lab03_4
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


module top_lab03_4(clk, rst, r);
input clk;
input rst;
output [7:0]r;
wire clk1Hz;

Clk1Hz U1(.clk(clk), .rst_n(rst), .clk_out(clk1Hz));
RingCnt U2(.clk(clk1Hz), .rst(rst), .r(r));


endmodule
