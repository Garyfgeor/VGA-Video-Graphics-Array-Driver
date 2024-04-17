`timescale 1ns/1ps
`define period 10
module VRAM_testbench();
reg clk, reset, en;
reg [13:0] pixel_ADDRESS;
wire RED_clr, GREEN_clr, BLUE_clr;

VRAM VRAM_inst(.clk(clk), .reset(reset), .pixel_address(pixel_ADDRESS), .VGA_RED(RED_clr), .VGA_GREEN(GREEN_clr), .VGA_BLUE(BLUE_clr));
initial 
begin
    clk = 1'b0;
    reset = 1'b0;
    //reset = 1'b1;
    //#5reset = 1'b0;
    pixel_ADDRESS = 14'b0000_0000_0000_0000;
end

//metrhths gia thn afksisi tis diefthinsis
always@(posedge clk or posedge reset)
begin
    if(reset == 1'b1)
    begin
        pixel_ADDRESS = 14'b0000_0000_0000_0000;
    end
    else
    begin
        pixel_ADDRESS = pixel_ADDRESS + 14'b0000_0000_0000_0001;
    end
end

always@(pixel_ADDRESS)
begin
    if(pixel_ADDRESS == 14'b0011_0000_0000_0000)// =48*256 opou 48=2F+1 hex
    begin
        pixel_ADDRESS = 14'b0000_0000_0000_0000;
    end
end

initial
begin
$monitor("address=%d, red=%b green=%b blue=%b \n", pixel_ADDRESS, RED_clr, GREEN_clr, BLUE_clr);
end

//dimiourgia rologiou
always
begin
    #(`period/2)clk = ~clk;
end
endmodule