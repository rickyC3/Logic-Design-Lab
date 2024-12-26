`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/05 13:49:24
// Design Name: 
// Module Name: Buzzer
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


module Buzzer(clk, rst, div, right_audio, left_audio);
input clk, rst;
input [26:0]div;
output [15:0]right_audio, left_audio;

wire fre_div;
Divider Music(.clk(clk), .rst(rst), .div(div), .clk_out(fre_div));

assign right_audio = (!fre_div)? 16'hde01:16'h21ff;
assign left_audio = (!fre_div)? 16'hde01:16'h21ff;

endmodule
