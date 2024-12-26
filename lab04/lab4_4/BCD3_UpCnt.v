`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/22 19:53:28
// Design Name: 
// Module Name: BCD3_UpCnt
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


module BCD3_UpCnt(clk, rst, inc0, inc1, inc2, cnt);
input clk;
input rst;
input inc2;
input inc1;
input inc0; // increase opr 
output reg [3:0]cnt;


always @(posedge clk or negedge rst)
    if (~rst) begin
        cnt <= 0;
    end else if (inc0 == 1 && inc1 == 1 && inc2 == 1 && cnt == 4'd9)
        cnt <= 0;
    else if (inc0 == 1 && inc1 == 1 && inc2 == 1 && cnt != 4'd9)
        cnt <= cnt + 1;
    else
        cnt <= cnt;
endmodule
