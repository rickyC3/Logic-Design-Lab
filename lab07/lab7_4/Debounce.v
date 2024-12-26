`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/05 15:25:30
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


module Debounce(clk, rst, pb, db);
input clk, rst, pb;
output reg db;

reg [3:0]db_win;

always @(posedge clk or negedge rst)
    if (~rst)
        db_win <= 4'd0;
    else 
        db_win <= {pb, db_win[3:1]};
        
always @(posedge clk or negedge rst)
    if (~rst)
        db <= 0;
    else if (db_win == 4'b1111)
        db <= 1;
    else
        db <= 0;
        

endmodule
