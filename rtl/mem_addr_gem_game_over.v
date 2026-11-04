module mem_addr_gen_game_over(
   input clk,
   input rst,
   input [9:0] h_cnt,
   input [9:0] v_cnt,
   output [16:0] pixel_addr
   );
   assign pixel_addr = (((h_cnt>>1)>>1)+100*((v_cnt>>1)>>1))% 4000;  //640*480 --> 320*240 
endmodule