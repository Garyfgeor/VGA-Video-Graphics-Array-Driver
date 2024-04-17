module vgacontroller(reset, clk, VGA_RED, VGA_GREEN, VGA_BLUE, VGA_HSYNC, VGA_VSYNC);
input reset, clk;
output reg VGA_RED, VGA_GREEN, VGA_BLUE;
output VGA_HSYNC, VGA_VSYNC;
wire [6:0] hpixel;
wire [6:0] vpixel;
wire rgb;
wire red, green, blue;

horizontal_vga horizontal_vga_inst(.clk(clk), .reset(reset), .HPIXEL(hpixel), .HSYNC(VGA_HSYNC), .rgb(rgb));
vertical_vga vertical_vga_inst(.clk(clk), .reset(reset), .VPIXEL(vpixel), .VSYNC(VGA_VSYNC));
VRAM VRAM_inst(.clk(clk), .reset(reset), .pixel_address({vpixel, hpixel}), .VGA_RED(red), .VGA_GREEN(green), .VGA_BLUE(blue));

//always pou me vsi to rgb energopoiei h apenergopoiei tin othoni (bgazei mauro xrwma)
always@(posedge clk or posedge reset)
begin
    if(reset == 1'b1)
    begin
        VGA_RED <= 1'b0;
        VGA_BLUE <= 1'b0;
        VGA_GREEN <= 1'b0;
    end
    else
    begin
        if(rgb == 1'b1)
        begin
            VGA_RED <= red;
            VGA_BLUE <= blue;
            VGA_GREEN <= green;
        end
        else
        begin 
            VGA_RED <= 1'b0;
            VGA_BLUE <= 1'b0;
            VGA_GREEN <= 1'b0;
        end  
    end
end




endmodule
