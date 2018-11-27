`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/02/2018 02:05:28 PM
// Design Name: 
// Module Name: full_adder
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


module full_adder(
    input wire A,
    input wire B,
    input wire Cin,
    output wire S,
    output wire Cout
    );
    
    wire Sums;
    wire carry;
    assign Sums = (A^B^Cin);
    assign carry = (B & Cin) | (A & Cin) | (B & A);
    
    assign S = Sums;
    assign Cout = carry;
    
    
endmodule
