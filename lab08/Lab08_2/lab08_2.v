`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/18 00:48:13
// Design Name: 
// Module Name: lab08_2
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


module lab08_2(ps2_data, ps2_clk, rst_p, setting, setting_mode, clk_100Hz, ssd, D);
inout ps2_data, ps2_clk;
input rst_p, clk_100Hz, setting;
output reg setting_mode;
output [3:0]ssd;
output [7:0]D;

wire [511:0]key_down;
wire [8:0]last_change;
wire key_valid;
reg [3:0]cnt0;
reg [3:0]cnt1;
reg [3:0]cnt2;
reg [3:0]cnt3;
reg [4:0]sum;
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
    setting_mode = setting;
end

always @* begin
    sum = cnt3 + cnt2;
    
    case(sum)
        5'd0, 5'd10: cnt0 = 4'd0;
        5'd1, 5'd11: cnt0 = 4'd1;
        5'd2, 5'd12: cnt0 = 4'd2;
        5'd3, 5'd13: cnt0 = 4'd3;
        5'd4, 5'd14: cnt0 = 4'd4;
        5'd5, 5'd15: cnt0 = 4'd5;
        5'd6, 5'd16: cnt0 = 4'd6;
        5'd7, 5'd17: cnt0 = 4'd7;
        5'd8, 5'd18: cnt0 = 4'd8;
        5'd9, 5'd19: cnt0 = 4'd9;
        default: cnt0 = 4'd15;
    endcase
    
    if (sum[4] | (sum[3]&sum[2]) | (sum[3]&sum[1]))
        cnt1 = 4'd1;
    else
        cnt1 = 4'd0;
          
end

    

_7SegShow(.clk(clk_100Hz), .rst(rst_p), .cnt3(cnt3),
          .cnt2(cnt2), .cnt1(cnt1), .cnt0(cnt0), .ssd_out(ssd), .D(D));

KeyboardDecoder( .key_down(key_down), .last_change(last_change), 
                 .key_valid(key_valid), .PS2_DATA(ps2_data), .PS2_CLK(ps2_clk), 
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
        //8'h1C: cnt_decoder = 4'd10;
        //8'h1B: cnt_decoder = 4'd11;
        //8'h3A: cnt_decoder = 4'd12;
        //8'h5A: cnt_decoder = 4'd15;
        default: cnt_decoder = 4'd0;
     endcase


always @(posedge clk_100Hz or posedge rst_p)
    if (rst_p) begin
        cnt3 <= 0;
        cnt2 <= 0;
    end else if (~setting && key_valid && key_state)begin
        cnt3 <= cnt_decoder;
        cnt2 <= cnt2;
    end else if (setting && key_valid && key_state) begin
        cnt3 <= cnt3;
        cnt2 <= cnt_decoder;
    end else begin
        cnt3 <= cnt3;
        cnt2 <= cnt2;end
        
        
endmodule

