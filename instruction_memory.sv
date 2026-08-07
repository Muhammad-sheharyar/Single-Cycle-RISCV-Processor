`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/17/2026 12:30:37 AM
// Design Name: 
// Module Name: instruction_memory
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


module instruction_memory
   (
    input  logic [31:0] pc_out, 
    output logic [31:0] inst 
    );
    
    logic [31:0] mem [0:84];
     
    always_comb begin
        inst = mem[pc_out];
               
     mem[0]  = 32'h00000293;
     mem[4]  = 32'h01900313; 
     mem[8]  = 32'h0062a023;
     mem[12] = 32'h00c00313;
     mem[16] = 32'h0062a223;
     mem[20] = 32'h03000313;
     mem[24] = 32'h0062a423;
     mem[28] = 32'h00700313;
     mem[32] = 32'h0062a623;
     mem[36] = 32'h01f00313;
     mem[40] = 32'h0062a823;
     mem[44] = 32'h00000393;
     mem[48] = 32'h00000e13;
     mem[52] = 32'h00500e93;
                        
     mem[56] = 32'h01de0e63;
     mem[60] = 32'h002e1f13;
     mem[64] = 32'h01e28fb3;
     mem[68] = 32'h000fa303;
     mem[72] = 32'h006383b3;
     mem[76] = 32'h001e0e13;
     mem[80] = 32'hfe0004e3;
   
     mem[84] = 32'h00000063;

////////----------------- Another Instructions ---------------/////////
//        mem[0]  = 32'h00a00293;   //addi x5,x0,10
//        mem[4]  = 32'h01400313;   //addi x6,x0,20
//        mem[8]  = 32'h01e00393;   //addi x7,x0,30
//        mem[12] = 32'h02800413;   //addi x8,x0,40
//        mem[16] = 32'h006284b3;   //add x9,x5,x6
//        mem[20] = 32'h00838533;   //add x10,x7,x8
//        mem[24] = 32'h00a485b3;   //add x11,x9,x10
    end
endmodule
