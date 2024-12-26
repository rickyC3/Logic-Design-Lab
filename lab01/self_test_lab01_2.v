`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/02 16:06:54
// Design Name: 
// Module Name: test_lab01_2
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

// self testbench
module test_lab01_2();
wire [3:0]S;
wire V;
reg [3:0]A;
reg [3:0]B;
reg M;
    
    
lab01_2 U0(.a(A), .b(B), .m(M), .v(V), .s(S));
    initial
    begin
        A = 0;B = 0;
        repeat(256)
        begin
    
            #1 M = 0;
            #1 M = 1;
            
    
            if (B == 4'b1111) begin
                B = 0;
                A = A+1;
            end else 
                B = B + 1;
    
        end
        
    
    end
endmodule
