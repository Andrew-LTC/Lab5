`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/14/2021 11:07:40 PM
// Design Name: 
// Module Name: sseg_driver
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


module sseg_driver(
    input [5:0] I7,
    input [5:0] I6,
    input [5:0] I5,
    input [5:0] I4,
    input [5:0] I3,
    input [5:0] I2,
    input [5:0] I1,
    input [5:0] I0,
    input CLK100MHZ,
    output [6:0] SSEG,
    output [7:0] AN,
    output DP
    );
//    //debugging
//    wire [5:0] I7;
//    wire [5:0] I6;
//    wire [5:0] I5;
//    wire [5:0] I4;
//    wire [5:0] I3;
//    wire [5:0] I2;
//    wire [5:0] I1;
//    wire [5:0] I0;
    
//    assign I7 = 6'b100110;
//    assign I6 = 6'b000110;
//    assign I5 = 6'b100111;
//    assign I4 = 6'b000111;
//    assign I3 = 6'b1;
//    assign I2 = 6'b0;
//    assign I1 = 6'b1;
//    assign I0 = 6'b0;
    
    //data movement
    wire done;
    wire [2:0] counter_out;
    wire [5:0] D_out;
    
    //compliments for common cothode display
    wire [7:0] AN_out;
    wire DP_out;
    assign AN = ~AN_out;
    assign DP = ~DP_out;

    //1ms delay
    //Final Value = 1ms/10ns = 100_000 - 1 = 99_999
    timer_parameter #(.FINAL_VALUE(99_999)) timer (
        .clk(CLK100MHZ),
        .reset_n(1'b1),
        .enable(1'b1),
        .done(done)
    );
    udl_counter #(.BITS(3)) counter (
        .clk(CLK100MHZ),
        .reset_n(1'b1),
        .enable(done),
        .up(1'b1),
        .load(1'b0),
        .Q(counter_out)
    );
    decoder_generic #(.N(3)) displaySelect (
        .w(counter_out),
        .en(D_out[5]),
        .y(AN_out)
    );
    nbit_8x1_mux #(.N(6)) dataIN (
        .w0(I7),
        .w1(I6),
        .w2(I5),
        .w3(I4),
        .w4(I3),
        .w5(I2),
        .w6(I1),
        .w7(I0),
        .s(counter_out),
        .f(D_out)
    );
    hex2sseg displayNum (
        .hex(D_out[4:1]),
        .sseg(SSEG)
    );
    assign DP_out = D_out[0];
endmodule