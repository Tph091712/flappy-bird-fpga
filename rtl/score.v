module score(
input clk, rst,
input [9:0] pipe_right,
input [9:0] pipe2_right,
input [9:0] pipe3_right,
input game_start, game_over,
output reg [7:0] score
);
always @(posedge clk) begin
    if(rst) begin
        score <= 99;
    end
    else begin
        if(game_over || !game_start) begin
            score <= score + 0;
        end
        else begin
            if((pipe_right <= 268 && pipe_right > 264) || (pipe2_right <= 268 && pipe2_right > 264) || (pipe3_right <= 268 && pipe3_right > 264)) begin
                score <= score + 1;
            end
        end
    end
end
endmodule
