`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/22 18:00:36
// Design Name: 
// Module Name: BCD_to_7segDec
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

module BCD_to_7segDec(cnt, seg_ctl);
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
        default: seg_ctl = 8'b11111110;
    endcase

endmodule
