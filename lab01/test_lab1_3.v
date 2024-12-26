`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/02/20 03:57:33
// Design Name: 
// Module Name: test_lab1_3
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


module test_lab1_3();
    reg  [2:0] A,B,C;
    wire [2:0] O;
    
    lab01_3 U0(.a(A),.b(B),.c(C),.o(O));
    
    initial
    begin
        A = 3'b 000;
        B = 3'b 001;
        C = 3'b 010;
        #10
        A = 3'b 100;
        B = 3'b 010;
        C = 3'b 001;
        #10
        A = 3'b 110;
        B = 3'b 110;
        C = 3'b 110;
        #10
        A = 3'b 101;
        B = 3'b 011;
        C = 3'b 111;
        #10
        A = 3'b 100;
        B = 3'b 111;
        C = 3'b 110;
        #10
        A = 3'b 111;
        B = 3'b 010;
        C = 3'b 000;
        #10
        A = 3'b 100;
        B = 3'b 000;
        C = 3'b 011;
        
    end
endmodule
