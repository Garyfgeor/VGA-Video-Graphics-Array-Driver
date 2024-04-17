`timescale 1ns/1ps
`define period 10
module horizontal_vga_tb();
reg clk, reset;
wire [6:0] hpixel;//metraei tis stiles tis BRAM
wire hsync;
wire rgb;
horizontal_vga horizontal_vga_inst(.clk(clk), .reset(reset), .HPIXEL(hpixel), .HSYNC(hsync), .rgb(rgb));
VRAM VRAM_inst(.clk(clk), .reset(reset), .pixel_address({0,hpixel}), .VGA_RED(VGA_RED), .VGA_GREEN(VGA_GREEN), .VGA_BLUE(VGA_BLUE));

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