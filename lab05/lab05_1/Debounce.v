`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/27 21:30:11
// Design Name: 
// Module Name: Debounce
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


module Debounce(clk, rst, pb, db_out);
input clk;
input rst;
input pb; // push button
output reg db_out;

// use 4 bits as std
reg [3:0]db_windows;
reg nxt_bd_out;
always @(posedge clk or negedge rst)
    if (~rst)
        db_windows <= 0;
    else begin
        db_windows <= {db_windows[2:0], pb};
        // or quick format: db_windows <= {db_windows[2:0], pb};
    end
    
always @*
    if (db_windows == 4'b1111)
        nxt_bd_out = 1;
    else
        nxt_bd_out = 0;

always @(posedge clk or negedge rst)
    if (~rst)
        db_out <= 0;
    else
        db_out <= nxt_bd_out;
        

endmodule
