module Reg_File(clk, RegWrite, Rs1, Rs2, Rd, Write_data, read_data1, read_data2, sw, khatka, x10_out, x21_out, x6_out);
input clk, RegWrite;
input [4:0] Rs1, Rs2, Rd;
input [31:0] Write_data;
input [7:0] sw;
input khatka;
output [31:0] x10_out, x21_out, x6_out;
output [31:0] read_data1, read_data2;
reg [31:0] Registers[31:0];
initial begin
    Registers[0]  = 0;
    Registers[1]  = 1;
    Registers[2]  = 2;
    Registers[3]  = 24;
    Registers[4]  = 4;
    Registers[5]  = 0;
    Registers[6]  = 0;
    Registers[7]  = 4;
    Registers[8]  = 2;
    Registers[9]  = 1;
    Registers[10] = 23;
    Registers[11] = 4;
    Registers[12] = 90;
    Registers[13] = 10;
    Registers[14] = 20;
    Registers[15] = 30;
    Registers[16] = 40;
    Registers[17] = 50;
    Registers[18] = 60;
    Registers[19] = 70;
    Registers[20] = 80;
    Registers[21] = 80;
    Registers[22] = 90;
    Registers[23] = 70;
    Registers[24] = 60;
    Registers[25] = 65;
    Registers[26] = 4;
    Registers[27] = 32;
    Registers[28] = 12;
    Registers[29] = 34;
    Registers[30] = 5;
    Registers[31] = 10;
end
always @(posedge clk)
begin
    if(RegWrite && Rd != 5'b0)
        Registers[Rd] <= Write_data;

        Registers[5] <= {24'b0, sw};
        Registers[6] <= {31'b0, khatka};
end
assign read_data1 = Registers[Rs1];
assign read_data2 = Registers[Rs2];
assign x10_out = Registers[10];
assign x21_out = Registers[21];
assign x6_out = Registers[6];
endmodule