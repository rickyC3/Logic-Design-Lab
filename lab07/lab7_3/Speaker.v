`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/05 14:04:46
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


module Speaker(clk, sw_in, MCLK, SCK, LRCK, Stdin, ssd, D);
input clk;
input [15:0]sw_in;
output MCLK, LRCK, SCK, Stdin;
output [3:0]ssd;
output [7:0]D;

reg init_rst;
reg [26:0]div_note;
reg [3:0]alpha0, alpha1, alpha2;
wire [15:0]right_audio, left_audio;

Buzzer Buzzer0(.clk(clk), .rst(init_rst), .div(div_note),
               .right_audio(right_audio), .left_audio(left_audio));

Speaker_CTL(.clk(clk), .rst(init_rst), .left_audio(left_audio), .Stdin(Stdin),
            .right_audio(right_audio), .MCLK(MCLK), .LRCK(LRCK), .SCK(SCK));

_7SegShow(.clk(clk), .rst(init_rst), .alpha0(alpha0), .alpha1(alpha1), 
          .alpha2(alpha2), .ssd_out(ssd), .D(D));

always @*
    case(sw_in)
        16'd1: div_note = 27'd45086;
        16'd2: div_note = 27'd47081;
        16'd4: div_note = 27'd50607;
        16'd8: div_note = 27'd56818;
        16'd16: div_note = 27'd63776;
        16'd32: div_note = 27'd71633;
        16'd64: div_note = 27'd75758;
        16'd128: div_note = 27'd85034;
        16'd256: div_note = 27'd95420;
        16'd512: div_note = 27'd101214;
        16'd1024: div_note = 27'd113636;
        16'd2048: div_note = 27'd127551;
        16'd4096: div_note = 27'd143266;
        16'd8192: div_note = 27'd151515;
        16'd16384: div_note = 27'd170648;
        16'd32768: div_note = 27'd191571;
        default: div_note = 27'd1;
    endcase


always @*
    case(sw_in)
        16'd1: begin alpha2 = 4'b1100; alpha1 = 4'b0010; alpha0 = 4'b0011; end
        16'd2: begin alpha2 = 4'b1100; alpha1 = 4'b0000; alpha0 = 4'b0001; end
        16'd4: begin alpha2 = 4'b1010; alpha1 = 4'b1000; alpha0 = 4'b0101; end
        16'd8: begin alpha2 = 4'b1010; alpha1 = 4'b1001; alpha0 = 4'b0111; end
        16'd16: begin alpha2 = 4'b1010; alpha1 = 4'b1000; alpha0 = 4'b0001; end
        16'd32: begin alpha2 = 4'b1010; alpha1 = 4'b0110; alpha0 = 4'b0111; end
        16'd64: begin alpha2 = 4'b1010; alpha1 = 4'b1011; alpha0 = 4'b0101; end
        16'd128: begin alpha2 = 4'b1010; alpha1 = 4'b0010; alpha0 = 4'b0011; end
        16'd256: begin alpha2 = 4'b1010; alpha1 = 4'b0000; alpha0 = 4'b0001; end
        16'd512: begin alpha2 = 4'b0100; alpha1 = 4'b1000; alpha0 = 4'b0101; end
        16'd1024: begin alpha2 = 4'b0100; alpha1 = 4'b1001; alpha0 = 4'b0111; end
        16'd2048: begin alpha2 = 4'b0100; alpha1 = 4'b1000; alpha0 = 4'b0001; end
        16'd4096: begin alpha2 = 4'b0100; alpha1 = 4'b0110; alpha0 = 4'b0111; end
        16'd8192: begin alpha2 = 4'b0100; alpha1 = 4'b1011; alpha0 = 4'b0101; end
        16'd16384: begin alpha2 = 4'b0100; alpha1 = 4'b0010; alpha0 = 4'b0011; end
        16'd32768: begin alpha2 = 4'b0100; alpha1 = 4'b0000; alpha0 = 4'b0001; end
        default: begin alpha2 = 4'b1111; alpha1 = 4'b1111; alpha0 = 4'b1111; end
    endcase

initial begin
init_rst = 1;
#1 init_rst = 0;
#1 init_rst = 1;
end

endmodule
