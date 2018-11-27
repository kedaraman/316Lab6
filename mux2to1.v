`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2018 05:38:39 PM
// Design Name: 
// Module Name: mux2to1
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


module mux2to1(
    input  i0,
    input  i1,
    input  select,
    output reg d
    );
    
    
    always @(i0,i1,select)
    begin
        d = 0;
        
        if(select == 1'b0) begin
            d = i0;
        end
        else if(select == 1'b1) begin
            d = i1;
        end
    end    
    
endmodule
