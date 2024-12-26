`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/04 10:23:11
// Design Name: 
// Module Name: Buzzer
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


module Buzzer(clk, rst, PbL, PbC, PbR, aml, amh, Left_audio, Right_audio);
input clk, rst, PbL, PbC, PbR;
input [15:0]aml;
input [15:0]amh;
output reg [15:0]Left_audio;
output reg [15:0]Right_audio;

reg [26:0]fre;

wire music_sign;

Divider Music(.clk(clk), .rst(rst), .div(fre), .clk_out(music_sign));

always @*
    case({PbL, PbC, PbR})
        3'b100: fre = 27'd191571; // Do
        3'b010: fre = 27'd170648; // Re
        3'b001: fre = 27'd151515; // Mi
        default: fre = 27'd1;
    endcase

        
        

always @* begin
    Right_audio = (~music_sign)? aml:amh;
    Left_audio =  (~music_sign)? aml:amh;
end

endmodule
