`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/17/2026 08:59:20 PM
// Design Name: 
// Module Name: mux_32bit
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


module mux_32bit
    (
    input logic Sel,
    input logic [31:0] A,
    input logic [31:0] B,
    output logic [31:0] mux_out
    );
    
   
   assign mux_out = Sel ? B : A;
    
endmodule
