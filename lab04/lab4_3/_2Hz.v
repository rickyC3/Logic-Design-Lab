`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/22 17:53:25
// Design Name: 
// Module Name: _2Hz
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


module _2Hz(clk, rst, clk_out);
input clk;
input rst;
output reg clk_out;

reg [24:0]cnt;


always @(posedge clk or negedge rst)
    if (~rst)
        cnt <= 1;
    else if ({clk_out, cnt} == 25'd25000000)
       cnt <= 1;
    else
       cnt <= cnt + 1;
        
always @(posedge clk or negedge rst)
    if (~rst)
        clk_out <= 0;
    else if (cnt == 25'd25000000)
        clk_out <= ~clk_out;
    else 
        clk_out <= clk_out;
    
    
        
       

endmodule
