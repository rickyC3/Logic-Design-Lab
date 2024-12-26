`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/15 23:51:39
// Design Name: 
// Module Name: test_for_RingCnt
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


module test_for_RingCnt();
reg clk;
reg rst;
wire [7:0]r;
RingCnt U10(clk, rst, r);
initial
begin
clk = 0;
rst = 0;
#1 rst = 1;
end
always #1 clk = ~clk;


endmodule
