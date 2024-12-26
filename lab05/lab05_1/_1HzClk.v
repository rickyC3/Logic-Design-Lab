`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/03 15:14:40
// Design Name: 
// Module Name: _1HzClk
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


module _1HzClk(clk, rst, clk_out);
input clk;
input rst;
output reg clk_out;

reg [25:0]cnt_tmp;
reg [25:0]cnt = 1;

always @*
    cnt_tmp = cnt + 1;

always @(posedge clk or negedge rst)
    if (~rst)
        cnt <= 1;
    else if (cnt == 26'd50000000)
        cnt <= 1;
    else
        cnt <= cnt_tmp;
      
        
always @(posedge clk or negedge rst)
    if (~rst)
        clk_out <= 0;
    else if (cnt == 27'd50000000)
        clk_out <= ~clk_out;
    else
        clk_out <= clk_out;

endmodule
