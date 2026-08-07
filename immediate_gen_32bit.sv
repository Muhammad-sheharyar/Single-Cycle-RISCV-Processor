`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/17/2026 10:56:25 PM
// Design Name: 
// Module Name: immediate_gen_32bit
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


module immediate_gen_32bit
    (
    input logic [31:0] inst,
    output logic [31:0] immediate
    );
    
    logic [6:0] opcode; 
    assign opcode = inst [6:0];
    
    always_comb 
    begin 
        case(opcode)
            7'd19   :   immediate   = {{20{inst[31]}}, inst[31:20]};              //Addi opcode I-type
            7'd3    :   immediate   = {{20{inst[31]}}, inst[31:20]};              //Lw opcode I-type
            7'd35   :   immediate   = {{20{inst[31]}}, inst[31:25], inst[11:7]}; //Sw opcode
            7'd99   :   immediate   = {{19{inst[31]}}, inst[31], inst[7], inst[30:25], inst[11:8], 1'b0};  //beq opcode
            default : immediate     = 32'b0;
        endcase
    end 
endmodule
