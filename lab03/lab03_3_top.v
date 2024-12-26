`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/15 13:24:13
// Design Name: 
// Module Name: top_lab03_3
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


module top_lab03_3(clk, rst, q);
input clk;
input rst;
output [3:0]q;
wire clk1Hz;

lab03_2_top U1(.clk(clk), .rst_n(rst), .clk_out(clk1Hz));
counter(.clk(clk1Hz), .rst(rst), .q(q));


endmodule
