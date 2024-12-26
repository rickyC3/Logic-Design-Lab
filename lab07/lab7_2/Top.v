`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/04 11:26:26
// Design Name: 
// Module Name: Top
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


module Top(clk, rst, pbu, pbd, pbl, pbr, pbc, MCLK, LRCK, SCK, Stdin, ssd, D);
input clk, rst, pbu, pbd, pbl, pbr, pbc;
output MCLK, LRCK, SCK, Stdin;
output [3:0]ssd;
output [7:0]D;
wire [15:0]left_audio, right_audio;
wire  pbl_sign, pbc_sign, pbr_sign;
wire pbu_sign, pbd_sign;
wire [15:0]Aml;
wire [15:0]Amh;
wire [3:0]cnt0;
wire [3:0]cnt1;

Button_Sign_CTL DO(.clk(clk), .rst(rst), .pb(pbl), .pb_sign(pbl_sign));
Button_Sign_CTL RE(.clk(clk), .rst(rst), .pb(pbc), .pb_sign(pbc_sign));
Button_Sign_CTL MI(.clk(clk), .rst(rst), .pb(pbr), .pb_sign(pbr_sign));

Button_Sign_CTL VolumeUp   (.clk(clk), .rst(rst), .pb(pbu), .pb_sign(pbu_sign));
Button_Sign_CTL VolumeDown(.clk(clk), .rst(rst), .pb(pbd), .pb_sign(pbd_sign));

amlitude AMP(.clk(clk), .rst(rst), .PbU(pbu_sign), .PbD(pbd_sign), .aml(Aml), .amh(Amh), .cnt0(cnt0), .cnt1(cnt1));

Buzzer BUZZER(.clk(clk), .rst(rst), .PbL(pbl_sign), .aml(Aml), .amh(Amh),
.PbC(pbc_sign), .PbR(pbr_sign), .Left_audio(left_audio), .Right_audio(right_audio));


Speaker SPEAKER(.clk(clk), .rst(rst), .right_audio(right_audio), 
.left_audio(left_audio), .MCLK(MCLK), .LRCK(LRCK), .SCK(SCK), .Stdin(Stdin));

_7SegShow SHOW0(.clk(clk), .rst(rst), .cnt3(4'b1111), .cnt2(4'b1111), .cnt1(cnt1), .cnt0(cnt0), .ssd_out(ssd), .D(D));

endmodule
