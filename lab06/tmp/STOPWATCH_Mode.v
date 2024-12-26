`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/18 20:11:17
// Design Name: 
// Module Name: STOPWATCH_Mode
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


module STOPWATCH_Mode(clk, rst, stop, b0short, b0long, b1short, b1long, mode, lap_state, show_cnt3, show_cnt2, show_cnt1, show_cnt0);
input clk;
input rst, b0long, b0short, b1long, b1short;
output reg stop;
input [1:0]mode;
output reg lap_state;
wire [3:0]sec0;
wire [3:0]sec1;
wire [3:0]min0;
wire [3:0]min1;
output reg [3:0]show_cnt0;
output reg [3:0]show_cnt1;
output reg [3:0]show_cnt2;
output reg [3:0]show_cnt3;
reg rst_opr;
reg [3:0]lap_cnt0;
reg [3:0]lap_cnt1;
reg [3:0]lap_cnt2;
reg [3:0]lap_cnt3;

wire opr0;
wire opr1;
wire opr2;
wire opr3;
wire OneClk;

reg stop3;
reg stop2;
reg stop1;
reg stop0 = 1;

_1HzClk OneCLK_STOP(.clk(clk), .rst(rst), .clk_out(OneClk));
Time_BCD Sec0(.clk(OneClk), .rst(rst_opr & rst), .stop(stop0), .max(9), .min(0), .cnt(sec0), .opr(opr0));
Time_BCD Sec1(.clk(OneClk), .rst(rst_opr & rst), .stop(stop1), .max(5), .min(0), .cnt(sec1), .opr(opr1));
Time_BCD Min0(.clk(OneClk), .rst(rst_opr & rst), .stop(stop2), .max(9), .min(0), .cnt(min0), .opr(opr2));
Time_BCD Min1(.clk(OneClk), .rst(rst_opr & rst), .stop(stop3), .max(5), .min(0), .cnt(min1), .opr(opr3));

always @(posedge OneClk or negedge rst)
    if (~rst | ~rst_opr)
        stop <= 1;
    else if (mode == 2'b11 && b1short && ~b0long)
        stop <= ~stop;
    else
        stop <= stop;

always @(posedge OneClk or negedge rst)
    if (~rst | ~rst_opr)
        lap_state <= 0;
    else if (mode == 2'b11 && ~stop && b1short && b0long)
        lap_state <= ~lap_state;
    else if (mode == 2'b11 && stop && b1short && b0long)
        lap_state <= 0;
    else
        lap_state <= lap_state;
always @(posedge OneClk or negedge rst)
    if (~rst)
        rst_opr <= 1;
    else if (~rst_opr)
        rst_opr <= 1;
    else if (mode == 2'b11 && b1long && rst_opr)
        rst_opr <= 0;
    else
        rst_opr <= rst_opr;
        
    
always @* begin
    stop0 = stop;
    stop1 = ~opr0 | stop0;
    stop2 = stop1 | ~opr1;
    stop3 = stop2 | ~opr2;
end
 

always @*
    case(lap_state)
        1'b1: begin
            show_cnt3 = lap_cnt3;
            show_cnt2 = lap_cnt2;
            show_cnt1 = lap_cnt1;
            show_cnt0 = lap_cnt0;end
        1'b0: begin
            show_cnt3 = min1;
            show_cnt2 = min0;
            show_cnt1 = sec1;
            show_cnt0 = sec0;end         
        default: begin
            show_cnt3 = 4'b1111;
            show_cnt2 = 4'b1111;
            show_cnt1 = 4'b1111;
            show_cnt0 = 4'b1111;end      
        
    endcase
    


always @(posedge OneClk or negedge rst)
    if (~rst) begin
        lap_cnt0 <= 0;
        lap_cnt1 <= 0;
        lap_cnt2 <= 0;
        lap_cnt3 <= 0;
    end else if (lap_state) begin
        lap_cnt0 <= lap_cnt0;
        lap_cnt1 <= lap_cnt1;
        lap_cnt2 <= lap_cnt2;
        lap_cnt3 <= lap_cnt3;
    end else begin
        lap_cnt0 <= sec0;
        lap_cnt1 <= sec1;
        lap_cnt2 <= min0;
        lap_cnt3 <= min1;
    end
        





endmodule
