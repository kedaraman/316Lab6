`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/02/2018 02:21:17 PM
// Design Name: 
// Module Name: RCA_4bits
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


module RCA_4bits(
    input clk,
    input enable,
    input [3:0] A,
    input [3:0] B,
    input Cin,
    output [4:0] Q
    );
    
    wire [4:0] sum;
    wire carry0, carry1, carry2, carry3;
    
    full_adder r1(.A(A[0]),.B(B[0]),.Cin(Cin),.S(sum[0]),.Cout(carry1));
    full_adder r2(.A(A[1]),.B(B[1]),.Cin(carry1),.S(sum[1]),.Cout(carry2));
    full_adder r3(.A(A[2]),.B(B[2]),.Cin(carry2),.S(sum[2]),.Cout(carry3));
    full_adder r4(.A(A[3]),.B(B[3]),.Cin(carry3),.S(sum[3]),.Cout(sum[4]));
    
    register_logic r5(.clk(clk), .enable(enable), .Data(sum), .Q(Q));
    
    
    
    
endmodule
