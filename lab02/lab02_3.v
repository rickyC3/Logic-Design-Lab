`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/06 01:18:55
// Design Name: 
// Module Name: lab02_3
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


module lab02_3(s, g, led_c, led_b);
input [7:0]s;
input [7:0]g;
output [2:0]led_c;
output [2:0]led_b;

reg [2:0]led_c;
reg [2:0]led_b;
reg [2:0]c= 0;
reg [2:0]b= 0;

always @* begin
    b = 0;
    c = 0;
    if (g[7:4] == s[7:4])
        b = b + 1;
    else if (g[7:4] == s[3:0])
        c = c + 1;
	else
		b = b;

    
    if (g[3:0] == s[3:0])
        b = b + 1;
    else if (g[3:0] == s[7:4])
        c = c + 1;
	else
		b = b;
    
    if ((s[7:4] == s[3:0]) || (g[7:4] == g[3:0])) begin
        b = 3'd4;
        c = 3'd4;
    end else
		b = b;
		
    
    case (c)
        3'd0: led_c = 3'b001;
        3'd1: led_c = 3'b010;
        3'd2: led_c = 3'b100;
        default: led_c = 3'b000;
    endcase
    case (b)
        3'd0: led_b = 3'b001;
        3'd1: led_b = 3'b010;
        3'd2: led_b = 3'b100;
        default: led_b = 3'b000;
    endcase
    
    
    //$display("s = %d, %d, g = %d, %d", s[7:4], s[3:0], g[7:4], g[3:0]);
    //$display("b = %d, c = %d", b, c);
    
end
        

endmodule
