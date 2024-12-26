`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/02 16:05:17
// Design Name: 
// Module Name: lab01_2
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


module lab01_2(a, b, m, s, v);
parameter n = 4;
    input [3:0]a;
    input [3:0]b;
    input m;
    
    output reg [3:0]s;
    output reg v = 0;
    reg [3:0]B;
    reg [4:0]c = 0;
    integer i;
    always @* begin
        // 2' complement Converter
        if (m == 1) begin
            B = ~b;
            B = B + 1;
        end else 
            B = b;
        
        // 4 bits Full Adder
        for (i=0;i<n;i=i+1) begin
            c[i+1] = (a[i]&B[i]) | (a[i]&c[i]) | (B[i]&c[i]);
            s[i] = ((a[i]^B[i])^c[i]);
         end
     
        v = c[4]^c[3];
    end
endmodule
