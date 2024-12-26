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

module _1HourStopwatch(clk, clk_ctl, init_rst, rst, stop, lap_state, ssd, D);
input clk;
input [1:0]clk_ctl;
input init_rst;
input rst;
input stop;
input lap_state;
output reg [3:0]ssd;
output reg [7:0]D;
wire [3:0]cnt0;
wire [3:0]cnt1;
wire [3:0]cnt2;
wire [3:0]cnt3;
reg [3:0]show_cnt0;
reg [3:0]show_cnt1;
reg [3:0]show_cnt2;
reg [3:0]show_cnt3;

reg [3:0]show_cnt;
wire inc;
wire inc2;
wire inc3;
wire inc4;
reg stop4;
reg stop3;
reg stop2;
reg stop1 = 1;

BCD_up_cnt C0(.clk(clk), .init_rst(init_rst), .rst(rst), .stop(stop1), .inc(inc), .init(0), .max(9), .cnt(cnt0));
BCD_up_cnt C1(.clk(clk), .init_rst(init_rst), .rst(rst), .stop(stop2), .inc(inc2), .init(0), .max(5), .cnt(cnt1));

BCD_up_cnt C2(.clk(clk), .init_rst(init_rst), .rst(rst), .stop(stop3), .inc(inc3), .init(0), .max(9), .cnt(cnt2));
BCD_up_cnt C3(.clk(clk), .init_rst(init_rst), .rst(rst), .stop(stop4), .inc(inc4), .init(0), .max(5), .cnt(cnt3));



always @* begin
    stop1 = stop;
    stop2 = ~inc | stop;
    stop3 = stop2 | ~inc2;
    stop4 = stop3 | ~inc3;
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
    case({lap_state, ssd})
        5'b11110: show_cnt = show_cnt0;
        5'b11101: show_cnt = show_cnt1;
        5'b11011: show_cnt = show_cnt2;
        5'b10111: show_cnt = show_cnt3;
        5'b01110: show_cnt = cnt0;
        5'b01101: show_cnt = cnt1;
        5'b01011: show_cnt = cnt2;
        5'b00111: show_cnt = cnt3;
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
    

always @(posedge clk or negedge rst)
    if (~rst) begin
        show_cnt0 <= 0;
        show_cnt1 <= 0;
        show_cnt2 <= 0;
        show_cnt3 <= 0;
    end else if (lap_state) begin
        show_cnt0 <= show_cnt0;
        show_cnt1 <= show_cnt1;
        show_cnt2 <= show_cnt2;
        show_cnt3 <= show_cnt3;
    end else begin
        show_cnt0 <= cnt0;
        show_cnt1 <= cnt1;
        show_cnt2 <= cnt2;
        show_cnt3 <= cnt3;
    end
        





endmodule
