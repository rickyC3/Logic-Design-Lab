`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/23 17:28:19
// Design Name: 
// Module Name: lab04_4_test
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


module lab04_4_test();
reg clk, rst;
wire [3:0]cnt0;wire [3:0]cnt1;wire [3:0]cnt2;wire [3:0]cnt3;
wire inc0, inc1, inc2;

BCD0_UpCnt test30(.clk(clk), .rst(rst), .cnt(cnt0), .nxt_inc0(inc0));
BCD1_UpCnt test31(.clk(clk), .rst(rst), .cnt(cnt1), .inc0(inc0), .nxt_inc1(inc1));
BCD2_UpCnt test32(.clk(clk), .rst(rst), .cnt(cnt2), .inc0(inc0), .inc1(inc1), .nxt_inc2(inc2));
BCD3_UpCnt test33(.clk(clk), .rst(rst), .cnt(cnt3), .inc0(inc0), .inc1(inc1), .inc2(inc2));

initial
begin
clk = 0;
rst = 0;
#1 rst = 1;
end

always #5 clk = ~clk;

endmodule
