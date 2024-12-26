`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/18 13:12:01
// Design Name: 
// Module Name: DecFullAdder
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


module DecFullAdder(cin, cnt0, cnt1, sum0, carry);
input cin;
input [3:0]cnt0, cnt1;
output reg [3:0]sum0;
output reg carry;

reg [4:0]sum;

always @* begin
    sum = cnt1 + cnt0 + cin;
    
    case(sum)
        5'd0, 5'd10: sum0 = 4'd0;
        5'd1, 5'd11: sum0 = 4'd1;
        5'd2, 5'd12: sum0 = 4'd2;
        5'd3, 5'd13: sum0 = 4'd3;
        5'd4, 5'd14: sum0 = 4'd4;
        5'd5, 5'd15: sum0 = 4'd5;
        5'd6, 5'd16: sum0 = 4'd6;
        5'd7, 5'd17: sum0 = 4'd7;
        5'd8, 5'd18: sum0 = 4'd8;
        5'd9, 5'd19: sum0 = 4'd9;
        default: sum0 = 4'd15;
    endcase
    
    if (sum[4] | (sum[3]&sum[2]) | (sum[3]&sum[1]))
        carry = 1;
    else
        carry = 0;
          
end


endmodule
