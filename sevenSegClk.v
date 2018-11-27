`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2018 12:09:30 AM
// Design Name: 
// Module Name: sevenSegClk
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


module sevenSegClk(
    input clk,
    input reset,
    output clk_out
    );
    
    reg [15:0] COUNT = 16'b0000000000000000;//Change to [24:0] TBD
    
    assign clk_out = /*COUNT[24]*/COUNT[15];//Change to [24] TBD
    
    //reg [1:0] COUNT = 2'b00;//Change to [24:0] TBD
        
    //assign clk_out = /*COUNT[24]*/COUNT[1];//Change to [24] TBD
    
    always @(posedge clk)
    begin
        if(reset)
            COUNT = 0;
        else
            COUNT = COUNT + 1;
    end
        
endmodule

