`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/22 19:58:32
// Design Name: 
// Module Name: SegShow_Ctl
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
`define SS_0 8'b00000011
`define SS_1 8'b10011111
`define SS_2 8'b00100101
`define SS_3 8'b00001101
`define SS_4 8'b10011001
`define SS_5 8'b01001001
`define SS_6 8'b01000001
`define SS_7 8'b00011111
`define SS_8 8'b00000001
`define SS_9 8'b00001001


module SegShow_Ctl(seg_ctl, cnt0, cnt1, cnt2, cnt3, ssd, D);
input [1:0]seg_ctl;
input [3:0]cnt0;
input [3:0]cnt1;
input [3:0]cnt2;
input [3:0]cnt3;
output reg [3:0]ssd;
output reg [7:0]D;
reg [3:0]show_num;

always @*
    case(seg_ctl)
        2'b00: ssd = 4'b0111;
        2'b01: ssd = 4'b1011;
        2'b10: ssd = 4'b1101;
        2'b11: ssd = 4'b1110;
    default: ssd = 4'b1111;
    endcase

always @*
    case(ssd)
        4'b0111: show_num = cnt3;
        4'b1011: show_num = cnt2;
        4'b1101: show_num = cnt1;
        4'b1110: show_num = cnt0;
    default: show_num = 4'b1111;
    endcase
    
always @*
    case(show_num)
        4'd0: D = `SS_0;
        4'd1: D = `SS_1;
        4'd2: D = `SS_2;
        4'd3: D = `SS_3;
        4'd4: D = `SS_4;
        4'd5: D = `SS_5;
        4'd6: D = `SS_6;
        4'd7: D = `SS_7;
        4'd8: D = `SS_8;
        4'd9: D = `SS_9;
    default: D = 8'b11111110;
    endcase

endmodule
