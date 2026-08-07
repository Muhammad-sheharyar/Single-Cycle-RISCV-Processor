`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module program_counter
    ( 
    input  logic [31:0] pc_in, 
    input  logic clk, reset, 
    output logic [31:0] pc_out 
    ); 
    
    always @(posedge clk or negedge reset)
        if(reset)              //if reset==1; active (active-high)
            pc_out  <=  32'b0;
        else
            pc_out  <=  pc_in;    
endmodule

