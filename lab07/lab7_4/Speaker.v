`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/05 15:24:35
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
`define Div_Do 27'd191571
`define Div_Re 27'd170648
`define Div_Mi 27'd151515
`define Div_Fa 27'd143266
`define Div_So 27'd127551
`define Div_La 27'd113636
`define Div_Si 27'd101214

module Speaker(clk, rst, sw_in, pb_up, pb_down, pb_left, pb_right, pb_center, MCLK, SCK, LRCK, Stdin);
input clk, rst, sw_in, pb_up, pb_down, pb_left, pb_right, pb_center;
output MCLK, LRCK, SCK, Stdin;


reg init_rst;
reg [26:0]div_note_left, div_note_right;
wire [15:0]right_audio;
wire [15:0]left_audio;
wire pb_up_sign, pb_down_sign, pb_right_sign, pb_left_sign, pb_center_sign;

    
Button_sign_CTL Up0(.clk(clk), .rst(rst), .pb(pb_up), .pb_sign(pb_up_sign));
Button_sign_CTL Down0(.clk(clk), .rst(rst), .pb(pb_down), .pb_sign(pb_down_sign));
Button_sign_CTL Right0(.clk(clk), .rst(rst), .pb(pb_right), .pb_sign(pb_right_sign));
Button_sign_CTL Left0(.clk(clk), .rst(rst), .pb(pb_left), .pb_sign(pb_left_sign));
Button_sign_CTL Center0(.clk(clk), .rst(rst), .pb(pb_center), .pb_sign(pb_center_sign));

Buzzer Buzzer0(.clk(clk), .rst(rst), .right_div(div_note_right), .left_div(div_note_left), 
      .audio_right(right_audio), .audio_left(left_audio));


Speaker_CTL Speaker_CTL0(.clk(clk), .rst(rst), .left_audio(left_audio), .Stdin(Stdin),
            .right_audio(right_audio), .MCLK(MCLK), .LRCK(LRCK), .SCK(SCK));


always @*
    if (pb_up_sign)
        div_note_left = `Div_Do;
    else if (pb_right_sign)
        div_note_left = `Div_Re; 
    else if (pb_down_sign)
        div_note_left = `Div_Mi; 
    else if (pb_left_sign)
        div_note_left = `Div_Fa;
    else if (pb_center_sign)
        div_note_left = `Div_So;
    else
        div_note_left = 27'd1;


always @*
    if (pb_up_sign)
        div_note_right = (sw_in) ? `Div_Mi : `Div_Do;
    else if (pb_right_sign)
        div_note_right = (sw_in) ? `Div_Fa : `Div_Re;
    else if (pb_down_sign)
        div_note_right = (sw_in) ? `Div_So : `Div_Mi;
    else if (pb_left_sign)
        div_note_right = (sw_in) ? `Div_La : `Div_Fa;
    else if (pb_center_sign)
        div_note_right = (sw_in) ? `Div_Si : `Div_So;
    else
        div_note_right = 27'd1;




endmodule