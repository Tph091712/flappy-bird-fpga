module bird_pos(clk, rst_n, up_op, game_start, game_over, bird_up, bird_down);
input clk;
input rst_n;
input up_op;
input game_start;
input game_over;
output reg [9:0] bird_up, bird_down;
reg [7:0] fallspeed;
reg [4:0] upspeed;
reg [3:0] float_up, float_down;

always @(posedge clk) begin
    if(rst_n) begin
        upspeed <= 0;
    end
    else if(up_op) begin
        upspeed <= 11;
    end
    else begin
        if(upspeed > 0) begin
            upspeed <= upspeed - 1;
        end
        else begin
            upspeed <= 0;
        end
    end
end
always @(posedge clk) begin
    if(rst_n) begin
        fallspeed <= 0;
    end
    else if(!game_start) begin
        fallspeed <= 0;
    end
    else if(up_op) begin
        fallspeed <= 0;
    end
    else begin
        fallspeed <= fallspeed + 1;
    end
end
always @(posedge clk) begin
    if(rst_n) begin
        bird_up <= 200;
        bird_down <= 231;
    end
    else if(game_over) begin
        bird_up <= bird_up + 0;
        bird_down <= bird_down + 0;
    end
    else if(game_start) begin
        if(upspeed > 0) begin                
            if(bird_up > upspeed) begin
                bird_up <= bird_up - upspeed;
                bird_down <= bird_down - upspeed;
            end
            else begin
                bird_up <= 0;
                bird_down <= 31;
            end
        end
        else if(bird_down + fallspeed/2 <= 440) begin
            bird_up <= bird_up + fallspeed/2;
            bird_down <= bird_down + fallspeed/2;
        end
        else if(bird_down + fallspeed > 440) begin
            bird_up <= 409;
            bird_down <= 440;
        end
        else begin
            bird_up <= bird_up + 0;
            bird_down <= bird_down + 0;
        end
    end
    else begin // before game start
        bird_up <= 200;
        bird_down <= 231;
    end
   // end
end
endmodule
