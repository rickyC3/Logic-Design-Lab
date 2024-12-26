`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/03 16:47:38
// Design Name: 
// Module Name: Test_Speaker
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


module Test_Speaker();
reg clk, rst;
wire MCLK, LRCK, SCK, Stdin;
wire[15:0]left_audio, right_audio;
wire [3:0]cnt;

Speaker U0(.clk(clk), .rst(rst), .MCLK(MCLK), .LRCK(LRCK), .SCK(SCK), .Stdin(Stdin),  
.left_audio(left_audio), .right_audio(right_audio), .cnt(cnt));

initial begin
rst = 1;
clk = 0;
#1 rst = 0;
#2 rst = 1;

end

always #3 clk = ~clk;




endmodule
