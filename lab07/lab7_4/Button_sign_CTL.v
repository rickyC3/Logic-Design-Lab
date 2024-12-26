`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/05 15:26:01
// Design Name: 
// Module Name: Button_sign_CTL
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


module Button_sign_CTL(clk, rst, pb, pb_sign);
input clk, rst, pb;
output pb_sign;
wire db_sign;
wire TwoClk;
reg delay_db_sign;


Debounce DB(.clk(clk), .rst(rst), .pb(pb), .db(pb_sign));



endmodule
