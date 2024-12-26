`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/22 16:57:08
// Design Name: 
// Module Name: LED_ctl
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


module LED_ctl(cnt, led_ctl);
input [3:0]cnt;
output reg [3:0]led_ctl;

always @*
    led_ctl = cnt;
    

endmodule
