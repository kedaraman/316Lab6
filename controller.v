`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2018 08:05:14 PM
// Design Name: 
// Module Name: controller
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


module controller(
    input clk,
    input reset,
    input b,
    input [3:0] LSB,
    input [3:0] MSB,
    input [1:0] mode,
    output [3:0] an,
    output [6:0] sseg,
    output [3:0] stateDebug
    //output [16:0] synchronizeInit,
    );
    
    localparam [4:0] waitInit = 0,
                     waitButRel = 1,
                     selectMode = 2,
                     loadValSWDef = 3,
                     pauseSWDef = 4,
                     waitPauseSWDef = 5,
                     waitPauseSWDefButRel = 6,
                     countUpSWDef = 7,
                     doneSWDef = 8,
                     loadValTimerDef = 9,
                     pauseTimer = 10,
                     countDownTimer = 11,
                     waitPauseTimer = 12,
                     waitPauseTimerButRel = 13,
                     doneTimer = 14;
                     
    
    reg [4:0] state;
    
    //wire [16:0] Time;
    reg [16:0] Init;
    wire tc; //When the count reaches max
    
    reg [16:0] temp1;
    reg [16:0] temp2;
    reg [16:0] MSBmultiplier = 17'd1000;
    reg [16:0] LSBmultiplier = 17'd100;
    reg anReset;

        reg init_ld_en;
        reg count_en;
        reg [2:0] ctrSelect;
        reg tcSelect;
        wire tcLimitReached;
        wire [16:0] synchronizeInit;

    datapath dp(.clk(clk), .init_ld_en(init_ld_en), .count_en(count_en), .ctrSelect(ctrSelect), .InitVal(Init), .tcSelect(tcSelect),.anReset(anReset),
             .tcLimitReached(tcLimitReached), .an(an), .sseg(sseg), .synchInit(synchronizeInit));
    
    assign stateDebug = state;
    
    
    
    always @(posedge clk) begin
        //State Transitions
        case (state)
            waitInit : begin
                if(b) begin
                    state = waitButRel;
                end
            end
            waitButRel : begin
                if(!b) begin
                    state = selectMode;
                end
            end
            selectMode : begin
                if(!mode[1] && !mode[0] && !reset) begin
                    state = loadValSWDef;
                end
                else if (!mode[1] && mode[0] && !reset) begin
                    state = loadValSWDef;
                end
                else if(mode[1] && !mode[0] && !reset) begin
                    state = loadValTimerDef;
                end
                else if(mode[1] && mode[0] && !reset) begin
                    state = loadValTimerDef;
                end
            end
            //Keep going!
            loadValSWDef : begin
                if(reset) begin
                    state = selectMode;
                end
                else if(tcLimitReached) begin
                    state = doneSWDef;
                end
                else if(b && !reset) begin
                    state = pauseSWDef;
                end
                else if(!b && !reset) begin
                    state = countUpSWDef;
                end
            end
            pauseSWDef : begin
                if(reset) begin
                    state = selectMode;
                end
                else if(!b && !reset) begin
                    state = waitPauseSWDef;
                end
            end
            waitPauseSWDef : begin
                if(reset) begin
                    state = selectMode;
                end
                else if(b && !reset) begin
                    state = waitPauseSWDefButRel;
                end
            end
            waitPauseSWDefButRel : begin
                if(reset) begin
                    state = selectMode;
                end
                else if(!b && !reset) begin
                    state = countUpSWDef;
                end
            end
            countUpSWDef : begin
                if(reset) begin
                    state = selectMode;
                end
                else if(b && !reset) begin
                    state = pauseSWDef;
                end
                else if(tcLimitReached) begin
                    state = doneSWDef;
                end
            end
            doneSWDef : begin
                if(reset) begin
                    state = selectMode;
                end
            end        
            //CONTINUE FOR OTHER 3 MODES 
            loadValTimerDef: begin
                if(reset) begin
                    state = selectMode;
                end
                else if(synchronizeInit != Init)
                begin
                    state = loadValTimerDef;
                end
                else if(tcLimitReached) begin
                    state = doneTimer;
                end
                else if(b && !reset) begin
                    state = pauseTimer;
                end
                else if(!b && !reset) begin
                    state = countDownTimer;
                end
            end
            pauseTimer: begin
                if(reset) begin
                    state = selectMode;
                end  
                else if(!b && !reset) begin
                    state = waitPauseTimer;
                end         
            end
            waitPauseTimer: begin
                if(reset) begin
                    state = selectMode;
                end
                else if(b && !reset) begin
                    state = waitPauseTimerButRel;
                end
            
            end
            waitPauseTimerButRel: begin
                if(reset) begin
                    state = selectMode;
                end
                else if(!b && !reset) begin
                    state = countDownTimer;
                end
            end
            countDownTimer: begin
                if(reset) begin
                    state = selectMode;
                end
                else if(b && !reset) begin
                    state = pauseTimer;
                end
                else if(tcLimitReached) begin
                    state = doneTimer;
                end
            end
            doneTimer: begin
                if(reset) begin
                    state = selectMode;
                end
            end
             
            default: begin
                state = waitInit;
            end 
        endcase
        
        //State Actions
        case (state)
            waitInit : begin
                init_ld_en = 1;
                count_en = 1;
                ctrSelect = 3;
                anReset = 1;
                //synchronizeInit = 17'b11111111111111111;
                $display("INITIALIZED");
                
            end
            
            selectMode : begin
                //Assuming Mode 1
                anReset = 0;
                count_en = 1;
                if(mode[1]) begin
                    $display("TIMER");
                    ctrSelect = 0;
                end
                else begin
                    $display("SW");
                    ctrSelect = 3;
                end
            end
            
            loadValSWDef : begin
                ctrSelect = 3;
                tcSelect = 0;
                count_en = 1;
                //Make Init the vals from LSB and MSB, initlden, etc
                if(mode[0] && !mode[1] && LSB <= 9 && MSB <= 9)
                begin
                    temp1 = MSB * MSBmultiplier;
                    temp2 = LSB * LSBmultiplier;
                    Init = temp1 + temp2;
                end
                else
                begin
                    Init = 17'd9999;    
                end

                
                init_ld_en=1;
                $display("LOAD VAL SW DEF");
            end
            
            pauseSWDef : begin
                count_en = 0;
                $display("PAUSE SW DEF");
            
            end
            
            waitPauseSWDef : begin
                $display("WAIT PAUSE SW DEF");
            end
            
            countUpSWDef  : begin
                count_en = 1;
                ctrSelect = 1;
                tcSelect = 0;
                //$display("COUNTING UP %d", timeTest);
                
            end
            
            doneSWDef : begin
                count_en = 0;
                $display("DONE COUNTING");
            end
            
            loadValTimerDef: begin
                ctrSelect = 0;
                tcSelect = 1;
                count_en = 1;
                init_ld_en=1;
                //Make Init the vals from LSB and MSB, initlden, etc
                if(mode[0] && mode[1] && LSB <= 9 && MSB <= 9)
                begin
                    temp1 = MSB * MSBmultiplier;
                    temp2 = LSB * LSBmultiplier;
                    Init = temp1 + temp2;
                end
                else
                begin
                    Init = 17'd9999;    
                end
            
                            
                
                $display("LOAD VAL TIMER");
            
            end
            
            pauseTimer: begin
                count_en = 0;
                $display("PAUSE TIMER");
            
            end
            
            countDownTimer: begin
                count_en = 1;
                ctrSelect = 2;
                tcSelect = 1;
                //$display("COUNTING DOWN %d", timeTest);
            
            end
            
            waitPauseTimer: begin
                $display("WAIT PAUSE TIMER");
            end
            
            waitPauseTimerButRel: begin
                $display("WAIT PAUSE TIMER BUT REL");
            end
            
            doneTimer: begin
                count_en = 0;
                $display("DONE COUNTING DOWN FROM TIMER");
            end
        
        
        endcase
    end
    
    
    
            
endmodule
