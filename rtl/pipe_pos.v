module pipe_pos(clk, rst_n, game_start, game_over, rand_num, pipe_up, pipe_down, pipe_left, pipe_right);
input clk;
input rst_n;
input game_start;
input game_over;
input [7:0] rand_num;
output reg [9:0] pipe_up, pipe_down, pipe_left, pipe_right;

//wire [23:0] rand;
//assign rand = {$random} % 280;

/*integer seed;
reg [7:0] rand_num;
initial begin
    seed = 0;
end
always @(posedge clk) begin
    rand_num <= $random(seed);
end*/ 

always @(posedge clk) begin
    if(rst_n) begin
        pipe_up <= 0;
        pipe_down <= 80; 
    end
    else if(game_over) begin
        pipe_up <= pipe_up + 0;
        pipe_down <= pipe_down + 0;
    end
    else if(game_start) begin
        if(pipe_left >= 600) begin
            pipe_up <= 0;
            pipe_down <= rand_num;
        end
        else begin
            pipe_up <= pipe_up + 0;
            pipe_down <= pipe_down + 0;
        end
    end
end

always @(posedge clk) begin
    if(rst_n) begin
        pipe_left <= 640;
        pipe_right <= 690;
    end
    else if(game_over) begin
        pipe_left <= pipe_left + 0;
        pipe_right <= pipe_right + 0;
    end
    else if(game_start) begin
        if(pipe_left == 0) begin
            pipe_left <= pipe_left - 0;
        end
        else begin
            if(pipe_left < 4) begin
                pipe_left <= 0;
            end
            else begin
                pipe_left <= pipe_left - 4;
            end
        end
        if(pipe_right <= 10) begin
            pipe_left <= 640;
            pipe_right <= 690;
        end
        else begin
            if(pipe_right < 4) begin
                pipe_right <= 0;
            end
            else begin
                //pipe_left <= pipe_left - 4;
                pipe_right <= pipe_right - 4;
            end
        end
    end
    else begin
        pipe_left <= 640;
        pipe_right <= 690;
    end
end
endmodule
