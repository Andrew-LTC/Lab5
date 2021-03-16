`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/14/2021 11:17:53 PM
// Design Name: 
// Module Name: nbit_8x1_mux
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


module nbit_8x1_mux
    #(parameter N = 4)(
    input [N-1:0] w0,w1,w2,w3,w4,w5,w6,w7,
    input [2:0] s,
    output reg [N-1:0] f
    );
    
    always @(w0,w1,w2,w3,w4,w5,w6,w7,s)
    begin
        case(s)
            3'b000: f = w0;
            3'b001: f = w1;
            3'b010: f = w2;
            3'b011: f = w3;
            3'b100: f = w4;
            3'b101: f = w5;
            3'b110: f = w6;
            3'b111: f = w7;
            default: f = 'bx;
        endcase
    end
endmodule
