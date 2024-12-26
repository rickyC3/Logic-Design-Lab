`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/15 16:47:25
// Design Name: 
// Module Name: Ring_Counter
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

/*
000 N
001 T
010 H
011 U
100 E
101 2
110 0
111 3
*/

module Ring_Counter(clk, rst, D);
input clk;
input rst;
output reg [11:0]D;
reg [29:0]r;
always @*
    D = r[29:18];

always @(posedge clk or negedge rst)
    if (~rst)
        r <= 30'b000001010011100100101110101111;
    else begin
        r[2:0] <= r[29:27];
        r[5:3] <= r[2:0];
        r[8:6] <= r[5:3];
        r[11:9] <= r[8:6];
        r[14:12] <= r[11:9];
        r[17:15] <= r[14:12];
        r[20:18] <= r[17:15];
        r[23:21] <= r[20:18];
        r[26:24] <= r[23:21];
        r[29:27] <= r[26:24];
    end
        

endmodule
