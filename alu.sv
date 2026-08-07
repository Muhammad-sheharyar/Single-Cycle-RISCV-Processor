`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/18/2026 05:22:05 PM
// Design Name: 
// Module Name: alu
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


module alu
    (
    input logic [31:0] a,b,
    input logic [3:0] Sel,
    output logic [31:0] out,
    output logic zero
    );
    
    always_comb begin
        case(Sel)
        4'b0000  :   out = a & b;
        4'b0001  :   out = a | b;
        4'b0010  :   out = a + b;
        4'b0110  :   out = a - b;
        4'b1111  :   out = a << b[4:0];
        default  :   out = 32'b0;
        endcase
        zero     =   (out == 32'b0);
        end
endmodule
