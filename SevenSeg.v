module SevenSeg(clk, reset, num, seg, an);
input clk, reset;
input [15:0] num;
output reg [6:0] seg;
output reg [3:0] an;
reg [3:0] thousands, hundreds, tens, ones;
reg [3:0] digit;
reg [1:0] sel;
reg [16:0] refresh_counter;
always @(*)
begin
    ones      = num % 10;
    tens      = (num / 10) % 10;
    hundreds  = (num / 100) % 10;
    thousands = (num / 1000) % 10;
end
always @(posedge clk or posedge reset)
begin
    if(reset)
        refresh_counter <= 0;
    else
        refresh_counter <= refresh_counter + 1;
end
always @(*)
begin
    sel = refresh_counter[16:15];
end

always @(*)
begin
    case(sel)
        2'b00: begin digit = ones;      an = 4'b1110; end
        2'b01: begin digit = tens;      an = 4'b1101; end
        2'b10: begin digit = hundreds;  an = 4'b1011; end
        2'b11: begin digit = thousands; an = 4'b0111; end
    endcase
end
always @(*)
begin
    case(digit)
        4'd0: seg = 7'b1000000;
        4'd1: seg = 7'b1111001;
        4'd2: seg = 7'b0100100;
        4'd3: seg = 7'b0110000;
        4'd4: seg = 7'b0011001;
        4'd5: seg = 7'b0010010;
        4'd6: seg = 7'b0000010;
        4'd7: seg = 7'b1111000;
        4'd8: seg = 7'b0000000;
        4'd9: seg = 7'b0010000;
        default: seg = 7'b1111111;
    endcase
end
endmodule