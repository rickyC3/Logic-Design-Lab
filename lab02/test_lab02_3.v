`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/06 23:13:46
// Design Name: 
// Module Name: test_lab02_3
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


module test_lab02_3();
wire [2:0]led_c;
wire [2:0]led_b;
reg [7:0]s;
reg [7:0]g;

reg [3:0]s1;
reg [3:0]s2;
reg [3:0]g1;
reg [3:0]g2;


lab02_3 U0(.s(s), .g(g), .led_b(led_b), .led_c(led_c));
initial
begin
s = 8'd0;
g = 8'd0;
s1 = 0;s2 = 0;g1 = 0;g2 = 0;
for (s1 = 0;g2 != 4'b1010;s1 = s1 + 1)begin

s[7:4] = s2;
s[3:0] = s1;
g[7:4] = g2;
g[3:0] = g1;
#5

if (s1 == 4'b1010) begin
    s2 = s2 + 1;
    s1 = 0;
end else
    s2 = s2;

if (s2 == 4'b1010) begin
    g1 = g1 + 1;
    s2 = 0;
end else
    g1 = g1;

if (g1 == 4'b1010) begin
    g2 = g2 + 1;
    g1 = 0;
end else
    g2 = g2;
    





end
end

endmodule
