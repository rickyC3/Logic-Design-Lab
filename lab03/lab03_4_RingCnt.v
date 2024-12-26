`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/15 13:39:49
// Design Name: 
// Module Name: RingCnt
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


module RingCnt(clk, rst, r);
input clk;
input rst;
output reg [7:0]r;

always @(posedge clk or negedge rst)
    if (~rst)
        r <= 8'b01101110;
    else begin
        r[0] <= r[7];
        r[1] <= r[0];
        r[2] <= r[1];
        r[3] <= r[2];
        r[4] <= r[3];
        r[5] <= r[4];
        r[6] <= r[5];
        r[7] <= r[6];
    end

endmodule
