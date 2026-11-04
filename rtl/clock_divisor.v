module clock_divisor(clk1, clk, clk22, clk15);
input clk;
output clk1;
output clk22;
output clk15;
reg [21:0] num;
wire [21:0] next_num;

always @(posedge clk) begin
  num <= next_num;
end

assign next_num = num + 1'b1;
assign clk1 = num[1];
assign clk22 = num[21];
assign clk20 = num[19];
assign clk15 = num[5];
endmodule
