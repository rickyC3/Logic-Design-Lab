`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/15 21:30:44
// Design Name: 
// Module Name: test_4BitsCounter
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


module test_4BitsCounter();
reg clk;
reg rst;
wire [3:0]q;

counter U1(clk, rst, q);
initial
begin
clk = 0;
rst = 0;
#1 rst = 1;
end
always #1 clk = ~clk;

endmodule
