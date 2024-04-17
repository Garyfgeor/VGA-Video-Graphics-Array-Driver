`timescale 1ns/1ps
`define period 10
module vgacontroller_tb();
reg clk, reset;
wire hsync, vsync;
wire red, green, blue;

vgacontroller vgacontroller_inst(.reset(reset), .clk(clk), .VGA_RED(red), .VGA_GREEN(green), .VGA_BLUE(blue), .VGA_HSYNC(hsync), .VGA_VSYNC(vsync));

initial 
begin
    clk = 1'b0;
    reset = 1'b0;
    #10reset = 1'b1;
    #120reset = 1'b0;
end

always
begin
    #(`period/2)clk = ~clk;
end 

endmodule