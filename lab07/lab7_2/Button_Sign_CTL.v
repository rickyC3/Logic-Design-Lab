`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/03 17:10:19
// Design Name: 
// Module Name: Button_Sign_CTL
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


module Button_Sign_CTL(clk, rst, pb, pb_sign);
input clk, rst, pb;
output pb_sign;
wire db_sign;
wire TwoClk;
reg delay_db_sign;

//_2HzClk ONECLK0(.clk(clk), .rst(rst), .clk_out(TwoClk));
Debounce DB(.clk(clk), .rst(rst), .pb(pb), .db(pb_sign));



endmodule
