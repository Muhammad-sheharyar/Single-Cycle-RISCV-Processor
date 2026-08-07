`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module TOP
    ( 
     input logic   clk, reset
    );
    
    ////////////////    WIRES   ///////////////////
    logic   [31:0]  pc      ;
    logic   [31:0]  inst    ;  
    logic   [31:0]  pc_mux_out, pc4_adder, pc_shift_adder, alu_data_mux, rs1_data, rs2_data,
                    immediate, alu, ReadData, Imm_mux   ;
    logic           Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, zero, And_out;
    logic   [1:0]   ALuop;
    logic   [3:0]   alu_ctrl;
    
    
    
        
    ////////////////    FETCH PART    ///////////////////
    program_counter           Program_C(
                                        .clk(clk),
                                        .reset(reset),
                                        .pc_in(pc_mux_out),
                                        .pc_out(pc));
                        
    instruction_memory    Instruction_M(                    
                                        .pc_out(pc),
                                        .inst(inst)  );
    
    register_file            Register_F(
                                        .clk(clk),
                                        .reset(reset),
                                        .wr_en(RegWrite),
                                        .rs1_addr(inst[19:15]),
                                        .rs2_addr(inst[24:20]),
                                        .rd_addr(inst[11:7]),
                                        .rd_data(alu_data_mux),
                                        .rs1_data(rs1_data),
                                        .rs2_data(rs2_data) );
    
    immediate_gen_32bit     Immediate_G(
                                         .inst(inst[31:0]),
                                         .immediate(immediate) );
    control_unit              Control_U(
                                         .opcode(inst[6:0]),
                                         .Branch(Branch),
                                         .MemRead(MemRead),
                                         .MemtoReg(MemtoReg),
                                         .MemWrite(MemWrite),
                                         .ALUSrc(ALUSrc),
                                         .RegWrite(RegWrite),
                                         .ALuop(ALuop)   );
   
    alu_control                   ALU_C(
                                         .ALuop(ALuop),
                                         .inst(inst[31:0]),
                                         .alu_ctrl(alu_ctrl) );
   
    alu                             ALU(             
                                         .a(rs1_data),
                                         .b(Imm_mux),
                                         .Sel(alu_ctrl),
                                         .out(alu),
                                         .zero(zero) );
                                        
   data_memory                   Data_M( 
                                         .clk(clk),
                                         .reset(reset),
                                         .Address(alu),
                                         .WriteData(rs2_data),
                                         .MemWrite(MemWrite),
                                         .MemRead(MemRead),
                                         .ReadData(ReadData) );
                                         
   mux_32bit                     PC_Mux(
                                         .Sel(And_out),
                                         .A(pc4_adder),
                                         .B(pc_shift_adder),
                                         .mux_out(pc_mux_out) );
   
   and                           and_G(And_out, Branch, zero); 
                                         
   mux_32bit              Immediate_Mux(
                                         .Sel(ALUSrc),
                                         .A(rs2_data),
                                         .B(immediate),
                                         .mux_out(Imm_mux) );
                                         
   mux_32bit               ALU_Data_Mux(
                                         .Sel(MemtoReg),
                                         .A(alu),
                                         .B(ReadData),
                                         .mux_out(alu_data_mux) );    
                                         
   adder_32bit                  PC4_Add(
                                         .A(pc),
                                         .B(4),
                                         .SUM(pc4_adder) ); 
                                         
   adder_32bit                Shift_Add(
                                         .A(pc),
                                         .B(immediate),
                                         .SUM(pc_shift_adder)); 
                                         
endmodule          

                                                                                                    