`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/04 16:02:45
// Design Name: 
// Module Name: BCD2Seg
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
module BCD2Seg_Decoder(cnt, D);
input [3:0]cnt;
output reg [7:0]D;

always @*
    case(cnt)
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
