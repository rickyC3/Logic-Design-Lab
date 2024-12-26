`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/22 16:18:02
// Design Name: 
// Module Name: _1Hz
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


module _1Hz(clk, rst, clk_out);
input clk;
input rst;
output reg clk_out;

reg [26:0]cnt;
    

always @(posedge clk or negedge rst) begin
    if (~rst) begin
        cnt <= 1;
    end else if (cnt == 27'd50000000)
        cnt <= 1;
    else
        cnt <= cnt + 1;
    
end

always @(posedge clk or negedge rst)
    if (~rst)
        clk_out <= 0;
    else if (cnt == 27'd50000000)
        clk_out <= ~clk_out;
    else
        clk_out <= clk_out;         

endmodule
