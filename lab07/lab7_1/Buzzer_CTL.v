`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/03 16:34:27
// Design Name: 
// Module Name: Buzzer_CTL
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


module Buzzer_CTL(clk, rst, div, right_audio, left_audio);
input clk, rst;
input [26:0]div;
output reg [15:0]right_audio;
output reg [15:0]left_audio;

wire b_clk;

Divider Divider0(.clk(clk), .rst(rst), .div(div), .clk_out(b_clk));

always @* begin
    if (b_clk) begin
        right_audio = 16'h7070;
        left_audio =  16'h6060;
    end else begin
        right_audio = 16'hf0f0;    
        left_audio =  16'he0e0;end
end


    
    


endmodule
