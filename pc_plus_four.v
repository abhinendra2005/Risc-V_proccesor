module PCplus4(fromPC, nextPC);
input [31:0] fromPC;
output [31:0] nextPC;
assign nextPC = fromPC + 4;
endmodule