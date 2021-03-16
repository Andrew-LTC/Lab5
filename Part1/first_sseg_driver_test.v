`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/14/2021 03:18:13 PM
// Design Name: 
// Module Name: first_sseg_driver_test
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


module first_sseg_driver_test(
    input DPsw,
    input CLK100MHZ,
    input resetButton,
    input upSW,
    output [6:0] SSEG,
    output [7:0] AN,
    output DP
    );
    
    wire [3:0] X;
    wire counter_en;
    //button outputs
    wire reset,up;
    
    button Reset (
        .clk(CLK100MHZ),
        .in(resetButton),
        .out(reset)
    );
    
    //1sec delay
    //Final Value = 500ms/10ns = 50,000,000 - 1 = 49,999,999 counts
    //too slow
    
    //1us delay
    //Final Value = 1us/10ns = 100 -1 = 99 counts
    //too fast
    
    //1ms delay
    //Final Value = 1ms/10ns = 100,000 - 1 = 99_999
    timer_parameter #(.FINAL_VALUE(99_999)) timer (
        .clk(CLK100MHZ),
        .reset_n(~reset),
        .enable(1'b1),
        .done(counter_en)
    );
    
    udl_counter #(.BITS(3)) counter (
        .clk(CLK100MHZ),
        .reset_n(~reset),
        .enable(counter_en),
        .up(~upSW),
        .load(1'b0),
        .Q(X)
    );
    
    first_sseg_driver SSEGdriver (
        .active_digit(X),
        .num(X),
        .DPctrl(DPsw),
        .SSEG(SSEG),
        .AN(AN),
        .DP(DP)
    );
endmodule
