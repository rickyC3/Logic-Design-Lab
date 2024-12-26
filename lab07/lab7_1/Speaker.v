`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/03 16:41:18
// Design Name: 
// Module Name: Speaker
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


module Speaker(clk, rst, MCLK, LRCK, SCK, Stdin, right_audio, left_audio, cnt);
input clk, rst;
output MCLK, LRCK, SCK;
output reg Stdin;
output [15:0]right_audio;
output [15:0]left_audio;
output reg [4:0]cnt;



reg [31:0]serial_tmp;


Divider MCLK0(.clk(clk), .rst(rst), .div(27'd2), .clk_out(MCLK)); // MCLK 25M --> 100M/(2*2)
Divider LRCK0(.clk(clk), .rst(rst), .div(27'd256), .clk_out(LRCK)); // LRCK MCLK/128 --> 100M/(2*128*2)
Divider SCK0 (.clk(clk), .rst(rst), .div(27'd8), .clk_out(SCK));  // SCK MCLK/4 --> 100M/(2*2*2)

Buzzer_CTL Buzzer0(.clk(clk), .rst(rst), .div(27'd191571), .right_audio(right_audio), .left_audio(left_audio));
// use Do note

always @*
    serial_tmp  = {left_audio, right_audio}; // parallel to serial


always@*
    case (cnt)
        5'd1: Stdin = serial_tmp[31]; // MSB
        5'd2: Stdin = serial_tmp[30];
        5'd3: Stdin = serial_tmp[29];
        5'd4: Stdin = serial_tmp[28];
        5'd5: Stdin = serial_tmp[27];
        5'd6: Stdin = serial_tmp[26];
        5'd7: Stdin = serial_tmp[25];
        5'd8: Stdin = serial_tmp[24];
        5'd9: Stdin = serial_tmp[23];
        5'd10: Stdin = serial_tmp[22];
        5'd11: Stdin = serial_tmp[21];
        5'd12: Stdin = serial_tmp[20];
        5'd13: Stdin = serial_tmp[19];
        5'd14: Stdin = serial_tmp[18];
        5'd15: Stdin = serial_tmp[17];
        5'd16: Stdin = serial_tmp[16];
        5'd17: Stdin = serial_tmp[15];
        5'd18: Stdin = serial_tmp[14];
        5'd19: Stdin = serial_tmp[13];
        5'd20: Stdin = serial_tmp[12];
        5'd21: Stdin = serial_tmp[11];
        5'd22: Stdin = serial_tmp[10];
        5'd23: Stdin = serial_tmp[9];
        5'd24: Stdin = serial_tmp[8];
        5'd25: Stdin = serial_tmp[7];
        5'd26: Stdin = serial_tmp[6];
        5'd27: Stdin = serial_tmp[5];
        5'd28: Stdin = serial_tmp[4];
        5'd29: Stdin = serial_tmp[3];
        5'd30: Stdin = serial_tmp[2];
        5'd31: Stdin = serial_tmp[1];
        5'd0: Stdin = serial_tmp[0]; // LSB
        default: Stdin = 0;
    endcase
        
always @(negedge SCK or negedge rst) // by negedge SCK
    if (~rst) 
        cnt <= 0;
    else
        cnt <= cnt + 1;
        
endmodule
