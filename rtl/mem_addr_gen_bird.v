module mem_addr_gen_bird(
   input clk,
   input rst,
   input [9:0] h_cnt,
   input [9:0] v_cnt,
   output [9:0] pixel_addr
   );
   assign pixel_addr = ((h_cnt)+32*(v_cnt))% 1024;   
endmodule
