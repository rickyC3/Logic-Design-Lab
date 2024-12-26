`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/18 13:01:21
// Design Name: 
// Module Name: Operation
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


module Operation(clk, rst_p, press_enter, add0, add1, aug0, aug1, opr, out0, out1, out2, out3);
input clk, rst_p, press_enter;
input [3:0]add0, add1, aug0, aug1, opr;
output reg [3:0]out0, out1, out2, out3;

// adder
wire add_carry;
wire [3:0]add_sum0, add_sum1, add_sum2;
// subtractor
wire sub_carry, sub_carry2;
reg [3:0]sub_add0, sub_add1, sub_aug0, sub_aug1;
wire [3:0]sub_sum0, sub_sum1;
reg [3:0]sub_sum2;

// mul
wire [3:0]mul_sum0, mul_sum1, mul_sum2, mul_sum3; 

always @*// big to small
    if (add1 > aug1 || ((add1 == aug1)&& (add0 > aug0))) begin
        sub_add0 = add0;
        sub_add1 = add1;
        sub_aug0 = aug0;
        sub_aug1 = aug1;
        sub_sum2 = 4'd0;
    end else begin
        sub_add0 = aug0;
        sub_add1 = aug1;
        sub_aug0 = add0;
        sub_aug1 = add1;
        sub_sum2 = 4'd14;
    end


DecFullAdder adder0(.cin(0), .cnt0(add0), .cnt1(aug0), .sum0(add_sum0), .carry(add_carry));
DecFullAdder adder1(.cin(add_carry), .cnt0(add1), .cnt1(aug1), .sum0(add_sum1), .carry(add_sum2));

DecSubtractor subor0(.cin(0), .cnt0(sub_add0), .cnt1(sub_aug0), .sub0(sub_sum0), .carry(sub_carry));
DecSubtractor subor1(.cin(sub_carry), .cnt0(sub_add1), .cnt1(sub_aug1), .sub0(sub_sum1), .carry(sub_carry2));

//Multiplier(.clk(clk), .rst_p(rst_p), .press_enter(press_enter), .add0(add0), .add1(add1), .aug0(aug0), .aug1(aug1), 
//           .sum3(mul_sum3), .sum2(mul_sum2), .sum1(mul_sum1), .sum0(mul_sum0));

Multiplier2 multi2(.add0(add0), .add1(add1), .aug0(aug0), .aug1(aug1),
                   .sum3(mul_sum3), .sum2(mul_sum2), .sum1(mul_sum1), .sum0(mul_sum0));

always @*
    if (opr == 4'd10) begin // +
        out0 = add_sum0;
        out1 = add_sum1;
        out2 = add_sum2; 
        out3 = 4'd15;
     end else if (opr == 4'd11) begin // -
        out0 = sub_sum0;
        out1 = sub_sum1;
        out2 = sub_sum2; // '-' sign
        out3 = 4'd15;
     end else if (opr == 4'd12) begin// *
        out3 = mul_sum3;
        out2 = mul_sum2;
        out1 = mul_sum1;
        out0 = mul_sum0;
     end else begin
        out3 = 4'd15;
        out2 = 4'd15;
        out1 = 4'd15;
        out0 = 4'd15;end
        
endmodule
