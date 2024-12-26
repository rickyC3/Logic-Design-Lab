`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/18 13:22:02
// Design Name: 
// Module Name: DecSubtractor
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


module DecSubtractor(cin, cnt0, cnt1, sub0, carry); // cnt0 - cnt1
input cin;
input [3:0]cnt0, cnt1;
output reg [3:0]sub0;
output reg carry;

always @*
    if (cnt0 < (cnt1+cin)) begin
        sub0 = (cnt0 + 4'b1010) - cnt1 - cin;
        carry = 1;
    end else begin
        sub0 = cnt0 - cnt1 - cin;
        carry = 0;
    end 
    
endmodule
