`timescale 1ns/1ps
`define period 10
module vertical_vga_tb();
reg clk, reset;
wire [6:0] vpixel;//metraei tis grammes tis BRAM
wire vsync;
wire VGA_RED, VGA_GREEN, VGA_BLUE;

vertical_vga vertical_vga_inst(.clk(clk), .reset(reset), .VPIXEL(vpixel), .VSYNC(vsync));
VRAM VRAM_inst(.clk(clk), .reset(reset), .pixel_address({vpixel, 0}), .VGA_RED(VGA_RED), .VGA_GREEN(VGA_GREEN), .VGA_BLUE(VGA_BLUE));

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