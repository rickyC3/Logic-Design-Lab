`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/03 19:38:04
// Design Name: 
// Module Name: BCD_down_cnt
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


module BCD_up_cnt(clk, init_rst, rst, stop, inc, max, init, cnt);
input clk;
input rst;
input stop;
input init_rst;
input [3:0]init;
input [3:0]max;
output reg inc;
output reg [3:0]cnt;

always @*
    if (cnt == max)
        inc = 1;
    else
        inc = 0;

always @(posedge clk or negedge init_rst)
    if (~init_rst || ~rst)
        cnt <= init;
    else if (~stop&& cnt == max)
        cnt <= 4'b0000;
    else if (~stop)
        cnt <= cnt + 1;
    else
        cnt <= cnt; 
        

endmodule
