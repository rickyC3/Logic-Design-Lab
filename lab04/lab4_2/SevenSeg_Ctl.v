`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/22 17:25:32
// Design Name: 
// Module Name: SevenSeg_Ctl
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
`define SS_A 8'b00010001
`define SS_B 8'b11000001
`define SS_C 8'b01100011
`define SS_D 8'b10000101
`define SS_E 8'b01100001
`define SS_F 8'b01110001

module SevenSeg_Ctl(cnt, seg_ctl);
input [3:0]cnt;
output reg [7:0]seg_ctl;

always @*
    case(cnt)
        4'b0000: seg_ctl = `SS_0;
        4'b0001: seg_ctl = `SS_1;
        4'b0010: seg_ctl = `SS_2;
        4'b0011: seg_ctl = `SS_3;
        4'b0100: seg_ctl = `SS_4;
        4'b0101: seg_ctl = `SS_5;
        4'b0110: seg_ctl = `SS_6;
        4'b0111: seg_ctl = `SS_7;
        4'b1000: seg_ctl = `SS_8;
        4'b1001: seg_ctl = `SS_9;
        4'b1010: seg_ctl = `SS_A;
        4'b1011: seg_ctl = `SS_B;
        4'b1100: seg_ctl = `SS_C;
        4'b1101: seg_ctl = `SS_D;
        4'b1110: seg_ctl = `SS_E;
        4'b1111: seg_ctl = `SS_F;
		default: seg_ctl = 8'b11111110;
    endcase




endmodule
