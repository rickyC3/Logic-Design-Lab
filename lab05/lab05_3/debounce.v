`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/04 11:37:45
// Design Name: 
// Module Name: debounce
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


module debounce(clk, rst, pb, db_out);
input clk, rst, pb;
output reg db_out;

// 4 bit windows
reg [3:0]bd_windows;
reg nxt_bd;

always @*
    if (bd_windows == 4'b1111)
        nxt_bd = 1;
    else
        nxt_bd = 0;
        

always @(posedge clk or negedge rst)
    if (~rst)
        bd_windows <= 4'd0;
    else
        bd_windows <= {pb, bd_windows[3:1]}; 
    
always @(posedge clk or negedge rst)
    if (~rst)
        db_out <= 0;
    else
        db_out <= nxt_bd;
    


endmodule
