module pipe3_pos(clk, rst_n, game_start, game_over, rand_num, pipe3_up, pipe3_down, pipe3_left, pipe3_right);
input clk;
input rst_n;
input game_start;
input game_over;
input [7:0] rand_num;
output reg [10:0] pipe3_up, pipe3_down, pipe3_left, pipe3_right;

always @(posedge clk) begin
    if(rst_n) begin
        pipe3_up <= 0;
        pipe3_down <= 80; 
    end
    else if(game_over) begin
        pipe3_up <= pipe3_up + 0;
        pipe3_down <= pipe3_down + 0;
    end
    else if(game_start) begin
        if(pipe3_left >= 600) begin
            pipe3_up <= 0;
            pipe3_down <= rand_num;
        end
        else begin
            pipe3_up <= pipe3_up + 0;
            pipe3_down <= pipe3_down + 0;
        end
    end
end

always @(posedge clk) begin
    if(rst_n) begin
        pipe3_left <= 1080;
        pipe3_right <= 1130;
    end
    else if(game_over) begin
        pipe3_left <= pipe3_left + 0;
        pipe3_right <= pipe3_right + 0;
    end
    else if(game_start) begin
        if(pipe3_left == 0) begin
            pipe3_left <= pipe3_left - 0;
        end
        else begin
            if(pipe3_left < 4) begin
                pipe3_left <= 0;
            end
            else begin
                pipe3_left <= pipe3_left - 4;
            end
        end
        if(pipe3_right <= 10) begin
            pipe3_left <= 640;
            pipe3_right <= 690;
        end
        else begin
            if(pipe3_right < 4) begin
                pipe3_right <= 0;
            end
            else begin
                pipe3_right <= pipe3_right - 4;
            end
        end
    end
    else begin
        pipe3_left <= 1080;
        pipe3_right <= 1130;
    end
end
endmodule
