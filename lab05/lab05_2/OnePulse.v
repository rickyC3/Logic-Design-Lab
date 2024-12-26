`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/27 21:39:46
// Design Name: 
// Module Name: OnePulse
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


module OnePulse(trig, clk, rst, out_pulse);
input trig;
input clk;
input rst;
output reg out_pulse;
reg trig_del; // trig_delay 
reg nxt_pulse;

always @*
    nxt_pulse = trig & (~trig_del);

always @(posedge clk or negedge rst)
    if (~rst)
        trig_del <= 0;
    else
        trig_del <= trig;
      
always @(posedge clk or negedge rst)
    if (~rst)
        out_pulse <= 0;
    else
        out_pulse <= nxt_pulse;
        

endmodule
