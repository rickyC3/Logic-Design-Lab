`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/04 16:05:19
// Design Name: 
// Module Name: Show_CTL
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


module Show_CTL(clk, rst, cnt3, cnt2, cnt1, cnt0, ssd, D);
input clk, rst;
input [3:0]cnt3;
input [3:0]cnt2;
input [3:0]cnt1;
input [3:0]cnt0;
output reg [3:0]ssd;
output [7:0]D;

wire [1:0]clk_ctl;
reg [3:0]show_cnt;
Show_Clk ClkCtl(.clk(clk), .rst(rst), .clk_out(clk_ctl));

always @*
    case(clk_ctl)
        2'b00: ssd = 4'b1110;
        2'b01: ssd = 4'b1101;
        2'b10: ssd = 4'b1011;
        2'b11: ssd = 4'b0111; // the left one
        default: ssd = 4'b1111; // error, all light off
     endcase

always @*
    case(ssd)
        4'b1110: show_cnt = cnt0;
        4'b1101: show_cnt = cnt1;
        4'b1011: show_cnt = cnt2;
        4'b0111: show_cnt = cnt3;
        default: show_cnt = 4'b1111;
    endcase

BCD2Seg_Decoder Dec0(.cnt(show_cnt), .D(D));


endmodule
