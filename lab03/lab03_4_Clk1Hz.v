`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/15 13:39:00
// Design Name: 
// Module Name: Clk1Hz
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


module Clk1Hz(clk, rst_n, clk_out);//, cnt50M_o);//, cnt50M_o for debug
input clk;
input rst_n;
output reg clk_out = 0;
//output reg [25:0]cnt50M_o;
wire [25:0]cnt50M;


cnt_for_50M U0(.clk(clk), .rst(rst_n), .cnt_out(cnt50M));


always @(posedge clk or negedge rst_n)
    if (~rst_n)
        clk_out <= 0;
    else if (cnt50M == 26'd50000000)
        clk_out = ~clk_out;
    else
        clk_out = clk_out;
    
endmodule
