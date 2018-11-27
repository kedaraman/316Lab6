`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/19/2018 01:37:29 AM
// Design Name: 
// Module Name: Mux_behavioral
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


module mux(
    input [16:0] i0,
    input [16:0] i1,
    input [16:0] i2,
    input [16:0] i3,
    input [1:0] select,
    output reg [16:0] d
    );
    
    
    always @(i0,i1,i2,i3,select[0],select[1])
    begin
        d = 0;
        
        if(select[0]==1'b0 && select[1]==1'b0) begin
              d=i0; 
        end     
        else if(select[0]==1'b1 && select[1]==1'b0) begin
              d=i1; 
        end
        else if(select[0]==1'b0 && select[1]==1'b1) begin
              d=i2; 
        end
        else if(select[0]==1'b1 && select[1]==1'b1) begin
              d=i3; 
        end
    end    
    
endmodule

