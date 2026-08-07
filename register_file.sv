`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/17/2026 01:30:55 AM
// Design Name: 
// Module Name: register_file
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


module register_file
 
    (
    input  logic clk,
    input  logic reset,
    input  logic wr_en,

    input  logic [4:0] rs1_addr,
    input  logic [4:0] rs2_addr,
    input  logic [4:0] rd_addr,

    input  logic [31:0] rd_data,

    output logic [31:0] rs1_data,
    output logic [31:0] rs2_data
    );

    logic [31:0] register [0:31];

    always_ff @(posedge clk or negedge reset)
    begin
        if(reset)
        begin
            for(int i=0; i<32; i++)
            register[i] <= 32'd0;
        end
        else if(wr_en && (rd_addr != 0))
        begin
            register[rd_addr] <= rd_data;
        end
    end

    always_comb
    begin
        rs1_data = register[rs1_addr];
        rs2_data = register[rs2_addr];
    end

endmodule
