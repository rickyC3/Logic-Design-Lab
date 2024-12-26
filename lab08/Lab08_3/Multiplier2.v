`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/18 22:25:10
// Design Name: 
// Module Name: Multiplier2
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


module Multiplier2(add0, add1, aug0, aug1, sum3, sum2, sum1, sum0);
input [3:0]add0, add1, aug0, aug1;
output reg [3:0]sum3, sum2, sum1, sum0;

reg [15:0]sum;

always @* begin
    sum = (add0 + add1 * 4'd10) * (aug0 + aug1*4'd10);
    
    sum0 = sum % 4'd10;
    sum1 = (sum / 4'd10) % 4'd10;
    sum2 = (sum / 7'd100) % 4'd10;
    sum3 = sum / 11'd1000;
end


endmodule
