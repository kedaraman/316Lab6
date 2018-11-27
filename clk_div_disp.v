`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/25/2018 02:00:16 AM
// Design Name: 
// Module Name: clk_div_disp
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


module clk_div_disp(
    input clk,
    input reset,
    output clk_out
    );
    
    //reg [1:0] COUNT=2'b00;//Change to [24:0] TBD
    
    //assign clk_out = COUNT[1];//Change to [24] TBD
    
    reg [22:0] COUNT = 23'd4569228;
    assign clk_out = ~(|(COUNT));
    
    always @(posedge clk)
    begin
        if(reset)
            COUNT = 0;
        else
            COUNT = (COUNT + 1) % 3046152;
    end
        
endmodule
