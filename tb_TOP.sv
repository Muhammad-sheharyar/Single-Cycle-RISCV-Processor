`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/19/2026 02:35:30 AM
// Design Name: 
// Module Name: tb_TOP
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


module tb_TOP;
    logic clk, reset;
    
   TOP DUT(.clk(clk), .reset(reset));
   
   always #1 clk = ~clk;
   
   initial begin
    clk = 0;
    reset =1; #2
    reset =0;
    #100;
    $finish;
    end
endmodule
