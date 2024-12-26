`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/02/14 09:12:00
// Design Name: 
// Module Name: test
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


module test(

    );
    reg [3:0] a;
    reg [3:0] b;
    reg m;
    wire [3:0] addsub_s;
    wire addsub_v;

    
 
    
    lab01_2 Uaddsub(
		.a(a),
		.b(b),
		.m(m),
		.v(addsub_v),
		.s(addsub_s)
    );
    
    
    initial begin
        m = 1'b0;
        a = 4'd3;
        b = 4'd4;
        #10;
        
        m = 1'b1;
        a = 4'd3;
        b = 4'd4;
        #10;
        
        m = 1'b0;
        a = 4'd4;
        b = 4'd4;
        #10;
        
        m = 1'b1;
        a = 4'b1100;
        b = 4'd5;
        #10;
        
        m = 1'b1;
        a = 4'd4;
        b = 4'b1100;
        #10;
        
        m = 1'b1;
        a = 4'b1100;
        b = 4'd4;
        
    end
endmodule
