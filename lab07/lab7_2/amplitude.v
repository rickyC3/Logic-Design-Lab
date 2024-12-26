`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/04 13:35:12
// Design Name: 
// Module Name: amlitude
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


module amlitude(clk, rst, PbU, PbD, aml, amh, cnt0, cnt1);
input clk, rst, PbU, PbD;
output reg [15:0]aml;
output reg [15:0]amh;
output reg [3:0]cnt0;
output reg [3:0]cnt1;

reg [3:0]level;
wire OneClk;

_1HzClk OneCLK2(.clk(clk), .rst(rst), .clk_out(OneClk));

always @(posedge OneClk or negedge rst)
    if (~rst)
        level <= 4'd8;
    else if (PbU && level == 4'b1111)
        level <= level;
    else if (PbU)
        level <= level + 1;
    else if (PbD && level == 4'b0000)
        level <= level;
    else if (PbD)
        level <= level - 1;
    else
        level <= level;


// mid 16'h4000:16'h3FFF

always @*
    case(level)
        4'd0: begin aml = 16'hde01; amh = 16'h21FF; end
        4'd1: begin aml = 16'hd901; amh = 16'h26FF; end
        4'd2: begin aml = 16'hce01; amh = 16'h31FF; end
        4'd3: begin aml = 16'hc901; amh = 16'h36FF; end 
        4'd4: begin aml = 16'hc401; amh = 16'h3BFF; end
        4'd5: begin aml = 16'hbf01; amh = 16'h40FF; end
        4'd6: begin aml = 16'hba01; amh = 16'h45FF; end
        4'd7: begin aml = 16'hb501; amh = 16'h4AFF; end
        4'd8: begin aml = 16'hB001; amh = 16'h4FFF; end
        4'd9: begin aml = 16'hab01; amh = 16'h54FF; end
        4'd10: begin aml = 16'ha501; amh = 16'h5AFF; end
        4'd11: begin aml = 16'ha001; amh = 16'h5FFF; end
        4'd12: begin aml = 16'h9b01; amh = 16'h64FF; end
        4'd13: begin aml = 16'h9601; amh = 16'h69FF; end
        4'd14: begin aml = 16'h9101; amh = 16'h6EFF; end
        4'd15: begin aml = 16'h8c01; amh = 16'h73FF; end
        
        default: begin aml = 16'hD301; amh = 16'h2CFF; end
    endcase


always @*
    case(level)
        4'd0: begin cnt0 = 4'd0; cnt1 = 4'd0; end
        4'd1: begin cnt0 = 4'd1; cnt1 = 4'd0; end
        4'd2: begin cnt0 = 4'd2; cnt1 = 4'd0; end
        4'd3: begin cnt0 = 4'd3; cnt1 = 4'd0; end        
        4'd4: begin cnt0 = 4'd4; cnt1 = 4'd0; end
        4'd5: begin cnt0 = 4'd5; cnt1 = 4'd0; end
        4'd6: begin cnt0 = 4'd6; cnt1 = 4'd0; end
        4'd7: begin cnt0 = 4'd7; cnt1 = 4'd0; end
        4'd8: begin cnt0 = 4'd8; cnt1 = 4'd0; end
        4'd9: begin cnt0 = 4'd9; cnt1 = 4'd0; end
        4'd10: begin cnt0 = 4'd0; cnt1 = 4'd1; end
        4'd11: begin cnt0 = 4'd1; cnt1 = 4'd1; end
        4'd12: begin cnt0 = 4'd2; cnt1 = 4'd1; end
        4'd13: begin cnt0 = 4'd3; cnt1 = 4'd1; end
        4'd14: begin cnt0 = 4'd4; cnt1 = 4'd1; end
        4'd15: begin cnt0 = 4'd5; cnt1 = 4'd1; end
        default: begin cnt0 = 4'b1111; cnt1 = 4'b1111;end
    endcase

endmodule
