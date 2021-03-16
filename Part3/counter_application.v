`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/15/2021 03:40:49 PM
// Design Name: 
// Module Name: counter_application
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


module counter_application(
    input [13:0] X,
    input upButton,
    input downButton,
    input loadButton,
    input resetButton,
    input CLK100MHZ,
    output [6:0] SSEG,
    output [7:0] AN,
    output DP
    );
    
    //button outputs
    wire up,down,load,reset;
    button Up (
        .clk(CLK100MHZ),
        .in(upButton),
        .out(up)
    );
    button Down (
        .clk(CLK100MHZ),
        .in(downButton),
        .out(down)
    );
    button Load (
        .clk(CLK100MHZ),
        .in(loadButton),
        .out(load)
    );
    button Reset (
        .clk(CLK100MHZ),
        .in(resetButton),
        .out(reset)
    );
    
    //data movement
    wire [7:0] counter_out;
    wire [11:0] sseg_out;
    wire done;

    //1sec delay
    //Final Value = 500ms/10ns = 50,000,000 - 1 = 49_999_999 counts
    timer_parameter #(.FINAL_VALUE(49_999_999)) timerMain (
        .clk(CLK100MHZ),
        .reset_n(~reset),
        .enable(1'b1),
        .done(done)
    );
    udl_counter #(.BITS(8)) Input (
        .clk(CLK100MHZ),
        .reset_n(~reset),
        .enable(done),
        .up(~up),
        .load(load),
        .D(X[7:0]),
        .Q(counter_out)
    );
    bin2bcd Conversion (
        .bin(counter_out),
        .bcd(sseg_out)
    );
    sseg_driver Driver (
        .I7(6'b0),
        .I6(6'b0),
        .I5(6'b0),
        .I4(6'b0),
        .I3(6'b0),
        .I2({X[13],sseg_out[11:8],X[10]}),
        .I1({X[12],sseg_out[7:4],X[9]}),
        .I0({X[11],sseg_out[3:0],X[8]}),
        .CLK100MHZ(CLK100MHZ),
        .SSEG(SSEG),
        .AN(AN),
        .DP(DP)
    );  
endmodule
