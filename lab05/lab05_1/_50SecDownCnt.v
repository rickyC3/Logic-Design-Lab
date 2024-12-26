`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/26 08:02:25
// Design Name: 
// Module Name: _50SecDownCnt
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

module _50SecDownCnt(clk, clk_ctl, rst, stop, out, ssd, D);
input clk;
input [1:0]clk_ctl;
input rst;
input stop;
output reg [14:0]out = 0;
output reg [3:0]ssd;
output reg [7:0]D;
wire [3:0]cnt0;
wire [3:0]cnt1;
reg [3:0]show_cnt;
wire dec;
wire dec2;
reg stop2;
reg stop1;

BCD_down_cnt C0(.clk(clk), .rst(rst), .stop(stop1), .dec(dec), .init(0), .cnt(cnt0));
BCD_down_cnt C1(.clk(clk), .rst(rst), .stop(stop2), .dec(dec2), .init(5), .cnt(cnt1));

always @*
    if (stop1 == 1)
        stop2 = 1;
    else if (dec == 0)
        stop2 = 1;
    else
        stop2 = 0;
 
always @* begin
    if (cnt0 == 0 && cnt1 == 0) begin
        out = 15'b1111111111111111;
        stop1 = 1;
    end else begin
        out = 0;
        stop1 = stop;
end
end

always @*
    case(clk_ctl)
        2'b00: ssd = 4'b1110;
        2'b01: ssd = 4'b1101;
        2'b10: ssd = 4'b1011;
        2'b11: ssd = 4'b0111;
        default: ssd = 4'b1111;
    endcase

always @*
    case(ssd)
        4'b1110: show_cnt = cnt0;
        4'b1101: show_cnt = cnt1;
        default: show_cnt = 4'b0000;
    endcase
    
always @*
    case(show_cnt)
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
