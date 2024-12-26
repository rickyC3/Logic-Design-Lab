`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/17 23:16:01
// Design Name: 
// Module Name: Date_BCD
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


module Date_BCD(clk, rst, stop, max, min, cnt, opr); // up counter
input clk, rst, stop;
input [3:0]max;
input [3:0]min;
output reg [3:0]cnt;
output reg opr;

always @*
    if (cnt == max)
        opr = 1;
    else
        opr = 0;

always @(posedge clk or negedge rst)
    if (~rst)
        cnt <= 0;
    else if (stop)
        cnt <= cnt;
    else if (~stop && cnt == max)
        cnt <= min;
    else if (~stop && cnt != max)
        cnt <= cnt + 1;
    else
        cnt <= cnt;

endmodule
