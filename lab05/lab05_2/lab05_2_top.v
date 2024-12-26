`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/26 08:08:33
// Design Name: 
// Module Name: lab05_1_top
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


module lab05_2_top(clk, st_sp, lap, stop_state, lap_state, ssd, D);
input clk;
input st_sp; // start, stop
input lap; // lap
output stop_state;
output lap_state;
output [3:0]ssd;
output [7:0]D;
reg init_rst = 0;
wire clk_out;
wire stsp_sign;
wire lap_sign;
wire _1Hzclk;
wire [1:0]clk_ctl;
reg stop_state = 1;
reg lap_state;
reg rst = 1;

Clk_Ctl Clk_CTL(.clk(clk), .rst(init_rst), .clk_out(clk_ctl));
_1HzClk OneHz(.clk(clk), .rst(init_rst), .clk_out(_1Hzclk));
button_sign_ctl start_bt(.clk(clk), .rst(init_rst), .pb(st_sp), .sign(stsp_sign));
button_sign_ctl lap_bt(.clk(clk), .rst(init_rst), .pb(lap), .sign(lap_sign));
_1HourStopwatch Cnt(.clk(_1Hzclk), .clk_ctl(clk_ctl), .init_rst(init_rst), .rst(rst), .stop(stop_state), .lap_state(lap_state), .ssd(ssd), .D(D));

        

always @(posedge _1Hzclk or negedge init_rst)
    if (~init_rst)
        stop_state <= 1;
    else if (stsp_sign)
        stop_state <= ~stop_state;
    else
        stop_state <= stop_state;

always @(posedge _1Hzclk or negedge init_rst)
    if (~init_rst)
        lap_state <= 0;
    else if ( (~stop_state) && (lap_sign))
        lap_state <= ~lap_state;
    else
        lap_state <= lap_state;
        
always @(posedge _1Hzclk or negedge init_rst)
    if (~init_rst)
        rst <= 1;
    else if ((lap_sign) && (stop_state)) begin
        rst <= 0;
    end else 
        rst <= 1;



initial
begin
init_rst = 0;
#2 init_rst = 1;
end


endmodule
