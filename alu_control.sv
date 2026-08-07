`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/18/2026 04:21:47 PM
// Design Name: 
// Module Name: alu_control
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


module alu_control
    (
    input logic [1:0] ALuop,
    input logic [31:0] inst,
    output logic [3:0] alu_ctrl
    );
    
    always_comb
        case(ALuop)
            2'b00 : alu_ctrl = 4'b0010; //in lw and sw ALuop 00 then alu_ctrl out = 0010
            2'b01 : alu_ctrl = 4'b0110; //in beq ALuop = 01 
            2'b10 : begin 
                        if(inst[30])
                            alu_ctrl = 4'b0110;
                        else begin
                                case(inst[14:12])
                                3'b000  :   alu_ctrl = 4'b0010;
                                3'b111  :   alu_ctrl = 4'b0000; //for AND operation
                                3'b110  :   alu_ctrl = 4'b0001; //for OR operation we dont need in our this pogram
                                3'b001  :   alu_ctrl = 4'b1111; // slli
                                default :   alu_ctrl = 4'b0010;
                                endcase
                              end
                     end
         endcase
endmodule
