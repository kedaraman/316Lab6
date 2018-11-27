`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2018 04:10:05 PM
// Design Name: 
// Module Name: datapath
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


module datapath(
    input clk,
    input init_ld_en,
    input count_en,
    input [1:0] ctrSelect,
    input [16:0] InitVal,
    input tcSelect,
    input anReset,
    output tcLimitReached,
    output [3:0] an,
    output [6:0] sseg,
    output wire [16:0] synchInit
    );
    
    
    
    wire ms_clk;
    wire clkReset=0;
    
    wire [16:0] countUpWire;
    wire [16:0] countDownWire;
    
    clk_div_disp secondClock (.clk(clk),.reset(clkReset),.clk_out(ms_clk));
    
    wire [16:0] initValStoreOut;
    
    wire [16:0] tempInitRegInput;
    //assign tempInitRegInput = 17'b000010101010010100000; //87.20 temp val for DEBUGGING ONLY
    assign tempInitRegInput = 17'b00000000000000100;  
      
        
    register_17bit initValStore (.clk(clk),.enable(init_ld_en),.Data(InitVal),.Q(initValStoreOut));

    wire [16:0] muxReturn;
    wire [16:0] Time;
    mux counterMux (.i0(initValStoreOut), .i1(countUpWire), .i2(countDownWire), .i3(17'b00000000000000000), .select(ctrSelect), .d(muxReturn));
    register_17bit counterReg (.clk(ms_clk), .enable(count_en), .Data(muxReturn), .Q(Time));
    
    RCA_17bit countUp (.clk(clk),.enable(1'b1), .A(Time), .B(17'b00000000000000001), .Cin(1'b0), .Q(countUpWire));
    RCA_17bit countDown (.clk(clk),.enable(1'b1), .A(Time), .B(-17'b00000000000000001), .Cin(1'b0), .Q(countDownWire));
    
    wire equalsInit;
    equality_comparator eq(.a(Time), .b(initValStoreOut), .equality(equalsInit));
    
    assign synchInit = Time;
    
    wire checkIfZero;
    assign checkIfZero = ~(Time[0] | Time[1] | Time[2] | Time[3] | Time[4] | Time[5] | Time[6] | Time[7] | Time[8] 
                            | Time[9] | Time[10] | Time[11] | Time[12] | Time[13] | Time[14] | Time[15] | Time[16]);
    mux2to1 tcMux (.i0(equalsInit),.i1(checkIfZero),.select(tcSelect), .d(tcLimitReached));
                            
    
    //7SEG DISPLAY
        wire [6:0] in0, in1, in2, in3;
        wire slow_clk;
        wire [4:0] digit0, digit1, digit2, digit3; //LSB to MSB
        assign digit0 = Time % 10;
        assign digit1 = (Time / 10)%10;
        assign digit2 = (Time / 100)% 10;
        assign digit3 = (Time/1000) % 10;
        
        //Instantiation of hexTo7 Decoder
        hexto7segment c1 (.x(digit0), .r(in0));
        hexto7segment c2 (.x(digit1), .r(in1));
        hexto7segment c3 (.x(digit2), .r(in2));
        hexto7segment c4 (.x(digit3), .r(in3));
        
        //Instatiation of Clock Divider
        sevenSegClk c5  (.clk(clk), .reset(clkReset), .clk_out(slow_clk));
        
        //Module Instantiation of Mux
        time_mux_state_machine c6(
            .clk(slow_clk),
            .reset(anReset),
            .in0(in0),
            .in1(in1),
            .in2(in2),
            .in3(in3),
            .an(an),
            .sseg(sseg));
    
    
    
    
    
    
    
    
    
    
endmodule
