`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/14 20:13:51
// Design Name: 
// Module Name: lab03_2_top
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


module lab03_2_top(clk, rst_n, clk_out);//, cnt50M_o);//, cnt50M_o for debug
input clk;
input rst_n;
output reg clk_out = 0;
//output reg [25:0]cnt50M_o;
wire [25:0]cnt50M;




Counter_for_50M U0(.clk(clk), .rst(rst_n), .cnt_out(cnt50M));


always @(posedge clk or negedge rst_n) begin
    if (~rst_n)
        clk_out <= 0;
    else if (cnt50M == 26'd50000000)begin
        clk_out <= ~clk_out;
    end else
        clk_out <= clk_out;
    //cnt50M_o = cnt50M;
end


    

endmodule
