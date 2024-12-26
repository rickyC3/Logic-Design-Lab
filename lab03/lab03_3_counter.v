`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/15 06:20:07
// Design Name: 
// Module Name: counter
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


module counter(clk, rst, q);
input clk;
input rst;
output reg [3:0]q;
reg [3:0]cnt_tmp;


always @* begin
    cnt_tmp = q + 4'b0001;
end
always @(posedge clk or negedge rst)
    if(~rst) 
        q <= 0;
    else
        q <= cnt_tmp;

endmodule
