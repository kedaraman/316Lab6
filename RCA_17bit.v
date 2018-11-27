`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2018 04:21:06 PM
// Design Name: 
// Module Name: RCA_17bit
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


module RCA_17bit(
    input clk,
    input enable,
    input [16:0] A,
    input [16:0] B,
    input Cin,
    output [16:0] Q
    );
    
    wire [16:0] sum;
    wire carry0, carry1, carry2, carry3, carry4,carry5,carry6,carry7,carry8,carry9,carry10,carry11,carry12,carry13,carry14,carry15,carry16;
    //assign carry0 = Cin;
    full_adder r1(.A(A[0]),.B(B[0]),.Cin(Cin),.S(sum[0]),.Cout(carry0));
    full_adder r2(.A(A[1]),.B(B[1]),.Cin(carry0),.S(sum[1]),.Cout(carry1));
    full_adder r3(.A(A[2]),.B(B[2]),.Cin(carry1),.S(sum[2]),.Cout(carry2));
    full_adder r4(.A(A[3]),.B(B[3]),.Cin(carry2),.S(sum[3]),.Cout(carry3));
    full_adder r5(.A(A[4]),.B(B[4]),.Cin(carry3),.S(sum[4]),.Cout(carry4));
    full_adder r6(.A(A[5]),.B(B[5]),.Cin(carry4),.S(sum[5]),.Cout(carry5));
    full_adder r7(.A(A[6]),.B(B[6]),.Cin(carry5),.S(sum[6]),.Cout(carry6));
    full_adder r8(.A(A[7]),.B(B[7]),.Cin(carry6),.S(sum[7]),.Cout(carry7));
    full_adder r9(.A(A[8]),.B(B[8]),.Cin(carry7),.S(sum[8]),.Cout(carry8));
    full_adder r10(.A(A[9]),.B(B[9]),.Cin(carry8),.S(sum[9]),.Cout(carry9));
    full_adder r11(.A(A[10]),.B(B[10]),.Cin(carry9),.S(sum[10]),.Cout(carry10));
    full_adder r12(.A(A[11]),.B(B[11]),.Cin(carry10),.S(sum[11]),.Cout(carry11));
    full_adder r13(.A(A[12]),.B(B[12]),.Cin(carry11),.S(sum[12]),.Cout(carry12));
    full_adder r14(.A(A[13]),.B(B[13]),.Cin(carry12),.S(sum[13]),.Cout(carry13));
    full_adder r15(.A(A[14]),.B(B[14]),.Cin(carry13),.S(sum[14]),.Cout(carry14));
    full_adder r16(.A(A[15]),.B(B[15]),.Cin(carry14),.S(sum[15]),.Cout(carry15));
    full_adder r17(.A(A[16]),.B(B[16]),.Cin(carry15),.S(sum[16]),.Cout(carry16));               
    
    
    register_17bit regFA(.clk(clk), .enable(enable), .Data(sum), .Q(Q));
    
    
    
    
endmodule