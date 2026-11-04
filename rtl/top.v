
module top(
   input clk,
   input rst,
   input up,
   output [3:0] vgaRed,
   output [3:0] vgaGreen,
   output [3:0] vgaBlue,
   output hsync,
   output vsync
    );

    wire [11:0] data;
    wire clk_25MHz;
    wire clk_22;
    wire clk_15;
    wire [16:0] pixel_addr_background;
    wire [9:0] pixel_addr_bird;
    wire [16:0] pixel_addr_game_over;
    wire [10:0] pixel_addr_num, pixel_addr_one, pixel_addr_two, pixel_addr_three;
    wire [10:0] pixel_addr_four, pixel_addr_five, pixel_addr_six;
    wire [10:0] pixel_addr_seven, pixel_addr_eight, pixel_addr_nine;
    wire [11:0] pixel_background;
    wire [11:0] pixel_bird;
    wire [11:0] pixel_bird_up, pixel_bird_down, pixel_bird_died;
    wire [11:0] pixel_game_over;
    wire [11:0] pixel_zero, pixel_one, pixel_two, pixel_three, pixel_four;
    wire [11:0] pixel_five, pixel_six, pixel_seven, pixel_eight, pixel_nine;
    wire [11:0] pixel;
    wire valid;
    wire [9:0] h_cnt; //640
    wire [9:0] v_cnt;  //480
    wire up_db, up_op;
    wire [9:0] bird_up, bird_down;
    wire [9:0] pipe_up, pipe_down, pipe_left, pipe_right;
    wire [9:0] pipe2_up, pipe2_down, pipe2_left, pipe2_right;
    wire [10:0] pipe3_up, pipe3_down, pipe3_left, pipe3_right;
    reg game_start, game_over;
    wire [7:0] rand_num;
    wire [7:0] score;
    reg [9:0] Time;
    assign {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel:12'h0;
    
    always @(posedge clk) begin // deal with game_start
        if(rst) begin
            game_start <= 0;
        end
        else if(up_op) begin
            game_start <= 1;
        end
        else begin
            game_start <= game_start + 0;
        end
    end

    
    always @(posedge clk) begin // deal with game_over
        if(rst) begin
            game_over <= 0;
        end
        else if(bird_down >= 440) begin
            game_over <= 1;
        end
        else if(pipe_left <= 300 && pipe_left >= 218) begin
            if(bird_up <= pipe_down || bird_down >= pipe_down + 160) begin
                game_over <= 1;
            end
            else begin
                game_over <= game_over + 0;
            end
        end
        else if(pipe2_left <= 300 && pipe2_left >= 218) begin
            if(bird_up <= pipe2_down || bird_down >= pipe2_down + 160) begin
                game_over <= 1;
            end
            else begin
                game_over <= game_over + 0;
            end
        end
        else if(pipe3_left <= 300 && pipe3_left >= 218) begin
            if(bird_up <= pipe3_down || bird_down >= pipe3_down + 160) begin
                game_over <= 1;
            end
            else begin
                game_over <= game_over + 0;
            end
        end
        else begin
            game_over <= game_over + 0;
        end
    end
    
    debounce DB0(.s(up), .s_db(up_db), .clk(clk));
    onepulse OP0(.s(up_db), .s_op(up_op), .clk(clk_22));
    
     clock_divisor clk_wiz_0_inst(
      .clk(clk),
      .clk1(clk_25MHz),
      .clk22(clk_22),
      .clk15(clk_15)
    );
    
    randnum r1(
     .clk(clk_15),
     .rst(rst),
     .rand_num(rand_num)
    );

    mem_addr_gen_background mem_addr_gen_inst(
    .clk(clk_22),
    .rst(rst),
    .h_cnt(h_cnt),
    .v_cnt(v_cnt),
    .game_over(game_over),
    .pixel_addr(pixel_addr_background)
    );
     
    mem_addr_gen_bird mem_addr_gen_inst_1(
    .clk(clk_22),
    .rst(rst),
    .h_cnt(h_cnt-297), 
    .v_cnt(v_cnt-bird_up+1),
    .pixel_addr(pixel_addr_bird)
    );
   
    
    mem_addr_gen_game_over mem_addr_gen_game_over(
    .clk(clk_22),
    .rst(rst),
    .h_cnt(h_cnt-118),
    .v_cnt(v_cnt-158),
    .pixel_addr(pixel_addr_game_over)
    );
    
    
    mem_addr_gen_zero mem_addr_gen_zero(
    .clk(clk_22),
    .rst(rst),
    .h_cnt(h_cnt-58),
    .v_cnt(v_cnt),
    .pixel_addr(pixel_addr_num)
    );
    
    blk_mem_gen_0 blk_mem_gen_0_inst(
      .clka(clk_25MHz),
      .wea(0),
      .addra(pixel_addr_background),
      .dina(data[11:0]),
      .douta(pixel_background)
    ); 
    
    blk_mem_gen_1 bird_wing_up(
      .clka(clk_25MHz),
      .wea(0),
      .addra(pixel_addr_bird),
      .dina(data[11:0]),
      .douta(pixel_bird_up)
    ); 
    
    blk_mem_gen_13 bird_wing_down(
      .clka(clk_25MHz),
      .wea(0),
      .addra(pixel_addr_bird),
      .dina(data[11:0]),
      .douta(pixel_bird_down)
    ); 
    
    blk_mem_gen_14 bird_died(
      .clka(clk_25MHz),
      .wea(0),
      .addra(pixel_addr_bird),
      .dina(data[11:0]),
      .douta(pixel_bird_died)
    ); 
    
    bird_wings_flap bwf(
        .clk(clk_25MHz),
        .rst(rst),
        .game_over(game_over),
        .pixel_bird_up(pixel_bird_up),
        .pixel_bird_down(pixel_bird_down),
        .pixel_bird_died(pixel_bird_died),
        .pixel_bird(pixel_bird)
    );
    
    blk_mem_gen_2 blk_mem_gen_game_over(
      .clka(clk_25MHz),
      .wea(0),
      .addra(pixel_addr_game_over),
      .dina(data[11:0]),
      .douta(pixel_game_over)
    ); 
    
    
    blk_mem_gen_3 blk_mem_gen_zero(
        .clka(clk_25MHz),
        .wea(0),
        .addra(pixel_addr_num),
        .dina(data[11:0]),
        .douta(pixel_zero)
    );
    
    blk_mem_gen_4 blk_mem_gen_one(
      .clka(clk_25MHz),
      .wea(0),
      .addra(pixel_addr_num),
      .dina(data[11:0]),
      .douta(pixel_one)
    );
    
    blk_mem_gen_5 blk_mem_gen_two(
      .clka(clk_25MHz),
      .wea(0),
      .addra(pixel_addr_num),
      .dina(data[11:0]),
      .douta(pixel_two)
    );
    
    blk_mem_gen_6 blk_mem_gen_three(
      .clka(clk_25MHz),
      .wea(0),
      .addra(pixel_addr_num),
      .dina(data[11:0]),
      .douta(pixel_three)
    );
    
    blk_mem_gen_7 blk_mem_gen_four(
      .clka(clk_25MHz),
      .wea(0),
      .addra(pixel_addr_num),
      .dina(data[11:0]),
      .douta(pixel_four)
    );
    
    blk_mem_gen_8 blk_mem_gen_five(
      .clka(clk_25MHz),
      .wea(0),
      .addra(pixel_addr_num),
      .dina(data[11:0]),
      .douta(pixel_five)
    );
    
    blk_mem_gen_9 blk_mem_gen_six(
      .clka(clk_25MHz),
      .wea(0),
      .addra(pixel_addr_num),
      .dina(data[11:0]),
      .douta(pixel_six)
    );
    
    blk_mem_gen_10 blk_mem_gen_seven(
      .clka(clk_25MHz),
      .wea(0),
      .addra(pixel_addr_num),
      .dina(data[11:0]),
      .douta(pixel_seven)
    );
    
    blk_mem_gen_11 blk_mem_gen_eight(
      .clka(clk_25MHz),
      .wea(0),
      .addra(pixel_addr_num),
      .dina(data[11:0]),
      .douta(pixel_eight)
    );
    
    blk_mem_gen_12 blk_mem_gen_nine(
      .clka(clk_25MHz),
      .wea(0),
      .addra(pixel_addr_num),
      .dina(data[11:0]),
      .douta(pixel_nine)
    );
    
    bird_pos bp(
        .clk(clk_22),
        .rst_n(rst),
        .up_op(up_op),
        .game_start(game_start),
        .game_over(game_over),
        .bird_up(bird_up),
        .bird_down(bird_down)
    );
    
    pipe_pos pp(
        .clk(clk_22),
        .rst_n(rst),
        .game_start(game_start),
        .game_over(game_over),
        .rand_num(rand_num+40),
        .pipe_up(pipe_up),
        .pipe_down(pipe_down),
        .pipe_left(pipe_left),
        .pipe_right(pipe_right)
    );
    
    pipe2_pos pp2(
        .clk(clk_22),
        .rst_n(rst),
        .game_start(game_start),
        .game_over(game_over),
        .rand_num(rand_num+40),
        .pipe2_up(pipe2_up),
        .pipe2_down(pipe2_down),
        .pipe2_left(pipe2_left),
        .pipe2_right(pipe2_right)
    );
    
    pipe3_pos pp3(
        .clk(clk_22),
        .rst_n(rst),
        .game_start(game_start),
        .game_over(game_over),
        .rand_num(rand_num+40),
        .pipe3_up(pipe3_up),
        .pipe3_down(pipe3_down),
        .pipe3_left(pipe3_left),
        .pipe3_right(pipe3_right)
    );
    
    score s1(
        .clk(clk_22),
        .rst(rst),        
        .pipe_right(pipe_right),
        .pipe2_right(pipe2_right),
        .pipe3_right(pipe3_right),
        .game_start(game_start),
        .game_over(game_over),
        .score(score)
    );
    
    Pixel p(
        .clk(clk_25MHz),
        .h_cnt(h_cnt),
        .v_cnt(v_cnt),
        .pixel_0(pixel_background),
        .pixel_1(pixel_bird),
        .pixel_2(pixel_game_over), // gameover
        .pixel_zero(pixel_zero),
        .pixel_one(pixel_one),
        .pixel_two(pixel_two),
        .pixel_three(pixel_three),
        .pixel_four(pixel_four),
        .pixel_five(pixel_five),
        .pixel_six(pixel_six),
        .pixel_seven(pixel_seven),
        .pixel_eight(pixel_eight),
        .pixel_nine(pixel_nine),
        .bird_up(bird_up),
        .bird_down(bird_down),
        .pipe_up(pipe_up),
        .pipe_down(pipe_down),
        .pipe_left(pipe_left),
        .pipe_right(pipe_right),
        .pipe2_up(pipe2_up),
        .pipe2_down(pipe2_down),
        .pipe2_left(pipe2_left),
        .pipe2_right(pipe2_right),
        .pipe3_up(pipe3_up),
        .pipe3_down(pipe3_down),
        .pipe3_left(pipe3_left),
        .pipe3_right(pipe3_right),
        .game_over(game_over),
        .score(score),
        .pixel(pixel)
    );

    vga_controller   vga_inst(
      .pclk(clk_25MHz),
      .reset(rst),
      .hsync(hsync),
      .vsync(vsync),
      .valid(valid),
      .h_cnt(h_cnt),
      .v_cnt(v_cnt)
    );
      
endmodule


