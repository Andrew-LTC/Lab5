`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/14/2021 03:08:05 PM
// Design Name: 
// Module Name: first_sseg_driver
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


module first_sseg_driver(
    input [2:0] active_digit,
    input [3:0] num,
    input DPctrl,
    output [6:0] SSEG,
    output [7:0] AN,
    output DP
    );
    
    //decoder output for AN's
    wire [7:0] sseg_en;
    
    //assign AN and DP compliement since common cathode
    //assign AN the inverse of the decoder output
    assign AN = {~sseg_en[0],~sseg_en[1],~sseg_en[2],~sseg_en[3],~sseg_en[4],~sseg_en[5],~sseg_en[6],~sseg_en[7]};
    assign DP = ~DPctrl;
    
    decoder_generic #(.N(3)) digit_select (
        .w(active_digit),
        .en(1'b1),
        .y(sseg_en)   
    );
    
    hex2sseg display (
        .hex(num),
        .sseg(SSEG)
    );
endmodule
