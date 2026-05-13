module ALU_Control(ALUOp, fun7, fun3, Control_out);
input fun7;
input [2:0] fun3;
input [1:0] ALUOp;
output reg [3:0] Control_out;
always @(*)
begin
    casez({ALUOp, fun7, fun3})
        6'b00_?_???: Control_out <= 4'b0010; // LW,Sw
        6'b01_?_???: Control_out <= 4'b0110; // BEQ
        6'b10_0_000: Control_out <= 4'b0010; // Add, Addi
        6'b10_1_000: Control_out <= 4'b0110; // Sub
        6'b10_?_111: Control_out <= 4'b0000; // And
        6'b10_?_110: Control_out <= 4'b0001; // Or, Ori
        default:     Control_out <= 4'b0010; // Add
    endcase
end
endmodule