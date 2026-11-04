module pipe2_pos(clk, rst_n, game_start, game_over, rand_num, pipe2_up, pipe2_down, pipe2_left, pipe2_right);
input clk;
input rst_n;
input game_start;
input game_over;
input [7:0] rand_num;
output reg [9:0] pipe2_up, pipe2_down, pipe2_left, pipe2_right;

always @(posedge clk) begin
    if(rst_n) begin
        pipe2_up <= 0;
        pipe2_down <= 80; 
    end
    else if(game_over) begin
        pipe2_up <= pipe2_up + 0;
        pipe2_down <= pipe2_down + 0;
    end
    else if(game_start) begin
        if(pipe2_left >= 600) begin
            pipe2_up <= 0;
            pipe2_down <= rand_num;
        end
        else begin
            pipe2_up <= pipe2_up + 0;
            pipe2_down <= pipe2_down + 0;
        end
    end
end

always @(posedge clk) begin
    if(rst_n) begin
        pipe2_left <= 860;
        pipe2_right <= 910;
    end
    else if(game_over) begin
        pipe2_left <= pipe2_left + 0;
        pipe2_right <= pipe2_right + 0;
    end
    else if(game_start) begin
        if(pipe2_left == 0) begin
            pipe2_left <= pipe2_left - 0;
        end
        else begin
            if(pipe2_left < 4) begin
                pipe2_left <= 0;
            end
            else begin
                pipe2_left <= pipe2_left - 4;
            end
        end
        if(pipe2_right <= 10) begin
            pipe2_left <= 640;
            pipe2_right <= 690;
        end
        else begin
            if(pipe2_right < 4) begin
                pipe2_right <= 0;
            end
            else begin
                pipe2_right <= pipe2_right - 4;
            end
        end
    end
    else begin
        pipe2_left <= 860;
        pipe2_right <= 910;
    end
end
endmodule