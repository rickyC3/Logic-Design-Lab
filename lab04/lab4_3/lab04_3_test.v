`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/23 15:51:12
// Design Name: 
// Module Name: lab04_3_test
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


module lab04_3_test();
reg clk, rst;
wire [3:0]cnt;

BCD_DownCnt test2(.clk(clk), .rst(rst), .cnt(cnt));
initial
begin
clk = 0;
rst = 0;
#1 rst = 1;
end

always #5 clk = ~clk;
endmodule
