`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/04 11:46:57
// Design Name: 
// Module Name: one_pluse
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


module one_pluse(clk, rst, trig, sign);
input clk, rst, trig;
output reg sign;

reg trig_del;

always @(posedge clk or negedge rst)
    if (~rst)
        trig_del <= 0;
    else
        trig_del <= trig;
        
always @(posedge clk or negedge rst)
    if (~rst)
        sign <= 0;
    else
        sign <= ~trig_del & trig;

endmodule
