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
    output reg clk_out
    );
    
    //reg [1:0] COUNT=2'b00;//Change to [24:0] TBD
    
    //assign clk_out = COUNT[1];//Change to [24] TBD
    
    reg [20:0] COUNT = 21'd0;
    //assign clk_out = ~(|(COUNT));
    
    always @(posedge clk)
    begin
        if(reset)
            COUNT = 0;
        else
            if(COUNT == 1010765) begin
                COUNT = 0;
            end
            else if(COUNT >= 505382) begin
                clk_out = 1;
                COUNT = COUNT + 1;
            end
            else begin
                clk_out = 0;
                COUNT = COUNT + 1;
            end
    end
        
endmodule
