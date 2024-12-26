`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/04 10:15:40
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
input clk, rst;
output reg clk_out;

reg [25:0]cnt;

always @(posedge clk or negedge rst)
    if (~rst)
        cnt <= 1;
    else if (cnt == 26'd50000000)
        cnt <= 1;
    else
        cnt <= cnt + 1;

always @(posedge clk or negedge rst)
    if (~rst)
        clk_out <= 0;
    else if (cnt == 26'd50000000)
        clk_out <= ~clk_out;
    else
        clk_out <= clk_out;
        

endmodule
