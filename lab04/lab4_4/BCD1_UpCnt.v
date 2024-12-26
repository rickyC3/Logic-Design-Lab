`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/22 19:31:33
// Design Name: 
// Module Name: BCD1_DownCnt
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


module BCD1_UpCnt(clk, rst, inc0, cnt, nxt_inc1);
input clk;
input rst;
input inc0; // increase opr 
output reg nxt_inc1;
output reg [3:0]cnt;

always @*
    if (cnt == 4'd9)
        nxt_inc1 = 1;
    else
        nxt_inc1 = 0;

always @(posedge clk or negedge rst)
    if (~rst) begin
        cnt <= 0;
    end else if (inc0 == 1 && cnt == 4'd9)
        cnt <= 0;
    else if (inc0 == 1 && cnt != 4'd9)
        cnt <= cnt + 1;
    else
        cnt <= cnt;
        
    

endmodule
