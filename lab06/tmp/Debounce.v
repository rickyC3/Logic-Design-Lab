`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/18 21:24:44
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


module Debounce(clk, rst, pb, pb_out);
input clk, rst, pb;
output reg pb_out;

reg [3:0]db_win = 0;
reg nxt_db;
always @(posedge clk or negedge rst)
    if (~rst)
        db_win <= 4'b0000;
    else    
        db_win <= {pb, db_win[3:1]};

always @*
    if (db_win == 4'b1111)
        nxt_db = 1;
    else
        nxt_db = 0;

always @(posedge clk or negedge rst)
    if (~rst)
        pb_out <= 0;
    else
        pb_out <= nxt_db;

endmodule
