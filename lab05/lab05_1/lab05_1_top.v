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


module lab05_1_top(clk, rst, stop, stop_state, out, ssd, D);
input clk;
input rst;
input stop;
output stop_state;
output [14:0]out;
output [3:0]ssd;
output [7:0]D;
reg init_rst;
wire clk_out;
wire stop_sign;
wire rst_sign;
wire _1Hzclk;
wire [1:0]clk_ctl;
reg stop_state = 1;
Clk_Ctl Clk_CTL(.clk(clk), .rst(init_rst), .clk_out(clk_ctl));
_1HzClk OneHz(.clk(clk), .rst(init_rst), .clk_out(_1Hzclk));
button_sign_ctl Rst_bt(.clk(clk), .rst(init_rst), .pb(rst), .sign(rst_sign));
button_sign_ctl Stop_bt(.clk(clk), .rst(init_rst), .pb(stop), .sign(stop_sign));
_50SecDownCnt Cnt(.clk(_1Hzclk), .clk_ctl(clk_ctl), .rst(rst_sign), .stop(stop_state), .out(out), .ssd(ssd), .D(D));

initial begin
init_rst = 0;
#2 init_rst = 1;
end



always @(posedge _1Hzclk or posedge rst_sign)
    if (rst_sign)
        stop_state <= 1;
    else if (stop_sign)
        stop_state <= ~stop_state;
    else if (out == 15'b111111111111111)
        stop_state <= 1;
    else
        stop_state <= stop_state;
    

endmodule
