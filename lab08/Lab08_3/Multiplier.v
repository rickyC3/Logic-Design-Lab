`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/18 14:40:59
// Design Name: 
// Module Name: Multiplier
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


module Multiplier(clk, rst_p, press_enter, add0, add1, aug0, aug1, sum3, sum2, sum1, sum0);
input [3:0]add0, add1, aug0, aug1;
input clk, rst_p, press_enter;
output reg [3:0]sum3, sum2, sum1, sum0;

reg [6:0]add; // 99 --> 2^7 contain
reg [6:0]aug;

reg [3:0]cnt; // shift 12 times
reg [11:0]sum; // 12 bits
reg [11:0]sum_conserve;
reg [11:0]shift_sum;
reg [15:0]dec_sum; // 4 dec digit

// dec to binary
always @* begin
    add = (add1 << 3) + add1 + add1 + add0;
    aug = (aug1 << 3) + aug1 + aug1 + aug0; 
// opr
// https://docs.amd.com/r/en-US/ug901-vivado-synthesis/Unsigned-16x16-Bit-Multiplier-Coding-VHDL-Example
    sum = add * aug;
end

// turn bin to dec
// use Double Dabble
// https://nandland.com/binary-to-bcd-the-double-dabbler/
// https://en.wikipedia.org/wiki/Double_dabble

        
        
always @(posedge clk or posedge rst_p)
    if (rst_p) begin
        cnt <= 0;
        dec_sum <= 0;
        shift_sum <= sum;
    end else if (dec_sum[15:12] > 4) begin
        dec_sum[15:12] <= dec_sum[15:12] + 4'd3;
        cnt <= cnt;
        shift_sum <= shift_sum;
    end else if (dec_sum[11:8] > 4) begin
        dec_sum[11:8] <= dec_sum[11:8] + 4'd3;
        cnt <= cnt;
        shift_sum <= shift_sum;
    end else if (dec_sum[7:4] > 4) begin
        dec_sum[7:4] <= dec_sum[7:4] + 4'd3;
        cnt <= cnt;
        shift_sum <= shift_sum;
    end else if (dec_sum[3:0] > 4) begin
        dec_sum[3:0] <= dec_sum[3:0] + 4'd3;
        cnt <= cnt;
        shift_sum <= shift_sum;
    end else if (cnt < 4'd12) begin
        cnt <= 1;
        shift_sum <= {shift_sum[10:0], 0};
        dec_sum <= {dec_sum[14:0], shift_sum[11]};
    end else begin
        cnt <= cnt;
        shift_sum <= shift_sum;
        dec_sum <= dec_sum;
    end

always @* begin
    sum3 = dec_sum[15:12];
    sum2 = dec_sum[11:8];
    sum1 = dec_sum[7:4];
    sum0 = dec_sum[3:0];
end

endmodule
