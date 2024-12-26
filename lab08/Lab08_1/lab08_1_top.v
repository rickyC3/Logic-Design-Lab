`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/17 15:08:14
// Design Name: 
// Module Name: lab08_1_top
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


module lab08_1_top(ps2_data, ps2_clk, rst_p, clk_100Hz, ssd, D);
inout ps2_data, ps2_clk;
input rst_p, clk_100Hz;
output [3:0]ssd;
output [7:0]D;

wire [511:0]key_down;
wire [8:0]last_change;
wire key_vaild;
reg [3:0]cnt;
reg [3:0]cnt_decoder;
reg [511:0]key_decoder;
reg [511:0]key_tmp;
reg key_state;

always @* begin
// https://electronics.stackexchange.com/questions/447795/how-to-specify-a-value-for-each-bit-of-the-reg-in-verilog
// https://nandland.com/reduction-operators/    
    key_decoder = 1 << last_change;
    key_tmp = (key_down & key_decoder);
    key_state = |key_tmp;
end

_7SegShow(.clk(clk_100Hz), .rst(rst_p), .cnt3(cnt),
          .cnt2(cnt), .cnt1(cnt), .cnt0(cnt), .ssd_out(ssd), .D(D));

KeyboardDecoder( .key_down(key_down), .last_change(last_change), 
                 .key_valid(key_vaild), .PS2_DATA(ps2_data), .PS2_CLK(ps2_clk), 
                 .rst(rst_p), .clk(clk_100Hz));
always @*
    case(last_change[7:0])
        8'h16, 8'h69: cnt_decoder = 4'd1;
        8'h1E, 8'h72: cnt_decoder = 4'd2;
        8'h26, 8'h7A: cnt_decoder = 4'd3;
        8'h25, 8'h6B: cnt_decoder = 4'd4;
        8'h2E, 8'h73: cnt_decoder = 4'd5;
        8'h36, 8'h74: cnt_decoder = 4'd6;
        8'h3D, 8'h6C: cnt_decoder = 4'd7;
        8'h3E, 8'h75: cnt_decoder = 4'd8;
        8'h46, 8'h7D: cnt_decoder = 4'd9;
        8'h45, 8'h70: cnt_decoder = 4'd0;
        8'h1C: cnt_decoder = 4'd10;
        8'h1B: cnt_decoder = 4'd11;
        8'h3A: cnt_decoder = 4'd12;
        8'h5A: cnt_decoder = 4'd15;
        default: cnt_decoder = 4'd15;
     endcase


always @(posedge clk_100Hz or posedge rst_p)
    if (rst_p)
        cnt <= 0;
    else if (key_vaild & key_state)
        cnt <= cnt_decoder;
    else 
        cnt <= cnt;
        
        
endmodule
