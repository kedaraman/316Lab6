`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2018 04:16:52 PM
// Design Name: 
// Module Name: register_17bit
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


module register_17bit(
    input clk,
    input enable,
    input [16:0] Data,
    output reg [16:0] Q
    );
    
    
    
    //Sequential Block
    always @(posedge clk) begin
        if(enable)
            Q = Data;
    end
    
    
endmodule
