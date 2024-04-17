module vertical_vga(clk, reset, VPIXEL, VSYNC);
input clk, reset;
output reg [6:0] VPIXEL = 7'b000_0000;//metraei tis GRAMMES tis BRAM
output reg VSYNC;

reg [1:0] CurrentState = 2'b00;
reg [1:0] NextState = 2'b00;
reg [23:0] cycles_counter = 24'b0000_0000_0000_0000_0000_0000;
reg [15:0] five_times_counter = 16'b0000_0000_0000_0000;
reg rst_counter = 1'b0;
reg rst_5times_counter = 1'b0;
reg next_line = 1'b0;
reg rst_vpixel = 1'b0;
reg [15:0] five_counter = 16'b0000_0000_0000_0000;

parameter active_video_time_state = 2'b00;
parameter front_porch_state = 2'b01;
parameter vsync_pulse_state = 2'b10;
parameter back_porch_state = 2'b11;
reg [11:0] pixel = 12'b0000_0000_0000;
reg rst_pixel = 1'b0;

//counter pou metraei kyklous rologiou
always@(posedge clk or posedge reset)
begin
    if(reset == 1'b1)
    begin
        cycles_counter <= 24'b0000_0000_0000_0000_0000_0000;
    end
    else
    begin
        if(rst_counter == 1'b1)
        begin
            cycles_counter <= 24'b0000_0000_0000_0000_0000_0000;
        end
        else
        begin
            cycles_counter <= cycles_counter + 24'b0000_0000_0000_0000_0000_0001;
        end
    end
end

//sequential fsm - allagi katastasis sthn FSM - ylopoiisi fsm gia anaparastasi twn pixel orizontiws
always@(posedge clk or posedge reset)
begin
    if(reset == 1'b1)
    begin
        CurrentState <= active_video_time_state;
    end
    else
    begin
        CurrentState <= NextState;
    end
end

//counter pou metraei oti to pixel stalthike 5 fores
//max=5*3200=16000
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

//ylopoiisi vpixel counter
always@(posedge clk or posedge reset)
begin
    if(reset == 1'b1)
    begin
        VPIXEL = 7'b000_0000;
    end
    else
    begin
        if(rst_vpixel == 1'b1)
        begin
            VPIXEL = 7'b000_0000;
        end
        else if(next_line == 1'b1)
        begin
            VPIXEL = VPIXEL + 7'b000_0001;
        end
    end
end

//combinational fsm
always@(CurrentState or cycles_counter or five_times_counter or VPIXEL)
begin
    case(CurrentState)
        active_video_time_state://katastasi energis othonis
        begin
            rst_vpixel = 1'b0;
            VSYNC = 1'b1;
            rst_counter = 1'b0;
            if(cycles_counter < 24'b0001_0111_0110_1111_1111_1111 && five_times_counter == 16'b0011_1110_0111_1111 && VPIXEL<7'b101_1111)// cycles_counter=1.536.000-1=1.535.999 five_times_counter=16000-1=15999 VPIXEL=96-1=95
            begin
                next_line = 1'b1;
                rst_5times_counter = 1'b1;
                NextState = active_video_time_state;
            end
            else if(cycles_counter == 24'b0001_0111_0110_1111_1111_1111 && VPIXEL == 7'b101_1111)
            begin
                NextState = front_porch_state; 
                rst_5times_counter = 1'b1;
                rst_counter = 1'b1;
                next_line = 1'b1;
            end
            else 
            begin
                next_line = 1'b0;
                rst_5times_counter = 1'b0;
                NextState = active_video_time_state;
            end
        end

        front_porch_state://katastasi anenergis othonis
        begin
            rst_vpixel = 1'b0;
            next_line = 1'b0;
            rst_counter = 1'b0;
            rst_5times_counter = 1'b1;
            VSYNC = 1'b1;
            if(cycles_counter == 24'b0000_0000_0111_1100_1111_1111)
            begin
                NextState = vsync_pulse_state;
                rst_counter = 1'b1;
            end
            else
            begin   
                NextState = front_porch_state;
            end
        end

        vsync_pulse_state://katastasi anenergis othonis
        begin
            rst_vpixel = 1'b0;
            next_line = 1'b0;
            rst_counter = 1'b0;
            rst_5times_counter = 1'b1;
            VSYNC = 1'b0;
            if(cycles_counter == 24'b0000_0000_0001_1000_1111_1111)//6400-1=6399
            begin
                NextState = back_porch_state;
                rst_counter = 1'b1;
            end
            else
            begin   
                NextState = vsync_pulse_state;
            end
            
        end

        back_porch_state://katastasi anenergis othonis
        begin
            rst_vpixel = 1'b0;
            next_line = 1'b0;
            rst_5times_counter = 1'b1;
            rst_counter = 1'b0;
            VSYNC = 1'b1;
            if(cycles_counter == 24'b0000_0001_0110_1010_0111_1111)//92800-1=92799
            begin
                NextState = active_video_time_state;
                rst_counter = 1'b1;
                next_line = 1'b1;
                rst_vpixel = 1'b1;
            end
            else
            begin   
                NextState = back_porch_state;
            end
        end
    endcase

end


endmodule
