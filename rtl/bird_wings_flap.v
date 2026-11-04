
module bird_wings_flap(
    input clk,
    input rst,
    input game_over,
    input [11:0] pixel_bird_up,
    input [11:0] pixel_bird_down,
    input [11:0] pixel_bird_died,
    output reg [11:0] pixel_bird
);
reg [31:0] t;
always @(posedge clk) begin
    if(rst) begin
        t <= 0;
    end
    else begin
        t <= t + 1;
    end
end
always @(posedge clk) begin
    if(rst) begin
        pixel_bird <= pixel_bird_up;
    end
    else begin
        if(game_over) begin
            pixel_bird <= pixel_bird_died;
        end
        else begin
            if(t % 8000000 < 4000000) begin
                pixel_bird <= pixel_bird_up;
            end
            else begin
                pixel_bird <= pixel_bird_down;
            end
        end
    end
end
endmodule
