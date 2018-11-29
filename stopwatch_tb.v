`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2018 05:57:45 PM
// Design Name: 
// Module Name: stopwatch_tb
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


module stopwatch_tb;
    
    
        reg clk;
        reg reset;
        reg b;
        reg [3:0] LSB;
        reg [3:0] MSB;
        reg [1:0] mode;
        wire [3:0] an;
        wire [6:0] sseg;
        wire [16:0] timeX;
        wire [4:0] stateX;
        wire [16:0] synchInit;
    
    controller cntl(.clk(clk),.reset(reset),.b(b),.LSB(LSB),.MSB(MSB),.mode(mode),.an(an),.sseg(sseg));
    
    
    initial
    begin
    //Initialization
    clk = 0;
    b = 0;
    reset = 0;
    mode = 2'b01;
    LSB = 4'b0001;
    MSB = 4'b0001;
    $display("START");
    #50
    
    b = 1;
    
    #20;
    
    b = 0;
    /*
    #700;
    
    reset = 1;
    
    #20;
    
    reset = 0;
    
    #20
    
    b = 0;
    
    #50
    
    reset = 1;
    
    #50
    
    reset = 0;
    b = 0;
    
    
    #50
    
    b = 1;
    
    #50
    
    b = 0;
    
    #50
    
    b = 1;
    
    #50
    
    b = 0;
    
    #50
    
    b = 1;
    
    #50
    
    b = 0;
    */
    end
    
    
    always
    #5 clk = ~clk;
    
endmodule
