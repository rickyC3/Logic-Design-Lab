`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/18 21:30:16
// Design Name: 
// Module Name: Button_sign_ctl
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


module Button_sign_ctl(clk, rst, pb, bt_short_sign, bt_long_sign);
input clk, rst, pb;
output reg bt_short_sign, bt_long_sign;
reg init_rst;
wire debounce;
reg delay_debounce;
wire OneClk;
reg [1:0]cnt;
reg short_db; // short debounce
reg long_db;

_1HzClk OneCLK_bt(.clk(clk), .rst(rst), .clk_out(OneClk));
Debounce button_db(.clk(clk), .rst(rst), .pb(pb), .pb_out(debounce));


// short one pulse
always @(posedge OneClk or negedge rst)
    if (~rst)
        delay_debounce <= 0;
    else
        delay_debounce <= debounce;
        
always @(posedge OneClk or negedge rst)
    if (~rst)
        cnt <= 0;
    else if (debounce && cnt == 2'b11)
            cnt <= 2'b11;
    else if (debounce)
        cnt <= cnt + 1;
    else
        cnt <= 2'b00;
        
always @* begin
    if (cnt == 2'b11)
        bt_long_sign = 1;
    else
        bt_long_sign = 0;
    
    bt_short_sign = (~debounce) & delay_debounce & (~bt_long_sign); 
        
end

initial begin
init_rst = 1;
#1 init_rst = 0;
#1 init_rst = 1;
end

endmodule
