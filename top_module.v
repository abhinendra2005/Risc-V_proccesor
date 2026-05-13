module Top(clk, reset, sw, an, seg, khatka);
input clk, reset;
input [7:0] sw;
input khatka;
output [6:0] seg;
output [3:0] an;
wire [31:0] PC_top, instruction_top, Rd1_top, Rd2_top, ImmExt_top, mux1_top, Sum_out_top, NextPC_top, PCin_top, ALU_Result_top, Memdata_top, write_data_top;
wire RegWrite_top, ALUSrc_top, branch_top, zero_top, selline2_top, MemtoReg_top, Memwrite_top, Memread_top;
wire [1:0] ALUOp_top;
wire [3:0] control_top;
wire [31:0] x10_value, x21_value, x6_value;
// Program counter
PC_Register PC(.clk(clk), .reset(reset), .PC_in(PCin_top), .PC_out(PC_top));
// PC adder
PCplus4 PC_adder(.fromPC(PC_top), .nextPC(NextPC_top));
// Instruction memory
Instruction_Mem Ins_mem(.clk(clk), .read_address(PC_top), .instruction_out(instruction_top));
// Register file
Reg_File register_file(.clk(clk), .RegWrite(RegWrite_top), .Rs1(instruction_top[19:15]), .Rs2(instruction_top[24:20]), .Rd(instruction_top[11:7]), .Write_data(write_data_top), .read_data1(Rd1_top), .read_data2(Rd2_top), .sw(sw), .khatka(khatka) .x10_out(x10_value), .x21_out(x21_value), .x6_out(x6_value));
// Immediate Generator
ImmGen IG1(.Opcode(instruction_top[6:0]), .instruction(instruction_top), .ImmExt(ImmExt_top));
// Control unit
Control_Unit Control_Unit(.instruction(instruction_top[6:0]), .Branch(branch_top), .MemRead(Memread_top), .MemtoReg(MemtoReg_top), .ALUOp(ALUOp_top), .MemWrite(Memwrite_top), .ALUSrc(ALUSrc_top), .RegWrite(RegWrite_top));
// ALU control
ALU_Control ALU_Control(.ALUOp(ALUOp_top), .fun7(instruction_top[30]), .fun3(instruction_top[14:12]), .Control_out(control_top));
// ALU
ALU_unit ALU(.A(Rd1_top), .B(mux1_top), .Control_in(control_top), .ALU_Result(ALU_Result_top), .zero(zero_top));
// ALU mux
Mux mux1(.sel(ALUSrc_top), .A(Rd2_top), .B(ImmExt_top), .Mux_out(mux1_top));
// Adder
Adder A1(.in_1(PC_top), .in_2(ImmExt_top), .Sum_out(Sum_out_top));
// And gate
AND_logic And1(.branch(branch_top), .zero(zero_top), .and_out(selline2_top));
// MUX 2
Mux mux2(.sel(selline2_top), .A(NextPC_top), .B(Sum_out_top), .Mux_out(PCin_top));
// Data memory
Data_Memory DM1(.clk(clk), .reset(reset), .MemWrite(Memwrite_top), .MemRead(Memread_top), .read_address(ALU_Result_top), .Write_data(Rd2_top), .MemData_out(Memdata_top));
// MUX3
Mux mux3(.sel(MemtoReg_top), .A(ALU_Result_top), .B(Memdata_top), .Mux_out(write_data_top));
wire [15:0] display_value;
assign display_value = (x6_value) ? x10_value[15:0] : x21_value[15:0];
SevenSeg display(.clk(clk),.reset(reset),.num(display_value),.seg(seg),.an(an));
endmodule