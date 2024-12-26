`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/09 15:07:53
// Design Name: 
// Module Name: test_lab02_2
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


module test_lab02_2();

reg [3:0]i;
wire [7:0]D;
wire [3:0]d;
wire [3:0]ssd;


lab02_2 U0(.i(i), .D(D), .d(d), .ssd(ssd));
initial
begin
    i = 0;
    repeat(16) begin
        #10 i = i + 1;     
    end
end

endmodule
