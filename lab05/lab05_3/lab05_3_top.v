`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/04 11:59:42
// Design Name: 
// Module Name: lab05_3_top
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


module lab05_3_top(clk, setting, min_pb, sec_pb, StSp_pb, PaRe_pb, ssd, D, time_out);
input clk, min_pb, sec_pb, StSp_pb, PaRe_pb; // start/stop push button, and pause/resume button
input setting;
output [3:0]ssd;
output [7:0]D;
output [15:0]time_out;


reg init_rst;
wire min_sign, sec_sign;
wire stsp_sign, pare_sign;
wire [3:0]init_min;
wire [3:0]init_sec;
wire _OneHz;
//output 
reg stop_state = 1;
//output reg rst = 1;
reg rst = 1;
reg setting_rst_record; // record if we have already rst the timer during setting cond.
//output 
reg start_record = 0; // record have we start the timer yet
_1HzClk OneClk1(.clk(clk), .rst(init_rst), .clk_out(_OneHz));
button_signCtl st_min(.clk(clk), .rst(init_rst), .pb(min_pb), .sign(min_sign));
button_signCtl st_sec(.clk(clk), .rst(init_rst), .pb(sec_pb), .sign(sec_sign));
button_signCtl2 StartStop(.clk(clk), .rst(init_rst), .pb(StSp_pb), .sign(stsp_sign));
button_signCtl2 PauseResm(.clk(clk), .rst(init_rst), .pb(PaRe_pb), .sign(pare_sign));

BCD_CTL Timer(.clk(clk), 
.init_rst(init_rst), .rst(rst), 
.stop(stop_state), .setting(setting), 
.min_sign(min_sign), .sec_sign(sec_sign), 
.ssd(ssd), .D(D), .time_out(time_out));



always @(posedge _OneHz or negedge init_rst)
    if (~init_rst || setting == 1)
        stop_state <= 1;
    else if (stsp_sign && start_record == 0)
        stop_state <= ~stop_state;
    else if (stsp_sign && stop_state == 0)
        stop_state <= 1;
    else if (pare_sign && start_record == 1)
        stop_state <= ~stop_state;
    else if (time_out)
        stop_state <= 1;
    else
        stop_state <= stop_state;
        
always @(posedge _OneHz or negedge init_rst)
    if (~init_rst) begin
        setting_rst_record = 0;
        rst <= 1;
    end else if (setting == 1 && setting_rst_record == 0) begin
        rst <= 0;
        setting_rst_record <= 1;
    end else if (stop_state == 1 && stsp_sign && start_record == 1) begin
        rst <= 0;
    end else if (setting == 0) begin// rst setting_rst_record 
        setting_rst_record <= 0; 
        rst <= 1;
    end else begin
        rst <= 1;
    end

always @(posedge _OneHz or negedge init_rst)
    if (~init_rst || setting)
        start_record <= 0;
    else if (stsp_sign && start_record == 0)
        start_record <= 1;
    else if (stsp_sign && start_record == 1 && stop_state == 1)
        start_record <= 0;
    else
        start_record <= start_record;
      

    
initial begin
init_rst = 1;
#1 init_rst = 0;
#1 init_rst = 1;
end

endmodule
