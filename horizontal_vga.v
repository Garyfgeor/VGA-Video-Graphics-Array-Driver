module horizontal_vga(clk, reset, HPIXEL, HSYNC, rgb);
input clk, reset;
output reg [6:0] HPIXEL = 7'b000_0000;//metraei tis stiles tis BRAM mexri 256-1 =255
output reg HSYNC;
output reg rgb;

reg [1:0] CurrentState = 2'b00;
reg [1:0] NextState = 2'b00;
reg [11:0] cycles_counter = 12'b0000_0000_0000;
reg rst_counter = 1'b0;
reg rst_5times_counter = 1'b0;
reg next_pixel = 1'b0;
reg rst_HPIXEL = 1'b1;
reg [7:0] five_times_counter = 8'b00000000;

parameter display_time_state = 2'b00;
parameter front_porch_state = 2'b01;
parameter hsync_pulse_state = 2'b10;
parameter back_porch_state = 2'b11;

//counter pou metraei kyklous rologiou
always@(posedge clk or posedge reset)
begin
    if(reset == 1'b1)
    begin
        cycles_counter <= 12'b0000_0000_0000;   
    end
    else
    begin
        if(rst_counter == 1'b1)
        begin
            cycles_counter <= 12'b0000_0000_0000;
        end
        else
        begin
            cycles_counter <= cycles_counter + 12'b0000_0000_0001;
        end 
    end
end

//counter pou metraei oti to pixel stalthike 5 fores
//max=5*4=20 
always@(posedge clk or posedge reset)
begin
    if(reset == 1'b1)
    begin
        five_times_counter <= 8'b0000_0000;
    end
    else
    begin
        if(rst_5times_counter == 1'b1)
        begin
            five_times_counter <= 8'b0000_0000; 
        end
        else
        begin
            five_times_counter <= five_times_counter + 8'b0000_0001;   
        end
    end 
end

//ylopoiisi hpixel counter
always@(posedge clk or posedge reset)
begin
    if(reset == 1'b1)
    begin
        HPIXEL = 7'b000_0000;
    end
    else
    begin
        if(rst_HPIXEL == 1'b1)
        begin
            HPIXEL = 7'b000_0000;
        end
        else if(next_pixel == 1'b1)
        begin
            HPIXEL = HPIXEL + 7'b000_0001;
        end
    end
end

//sequential fsm - allagi katastasis sthn FSM - ylopoiisi fsm gia anaparastasi twn pixel orizontiws
always@(posedge clk or posedge reset)
begin
    if(reset == 1'b1)
    begin
        CurrentState <= display_time_state;
        
    end
    else
    begin
        CurrentState <= NextState;
    end
end

//combinational fsm
always@(CurrentState or cycles_counter or five_times_counter or HPIXEL)
begin
    case(CurrentState)
      display_time_state://katastasi energis othonis
       begin
            rgb = 1'b1;
            rst_HPIXEL = 1'b0;
            HSYNC = 1'b1;
            rst_counter = 1'b0;
            if(cycles_counter < 12'b1001_1111_1111 && five_times_counter == 8'b0001_0011 && HPIXEL<7'b111_1111)//five_times = 19, HPIXEL == 127
            begin
                next_pixel = 1'b1;
                rst_5times_counter = 1'b1;
                NextState = display_time_state;
            end
        
            else if(cycles_counter == 12'b1001_1111_1111 && five_times_counter == 8'b0001_0011 && HPIXEL == 7'b111_1111)//HPIXEL == 127
            begin
                NextState = front_porch_state;
                rst_5times_counter = 1'b1;
                rst_counter = 1'b1;
                next_pixel = 1'b0;
                rgb = 1'b0;
            end
            else
            begin
                next_pixel = 1'b0;
                rst_5times_counter = 1'b0;
                NextState = display_time_state;
            end
        end
        
        front_porch_state://katastasi anenergis othonis
        begin
            rgb = 1'b0;
            rst_HPIXEL = 1'b0;
            next_pixel = 1'b0;
            rst_counter = 1'b0;
            rst_5times_counter = 1'b1;
            HSYNC = 1'b1;
            if(cycles_counter == 12'b0000_0011_1111)//64-1=63
            begin
                NextState = hsync_pulse_state;
                rst_counter = 1'b1;
            end
            else
            begin
                NextState = front_porch_state;
            end
        end
        
        hsync_pulse_state://katastasi anenergis othonis
        begin
            rgb = 1'b0;
            rst_HPIXEL = 1'b0;
            next_pixel = 1'b0;
            rst_counter = 1'b0;
            rst_5times_counter = 1'b1;
            HSYNC = 1'b0;
            if(cycles_counter == 12'b0001_0111_1111)//384-1=383
            begin
                NextState = back_porch_state;
                rst_counter = 1'b1;
            end
            else
            begin
                NextState = hsync_pulse_state;
            end
        end

        back_porch_state://katastasi anenergis othonis
        begin
            rgb = 1'b0;
            next_pixel = 1'b0;
            rst_5times_counter = 1'b1;
            rst_counter = 1'b0;
            HSYNC = 1'b1;
            rst_HPIXEL = 1'b0;
            if(cycles_counter == 12'b0000_1011_1111)//192-1=191
            begin
                NextState = display_time_state;
                rst_counter = 1'b1;
                next_pixel = 1'b1;
                rst_HPIXEL = 1'b1;
            end
            else
            begin
                NextState = back_porch_state;
            end
        end
    endcase
end
endmodule
 