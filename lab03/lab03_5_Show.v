`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/15 17:24:21
// Design Name: 
// Module Name: Show
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


module Show(ssd, d, D);

input [3:0]ssd;
input [11:0]d;
reg [2:0]tmp_D;
output reg [7:0]D;

always @*
    begin
    case(ssd)
        4'b0111: tmp_D = d[11:9]; 
        4'b1011: tmp_D = d[8:6];
        4'b1101: tmp_D = d[5:3];
        4'b1110: tmp_D = d[2:0];
     endcase
     
     case(tmp_D)
        3'b000: D = 8'b11010101;
        3'b001: D = 8'b11100001;
        3'b010: D = 8'b10010001;
        3'b011: D = 8'b10000011;
        3'b100: D = 8'b01100001;
        3'b101: D = 8'b00100101;
        3'b110: D = 8'b00000011;
        3'b111: D = 8'b00001101;
     endcase
    end
endmodule
