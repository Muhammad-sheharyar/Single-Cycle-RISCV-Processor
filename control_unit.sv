`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/18/2026 03:30:24 PM
// Design Name: 
// Module Name: control_unit
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

module control_unit
    (
    input  logic [6:0] opcode,

    output logic Branch,
    output logic MemRead,
    output logic MemtoReg,
    output logic MemWrite,
    output logic ALUSrc,
    output logic RegWrite,
    output logic [1:0] ALuop
    );

always_comb begin

    Branch   = 0;
    MemRead  = 0;
    MemtoReg = 0;
    MemWrite = 0;
    ALUSrc   = 0;
    RegWrite = 0;
    ALuop    = 2'b00;

    case(opcode)

        7'd99 : begin // beq
            Branch = 1;
            ALuop  = 2'b01;
        end

        7'd3 : begin // lw
            ALUSrc   = 1;
            RegWrite = 1;
            MemtoReg = 1;
            MemRead  = 1;
            ALuop    = 2'b00;
        end

        7'd35 : begin // sw
            ALUSrc   = 1;
            MemWrite = 1;
            ALuop    = 2'b00;
        end

        7'd19 : begin // addi, slli
            RegWrite = 1;
            ALUSrc   = 1;
            ALuop    = 2'b10;
        end

        7'd51 : begin // add
            RegWrite = 1;
            ALuop    = 2'b10;
        end

    endcase

end

endmodule
