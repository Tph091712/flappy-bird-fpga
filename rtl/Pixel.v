module Pixel(
    input clk,
    input [9:0] h_cnt,
    input [9:0] v_cnt,
    input [11:0] pixel_0, // background
    input [11:0] pixel_1, // bird
    input [11:0] pixel_2, // gameover
    input [11:0] pixel_zero,
    input [11:0] pixel_one,
    input [11:0] pixel_two,
    input [11:0] pixel_three,
    input [11:0] pixel_four,
    input [11:0] pixel_five,
    input [11:0] pixel_six,
    input [11:0] pixel_seven,
    input [11:0] pixel_eight,
    input [11:0] pixel_nine,
    input [9:0] bird_up, bird_down,
    input [9:0] pipe_up, pipe_down, pipe_left, pipe_right,
    input [9:0] pipe2_up, pipe2_down, pipe2_left, pipe2_right,
    input [10:0] pipe3_up, pipe3_down, pipe3_left, pipe3_right,
    input game_over,
    input [7:0] score,
    output reg [11:0] pixel
    );
    always @(posedge clk) begin
        if(game_over && h_cnt >= 130 && h_cnt <= 529 && v_cnt >= 190 && v_cnt <= 289) begin // gameover
            pixel <= pixel_2;
        end
        else if(h_cnt >= 61 && h_cnt <= 92 && v_cnt >= 0 && v_cnt <= 63) begin // score
            if(score >= 100 && score <= 199) pixel <= pixel_one;
            else if(score >= 200 && score <= 299) pixel <= pixel_two;
            else if(score >= 300 && score <= 399) pixel <= pixel_three;
            else if(score >= 400 && score <= 499) pixel <= pixel_four;
            else if(score >= 500 && score <= 599) pixel <= pixel_five;
            else if(score >= 600 && score <= 699) pixel <= pixel_six;
            else if(score >= 700 && score <= 799) pixel <= pixel_seven;
            else if(score >= 800 && score <= 899) pixel <= pixel_eight;
            else if(score >= 900 && score <= 999) pixel <= pixel_nine;
            else pixel <= 12'hFFF;
        end
        else if(h_cnt >= 93 && h_cnt <= 124 && v_cnt >= 0 && v_cnt <= 63) begin // score
            if(score %100 >= 0 && score %100 <= 9 && score != 0) pixel <= pixel_zero;
            else if(score % 100 >= 10 && score %100  <= 19) pixel <= pixel_one;
            else if(score %100 >= 20 && score %100 <= 29) pixel <= pixel_two;
            else if(score %100 >= 30 && score %100 <= 39) pixel <= pixel_three;
            else if(score %100 >= 40 && score %100 <= 49) pixel <= pixel_four;
            else if(score %100 >= 50 && score %100 <= 59) pixel <= pixel_five;
            else if(score %100 >= 60 && score %100 <= 69) pixel <= pixel_six;
            else if(score %100 >= 70 && score %100 <= 79) pixel <= pixel_seven;
            else if(score %100 >= 80 && score %100 <= 89) pixel <= pixel_eight;
            else if(score %100 >= 90 && score %100 <= 99) pixel <= pixel_nine;
            else pixel <= 12'hFFF;
        end
        else if(h_cnt >= 125 && h_cnt <= 156 && v_cnt >= 0 && v_cnt <= 63) begin // score
            if(score%10 == 1) pixel <= pixel_one;
            else if(score%10 == 2) pixel <= pixel_two;
            else if(score%10 == 3) pixel <= pixel_three;
            else if(score%10 == 4) pixel <= pixel_four;
            else if(score%10 == 5) pixel <= pixel_five;
            else if(score%10 == 6) pixel <= pixel_six;
            else if(score%10 == 7) pixel <= pixel_seven;
            else if(score%10 == 8) pixel <= pixel_eight;
            else if(score%10 == 9) pixel <= pixel_nine;
            else pixel <= pixel_zero;
        end
        /*
        else if(h_cnt >= 125 && h_cnt <= 156 && v_cnt >= 0 && v_cnt <= 63) begin // score
            if(score%10 == 1) pixel <= pixel_one;
            else if(score%10 == 2) pixel <= pixel_two;
            else if(score%10 == 3) pixel <= pixel_three;
            else if(score%10 == 4) pixel <= pixel_four;
            else if(score%10 == 5) pixel <= pixel_five;
            else if(score%10 == 6) pixel <= pixel_six;
            else if(score%10 == 7) pixel <= pixel_seven;
            else if(score%10 == 8) pixel <= pixel_eight;
            else if(score%10 == 9) pixel <= pixel_nine;
            else pixel <= pixel_zero;
        end
        */
        else if(h_cnt <= 60 || h_cnt >= 580) begin // black
            pixel <= 12'h000;
        end
        else if(h_cnt >= pipe_left && h_cnt <= pipe_right && ((v_cnt >= pipe_up && v_cnt <= pipe_down-20) || (v_cnt > pipe_down + 180 && v_cnt <= 440))) begin // first pipe up
            pixel <= 12'h0B0;
        end
        
        else if(h_cnt >= pipe_left - 5 && h_cnt <= pipe_right + 5 && ((v_cnt > pipe_down - 20 && v_cnt <= pipe_down)||(v_cnt >= pipe_down + 160 && v_cnt <= pipe_down + 180))) begin // first pipe up
            pixel <= 12'h090;
        end
        else if(h_cnt >= pipe2_left && h_cnt <= pipe2_right && ((v_cnt >= pipe2_up && v_cnt <= pipe2_down-20)||(v_cnt > pipe2_down + 180 && v_cnt <= 440))) begin // second pipe up
            pixel <= 12'h0B0;
        end
        
        else if(h_cnt >= pipe2_left - 5 && h_cnt <= pipe2_right + 5 && ((v_cnt > pipe2_down - 20 && v_cnt <= pipe2_down)||(v_cnt >= pipe2_down + 160 && v_cnt <= pipe2_down + 180))) begin // second pipe up
            pixel <= 12'h090;
        end
        else if(h_cnt >= pipe3_left && h_cnt <= pipe3_right && ((v_cnt >= pipe3_up && v_cnt <= pipe3_down-20)||(v_cnt > pipe3_down + 180 && v_cnt <= 440))) begin // third pipe up
            pixel <= 12'h0B0;
        end        
        else if(h_cnt >= pipe3_left - 5 && h_cnt <= pipe3_right + 5 && ((v_cnt > pipe3_down - 20 && v_cnt <= pipe3_down)||(v_cnt >= pipe3_down + 160 && v_cnt <= pipe3_down + 180))) begin // third pipe up
            pixel <= 12'h090;
        end
        else if(h_cnt >= 10'd268 && h_cnt <= 10'd299 && v_cnt >= bird_up && v_cnt <= bird_down) begin //300 should change to 272
            if(pixel_1 == 12'hA4A) begin
                pixel <= pixel_0;
            end
            else begin
               pixel <= pixel_1;
            end
        end
        else begin
            pixel <= pixel_0; // should be change to 0 
        end
    end
endmodule
