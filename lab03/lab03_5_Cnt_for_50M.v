`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/15 16:45:31
// Design Name: 
// Module Name: Cnt_for_50M
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


module Cnt_for_50M(clk, rst, cnt_out);
input clk;
input rst;
output [25:0]cnt_out; // 50M --> 10111110101111000010000000
reg [25:0]cnt_out;
reg [25:0]cnt_tmp;

always @* begin
    cnt_tmp = cnt_out + 1;
end

always @(posedge clk or negedge rst) begin
    if (~rst) begin
        cnt_out <= 1;
    end else if (cnt_out == 26'd50000000) begin
        cnt_out <= 1;
    end else
        cnt_out <= cnt_tmp;
end
endmodule
