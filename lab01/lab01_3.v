`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/03 11:48:58
// Design Name: 
// Module Name: lab01_3
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


module lab01_3(a, b, c, o);
    input signed [2:0]a;
    input signed  [2:0]b;
    input signed [2:0]c;
    output signed[2:0]o;
    reg signed [2:0]o;
    
    always @* begin
        if (a < b) begin
            o = a;
        end else
            o = b;
            
        if (c < o) begin
            o = c;
        end else
            o = o;

    end
endmodule
