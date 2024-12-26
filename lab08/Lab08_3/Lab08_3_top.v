`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/18 11:49:39
// Design Name: 
// Module Name: Lab08_3_top
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


module Lab08_3_top(ps2_data, ps2_clk, rst_p, clk_100Hz, ssd, D, press_enter);
inout ps2_data, ps2_clk;
input rst_p, clk_100Hz;
output [3:0]ssd;
output [7:0]D;


reg setting_mode = 0;
reg is_digit;
wire [511:0]key_down;
wire [8:0]last_change;
wire key_valid;
reg [3:0]add0, add1;
reg [3:0]aug0, aug1;
wire [3:0]out0, out1 ,out2 ,out3;
reg [3:0]opr = 4'd15; // 4'd10--> + ; 4'd11 --> - ; 4'd12 -->* 
reg [3:0]show_cnt0, show_cnt1, show_cnt2, show_cnt3;
output reg press_enter;
reg [3:0]cnt_decoder;
reg [511:0]key_decoder;
reg [511:0]key_tmp;
reg key_state;
reg rst;

// key detect
always @* begin
// https://electronics.stackexchange.com/questions/447795/how-to-specify-a-value-for-each-bit-of-the-reg-in-verilog
// https://nandland.com/reduction-operators/    
    key_decoder = 1 << last_change;
    key_tmp = (key_down & key_decoder);
    key_state = |key_tmp;
end

_7SegShow(.clk(clk_100Hz), .rst(rst_p), .cnt3(show_cnt3),
          .cnt2(show_cnt2), .cnt1(show_cnt1), .cnt0(show_cnt0), .ssd_out(ssd), .D(D));

KeyboardDecoder( .key_down(key_down), .last_change(last_change), 
                 .key_valid(key_valid), .PS2_DATA(ps2_data), .PS2_CLK(ps2_clk), 
                 .rst(rst_p), .clk(clk_100Hz));

Operation(.clk(clk_100Hz), .rst_p(rst_p), .press_enter(press_enter),
          .add0(add0), .add1(add1), .aug0(aug0), .aug1(aug1),
          .opr(opr), .out0(out0), .out1(out1), .out2(out2), .out3(out3));

always @*
    is_digit = (cnt_decoder >= 0 && cnt_decoder < 4'd10)? 1:0;

        

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
        8'h79: cnt_decoder = 4'd10;
        8'h7B: cnt_decoder = 4'd11;
        8'h7C: cnt_decoder = 4'd12;
        8'h5A: cnt_decoder = 4'd15;
        default: cnt_decoder = 4'd0;
     endcase

// setting num
always @(posedge clk_100Hz or posedge rst_p)
    if (rst_p) begin
        add0 <= 0;
        add1 <= 0;
    end else if (rst) begin
        add0 <= 0;
        add1 <= 0;
    end else if (~setting_mode && key_valid && key_state && is_digit)begin
        add1 <= add0;
        add0 <= cnt_decoder;
    end else begin
        add0 <= add0;
        add1 <= add1;end
        
always @(posedge clk_100Hz or posedge rst_p)
    if (rst_p) begin
        aug0 <= 0;
        aug1 <= 0;
    end else if (rst) begin
        aug0 <= 0;
        aug1 <= 0;
    end else if (setting_mode && key_valid && key_state && is_digit)begin
        aug1 <= aug0;
        aug0 <= cnt_decoder;
    end else begin
        aug0 <= aug0;
        aug1 <= aug1;end
        
always @(posedge clk_100Hz or negedge rst_p)
    if (rst_p) begin
        opr <= 4'd15;
        setting_mode <= 0;
    end else if (rst) begin
        opr <= 4'd15;
        setting_mode <= 0;
    end else if (key_valid && key_state && ~is_digit && cnt_decoder != 4'd15) begin
        opr <= cnt_decoder;
        setting_mode <= 1;
    end else begin
        opr <= opr;
        setting_mode <= setting_mode;end
        

always @(posedge clk_100Hz or negedge rst_p)
    if (rst_p) begin
        press_enter <= 0;
        rst <= 0;
    end else if (key_valid && key_state &&  cnt_decoder == 4'd15) begin
        rst <= 0;
        press_enter <= 1;
    end else if (key_valid && key_state && press_enter) begin // press any key
        press_enter <= 0;
        rst <= 1;
    end else begin
        rst <= 0;
        press_enter <= press_enter;end

// ================================================
// fsm
always @*
    if(~press_enter && ~setting_mode) begin
        show_cnt0 = add0;
        show_cnt1 = add1;
        show_cnt2 = 4'd15;
        show_cnt3 = opr;
    end else if (~press_enter && setting_mode) begin
        show_cnt0 = aug0;
        show_cnt1 = aug1;
        show_cnt2 = 4'd15;
        show_cnt3 = opr;
    end else if (press_enter) begin
        show_cnt0 = out0;
        show_cnt1 = out1;
        show_cnt2 = out2;
        show_cnt3 = out3;end
    
        
        

endmodule
