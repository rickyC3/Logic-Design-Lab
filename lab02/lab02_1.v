`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/05 17:01:28
// Design Name: 
// Module Name: lab02_1
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


module lab02_1(
input a,
input b,
input c,
input d,
output w,
output x,
output y,
output z
);

assign w = (a | (b&d)) | (b&c);
assign x = b & (~c);
assign y = b | c;
assign z = (a & (~d) ) | ((b&c)&d) | ((~b)&c&(~d)) | ((~a)&(~b)&(~c)&d);
endmodule
