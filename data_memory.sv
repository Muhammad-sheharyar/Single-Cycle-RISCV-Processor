`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/18/2026 05:37:27 PM
// Design Name: 
// Module Name: data_memory
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


module data_memory
    (
    input logic clk,reset,
    input logic [31:0] Address, WriteData,
    input logic MemWrite, MemRead,
    output logic [31:0] ReadData
    );
    
     logic [31:0] data_mem [0:31];

    always_ff @(posedge clk or negedge reset)
    begin
        if(reset)
        begin
            for(int i=0; i<32; i++)
            data_mem[i] <= 32'b0;
        end
        else if(MemWrite)
        begin
            data_mem[Address[6:2]] <= WriteData;
        end
    end

    always_comb
    begin
        if(MemRead)
            ReadData = data_mem[Address[6:2]];
        else
        ReadData = 32'b0;
    end

endmodule
