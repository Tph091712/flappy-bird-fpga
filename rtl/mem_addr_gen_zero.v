module mem_addr_gen_zero(
   input clk,
   input rst,
   input [9:0] h_cnt,
   input [9:0] v_cnt,
   output [10:0] pixel_addr
   );
   assign pixel_addr = (h_cnt+32*v_cnt)% 2048;  //640*480 --> 320*240 
endmodule

