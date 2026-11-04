module mem_addr_gen_background(
   input clk,
   input rst,
   input [9:0] h_cnt,
   input [9:0] v_cnt,
   input game_over,
   output [16:0] pixel_addr
   );
    
   reg [8:0] position;
  
   assign pixel_addr = ((((h_cnt>>1)+position*2)%320)+320*(v_cnt>>1))% 76800;  //640*480 --> 320*240 
   always @ (posedge clk or posedge rst) begin
       if(rst)
          position <= 0;
       else if(game_over) begin
           position <= position + 0;
       end
       else if(position < 319)
           position <= position + 1;
       else
           position <= 0;
   end
    
endmodule
