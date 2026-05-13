module tb_top;
reg clk;
reg reset;
reg [7:0] sw;
reg khatka;
wire [6:0] seg;
wire [3:0] an;
Top uut(.clk(clk),.reset(reset),.sw(sw),.an(an),.seg(seg),.khatka(khatka));
always #5 clk = ~clk;
initial begin
    clk = 0;
    reset = 1;
    khatka = 1;     
    sw = 8'd5;      
    #20;
    reset = 0;
    #500;
    khatka = 0;     
    #10;
    reset = 1;
    #20;
    reset = 0;
    #500;
    $finish;
end
endmodule