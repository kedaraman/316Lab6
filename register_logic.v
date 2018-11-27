`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/02/2018 02:15:47 PM
// Design Name: 
// Module Name: register_logic
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


module register_logic(
    input clk,
    input enable,
    input [4:0] Data,
    output reg [4:0] Q
    );
    
    
    
    //Sequential Block
    always @(posedge clk) begin
        if(enable)
            Q = Data;
    end
    
    
endmodule
