`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/05 14:28:37
// Design Name: 
// Module Name: _7SegShow
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
`define SS_d 8'b10000101 // 0000
`define SS_o 8'b11000101 // 0001
`define SS_r 8'b11110101 // 0010
`define SS_E 8'b01100001 // 0011
`define SS_m 8'b01010111 // 0100
`define SS_I 8'b10011111 // 0101
`define SS_F 8'b01110001 // 0110
`define SS_A 8'b00010001 // 0111
`define SS_S 8'b01001001 // 1000
`define SS_L 8'b11100011 // 1001
`define SS_h 8'b11010001 // 1010
`define SS_M 8'b00101011 // 1011
`define SS_H 8'b10010001 // 1100

module _7SegShow(clk, rst, alpha0, alpha1, alpha2, ssd_out, D);
input clk, rst;
input [3:0]alpha0, alpha1, alpha2;


output reg [3:0]ssd_out;
output reg [7:0]D;
wire [1:0]clk_ctl;
reg [3:0]ssd;
reg [3:0]show_alpha;



_7SegShowCTL ShowClk0(.clk(clk), .rst(rst), .clk_out(clk_ctl));

always @*
    case(clk_ctl)
        2'b00: begin ssd = 4'b1110; show_alpha = alpha0; end
        2'b01: begin ssd = 4'b1101; show_alpha = alpha1; end
        2'b10: begin ssd = 4'b1011; show_alpha = alpha2; end
        2'b11: begin ssd = 4'b0111; show_alpha = 4'b1111; end
        default: begin ssd = 4'b1111; show_alpha = 4'b1111;end
    endcase

always @*
    case(show_alpha)
        4'b0000: D = `SS_d;
        4'b0001: D = `SS_o;
        4'b0010: D = `SS_r;
        4'b0011: D = `SS_E;
        4'b0100: D = `SS_m;
        4'b0101: D = `SS_I;
        4'b0110: D = `SS_F;
        4'b0111: D = `SS_A;
        4'b1000: D = `SS_S;
        4'b1001: D = `SS_L;
        4'b1010: D = `SS_h;
        4'b1011: D = `SS_M;
        4'b1100: D = `SS_H;
        default: D = 8'b11111110;
    endcase
    
always @*
    ssd_out = ssd;

endmodule

