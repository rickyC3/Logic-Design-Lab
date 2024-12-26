`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/18 18:01:04
// Design Name: 
// Module Name: lab08_4_top
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


module lab08_4_top(ps2_data, ps2_clk, rst_p, caps_state, clk_100Hz, ssd, D, ascii);
inout ps2_data, ps2_clk;
input rst_p, clk_100Hz;
output reg caps_state;
output [3:0]ssd;
output [7:0]D;

wire [511:0]key_down;
wire [8:0]last_change;
wire key_valid;
reg [3:0]cnt0;
reg [3:0]cnt1;
reg [3:0]cnt2;
reg [3:0]cnt3 = 0;
reg [4:0]sum;
reg [6:0]cnt_decoder;
reg [511:0]key_decoder;
reg [511:0]key_tmp;
reg key_state;

// shift 
reg shift_decoder0, shift_decoder1;
reg shift_state;
output reg [6:0]ascii;

_7SegShow(.clk(clk_100Hz), .rst(rst_p), .cnt3(cnt3),
          .cnt2(cnt2), .cnt1(cnt1), .cnt0(cnt0), .ssd_out(ssd), .D(D));

KeyboardDecoder( .key_down(key_down), .last_change(last_change), 
                 .key_valid(key_valid), .PS2_DATA(ps2_data), .PS2_CLK(ps2_clk), 
                 .rst(rst_p), .clk(clk_100Hz));

always @* begin // detect press key
// https://electronics.stackexchange.com/questions/447795/how-to-specify-a-value-for-each-bit-of-the-reg-in-verilog
// https://nandland.com/reduction-operators/    
    key_decoder = 1 << last_change;
    key_tmp = (key_down & key_decoder);
    key_state = |key_tmp;
end

always @*
    case(last_change[7:0])
        8'h1C: cnt_decoder = (caps_state ^ shift_state)? 7'd65:7'd97; // upper / lower
        8'h32: cnt_decoder = (caps_state ^ shift_state)? 7'd66:7'd98;
        8'h21: cnt_decoder = (caps_state ^ shift_state)? 7'd67:7'd99;
        8'h23: cnt_decoder = (caps_state ^ shift_state)? 7'd68:7'd100;
        8'h24: cnt_decoder = (caps_state ^ shift_state)? 7'd69:7'd101;
        8'h2b: cnt_decoder = (caps_state ^ shift_state)? 7'd70:7'd102;
        8'h34: cnt_decoder = (caps_state ^ shift_state)? 7'd71:7'd103;
        8'h33: cnt_decoder = (caps_state ^ shift_state)? 7'd72:7'd104;
        8'h43: cnt_decoder = (caps_state ^ shift_state)? 7'd73:7'd105;
        8'h3b: cnt_decoder = (caps_state ^ shift_state)? 7'd74:7'd106;
        8'h42: cnt_decoder = (caps_state ^ shift_state)? 7'd75:7'd107;
        8'h4b: cnt_decoder = (caps_state ^ shift_state)? 7'd76:7'd108;
        8'h3a: cnt_decoder = (caps_state ^ shift_state)? 7'd77:7'd109;
        8'h31: cnt_decoder = (caps_state ^ shift_state)? 7'd78:7'd110;
        8'h44: cnt_decoder = (caps_state ^ shift_state)? 7'd79:7'd111;
        8'h4d: cnt_decoder = (caps_state ^ shift_state)? 7'd80:7'd112;
        8'h15: cnt_decoder = (caps_state ^ shift_state)? 7'd81:7'd113;
        8'h2d: cnt_decoder = (caps_state ^ shift_state)? 7'd82:7'd114;
        8'h1b: cnt_decoder = (caps_state ^ shift_state)? 7'd83:7'd115;
        8'h2c: cnt_decoder = (caps_state ^ shift_state)? 7'd84:7'd116;
        8'h3c: cnt_decoder = (caps_state ^ shift_state)? 7'd85:7'd117;
        8'h2a: cnt_decoder = (caps_state ^ shift_state)? 7'd86:7'd118;
        8'h1d: cnt_decoder = (caps_state ^ shift_state)? 7'd87:7'd119;
        8'h22: cnt_decoder = (caps_state ^ shift_state)? 7'd88:7'd120;
        8'h35: cnt_decoder = (caps_state ^ shift_state)? 7'd89:7'd121;
        8'h1a: cnt_decoder = (caps_state ^ shift_state)? 7'd90:7'd122;
        default: cnt_decoder = 7'd0;
    endcase
    
always @* begin // detect shift 
        shift_decoder0 = |(key_down & (1 << (8'h12)));
        shift_decoder1 = |(key_down & (1 << (8'h59)));
        
        shift_state = shift_decoder0 | shift_decoder1;
    end    
    
// caps state
always @(posedge clk_100Hz or posedge rst_p)
    if (rst_p)
         caps_state <= 0;
    else if (key_valid && key_state && last_change == 8'h58)
        caps_state <= ~caps_state;
    else
        caps_state <= caps_state;

always @(posedge clk_100Hz or posedge rst_p)
    if (rst_p)
        ascii <= 0;
    else if (key_valid && key_state && last_change != 8'h58 && last_change != 8'h12 && last_change != 8'h59)
        ascii <= cnt_decoder;
    else
        ascii <= ascii;
        
always @*
    case(ascii)
        7'd65: begin cnt2 = 4'd0; cnt1 = 4'd6; cnt0 = 4'd5; end
        7'd66: begin cnt2 = 4'd0; cnt1 = 4'd6; cnt0 = 4'd6; end
        7'd67: begin cnt2 = 4'd0; cnt1 = 4'd6; cnt0 = 4'd7; end
        7'd68: begin cnt2 = 4'd0; cnt1 = 4'd6; cnt0 = 4'd8; end
        7'd69: begin cnt2 = 4'd0; cnt1 = 4'd6; cnt0 = 4'd9; end
        7'd70: begin cnt2 = 4'd0; cnt1 = 4'd7; cnt0 = 4'd0; end
        7'd71: begin cnt2 = 4'd0; cnt1 = 4'd7; cnt0 = 4'd1; end
        7'd72: begin cnt2 = 4'd0; cnt1 = 4'd7; cnt0 = 4'd2; end
        7'd73: begin cnt2 = 4'd0; cnt1 = 4'd7; cnt0 = 4'd3; end
        7'd74: begin cnt2 = 4'd0; cnt1 = 4'd7; cnt0 = 4'd4; end
        7'd75: begin cnt2 = 4'd0; cnt1 = 4'd7; cnt0 = 4'd5; end
        7'd76: begin cnt2 = 4'd0; cnt1 = 4'd7; cnt0 = 4'd6; end
        7'd77: begin cnt2 = 4'd0; cnt1 = 4'd7; cnt0 = 4'd7; end
        7'd78: begin cnt2 = 4'd0; cnt1 = 4'd7; cnt0 = 4'd8; end
        7'd79: begin cnt2 = 4'd0; cnt1 = 4'd7; cnt0 = 4'd9; end
        7'd80: begin cnt2 = 4'd0; cnt1 = 4'd8; cnt0 = 4'd0; end
        7'd81: begin cnt2 = 4'd0; cnt1 = 4'd8; cnt0 = 4'd1; end
        7'd82: begin cnt2 = 4'd0; cnt1 = 4'd8; cnt0 = 4'd2; end
        7'd83: begin cnt2 = 4'd0; cnt1 = 4'd8; cnt0 = 4'd3; end
        7'd84: begin cnt2 = 4'd0; cnt1 = 4'd8; cnt0 = 4'd4; end
        7'd85: begin cnt2 = 4'd0; cnt1 = 4'd8; cnt0 = 4'd5; end
        7'd86: begin cnt2 = 4'd0; cnt1 = 4'd8; cnt0 = 4'd6; end
        7'd87: begin cnt2 = 4'd0; cnt1 = 4'd8; cnt0 = 4'd7; end
        7'd88: begin cnt2 = 4'd0; cnt1 = 4'd8; cnt0 = 4'd8; end
        7'd89: begin cnt2 = 4'd0; cnt1 = 4'd8; cnt0 = 4'd9; end
        7'd90: begin cnt2 = 4'd0; cnt1 = 4'd9; cnt0 = 4'd0; end
        7'd97: begin cnt2 = 4'd0; cnt1 = 4'd9; cnt0 = 4'd7; end
        7'd98: begin cnt2 = 4'd0; cnt1 = 4'd9; cnt0 = 4'd8; end
        7'd99: begin cnt2 = 4'd0; cnt1 = 4'd9; cnt0 = 4'd9; end
        7'd100: begin cnt2 = 4'd1; cnt1 = 4'd0; cnt0 = 4'd0; end
        7'd101: begin cnt2 = 4'd1; cnt1 = 4'd0; cnt0 = 4'd1; end
        7'd102: begin cnt2 = 4'd1; cnt1 = 4'd0; cnt0 = 4'd2; end
        7'd103: begin cnt2 = 4'd1; cnt1 = 4'd0; cnt0 = 4'd3; end
        7'd104: begin cnt2 = 4'd1; cnt1 = 4'd0; cnt0 = 4'd4; end
        7'd105: begin cnt2 = 4'd1; cnt1 = 4'd0; cnt0 = 4'd5; end
        7'd106: begin cnt2 = 4'd1; cnt1 = 4'd0; cnt0 = 4'd6; end
        7'd107: begin cnt2 = 4'd1; cnt1 = 4'd0; cnt0 = 4'd7; end
        7'd108: begin cnt2 = 4'd1; cnt1 = 4'd0; cnt0 = 4'd8; end
        7'd109: begin cnt2 = 4'd1; cnt1 = 4'd0; cnt0 = 4'd9; end
        7'd110: begin cnt2 = 4'd1; cnt1 = 4'd1; cnt0 = 4'd0; end
        7'd111: begin cnt2 = 4'd1; cnt1 = 4'd1; cnt0 = 4'd1; end
        7'd112: begin cnt2 = 4'd1; cnt1 = 4'd1; cnt0 = 4'd2; end
        7'd113: begin cnt2 = 4'd1; cnt1 = 4'd1; cnt0 = 4'd3; end
        7'd114: begin cnt2 = 4'd1; cnt1 = 4'd1; cnt0 = 4'd4; end
        7'd115: begin cnt2 = 4'd1; cnt1 = 4'd1; cnt0 = 4'd5; end
        7'd116: begin cnt2 = 4'd1; cnt1 = 4'd1; cnt0 = 4'd6; end
        7'd117: begin cnt2 = 4'd1; cnt1 = 4'd1; cnt0 = 4'd7; end
        7'd118: begin cnt2 = 4'd1; cnt1 = 4'd1; cnt0 = 4'd8; end
        7'd119: begin cnt2 = 4'd1; cnt1 = 4'd1; cnt0 = 4'd9; end
        7'd120: begin cnt2 = 4'd1; cnt1 = 4'd2; cnt0 = 4'd0; end
        7'd121: begin cnt2 = 4'd1; cnt1 = 4'd2; cnt0 = 4'd1; end
        7'd122: begin cnt2 = 4'd1; cnt1 = 4'd2; cnt0 = 4'd2; end
        default : begin cnt2 = 4'd0; cnt1 = 4'd0; cnt0 = 4'd0;end
    endcase        

   
endmodule


