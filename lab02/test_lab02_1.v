`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/09 11:19:31
// Design Name: 
// Module Name: test_lab02_1
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


module test_lab02_1();

wire W, X, Y, Z;
reg A, B, C, D;

lab02_1 U0(.a(A), .b(B), .c(C), .d(D), .w(W), .x(X), .y(Y), .z(Z));
initial
begin

A = 0;B = 0;C = 0;D = 0;
#10 A = 0;B = 0;C = 0;D = 1;
#10 A = 0;B = 0;C = 1;D = 0;
#10 A = 0;B = 0;C = 1;D = 1;
#10 A = 0;B = 1;C = 0;D = 0;
#10 A = 0;B = 1;C = 0;D = 1;
#10 A = 0;B = 1;C = 1;D = 0;
#10 A = 0;B = 1;C = 1;D = 1;
#10 A = 1;B = 0;C = 0;D = 0;
#10 A = 1;B = 0;C = 0;D = 1;
end

endmodule
