`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/15 16:56:35
// Design Name: 
// Module Name: Referesh_counter
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


module Refresh_counter(clk, rst,  ssd);
input clk;
input rst;
output reg [3:0]ssd;


always @(posedge clk or negedge rst)
    if (~rst)
        ssd <= 4'b0111;
    else begin
        ssd[2] <= ssd[3];
        ssd[1] <= ssd[2];
        ssd[0] <= ssd[1];
        ssd[3] <= ssd[0];
    end

endmodule
