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


module BCD_down_cnt(clk, rst, stop, dec, init, cnt);
input clk;
input rst;
input stop;
input [3:0]init;
output reg dec;
output reg [3:0]cnt;

always @*
    if (cnt == 4'd0)
        dec = 1;
    else
        dec = 0;

always @(posedge clk or posedge rst)
    if (rst)
        cnt <= init;
    else if (stop == 0 && cnt == 4'b0000)
        cnt <= 4'b1001;
    else if (stop == 0)
        cnt <= cnt - 1;
    else
        cnt <= cnt; 
        

endmodule
