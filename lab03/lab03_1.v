`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/14 19:32:41
// Design Name: 
// Module Name: lab03_1
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


module lab03_1(clk, clk_out, rst);
input clk;
output clk_out;
input rst;
reg clk_out;
reg [25:0]cnt;
reg [26:0]cnt_tmp;

always @* begin
    cnt_tmp = {clk_out, cnt} + 1;
end

always @(posedge clk or negedge rst) begin
    if (~rst) begin
        clk_out <= 0;
        cnt <= 0;
    end else
        {clk_out, cnt} <= cnt_tmp;
end

endmodule
