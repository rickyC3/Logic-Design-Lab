`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/23 14:53:54
// Design Name: 
// Module Name: lab04_1_test
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


module lab04_1_test();
wire [3:0]cnt;
reg clk, rst;

FourBits_BinaryCnt test1(.clk(clk), .rst(rst), .cnt(cnt));
initial
begin
rst = 0;
clk = 0;
#1 rst = 1;

end 


always #5 clk = ~clk;

endmodule
