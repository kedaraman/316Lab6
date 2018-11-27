`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2018 05:27:24 PM
// Design Name: 
// Module Name: equality_comparator
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


module equality_comparator(
        input [16:0] a,
        input [16:0] b,
        output reg equality
    );
    
    always @(a, b) begin
        equality = (a[0] ^~ b[0]) & (a[1] ^~ b[1]) & (a[2] ^~ b[2]) & (a[3] ^~ b[3]) & (a[4] ^~ b[4]) & (a[5] ^~ b[5]) & (a[6] ^~ b[6])
                    & (a[7] ^~ b[7]) & (a[8] ^~ b[8]) & (a[9] ^~ b[9]) & (a[10] ^~ b[10]) & (a[11] ^~ b[11]) & (a[12] ^~ b[12]) & (a[13] ^~ b[13])
                    & (a[14] ^~ b[14]) & (a[15] ^~ b[15]) & (a[16] ^~ b[16]);
    end                

    
endmodule
