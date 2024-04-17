`timescale 1ns/1ps
`define period 10
module VRAM(clk, reset, pixel_address, VGA_RED, VGA_GREEN, VGA_BLUE);
input clk, reset;
input [13:0] pixel_address;
output VGA_RED, VGA_GREEN, VGA_BLUE;

//instantiation of the three BRAMs one for its color
red_BRAM red_BRAM_inst(clk, reset, pixel_address, VGA_RED);
green_BRAM green_BRAM_inst(clk, reset, pixel_address, VGA_GREEN);
blue_BRAM blue_BRAM_inst(clk, reset, pixel_address, VGA_BLUE);
  
endmodule