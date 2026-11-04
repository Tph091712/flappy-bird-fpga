module randnum(clk, rst, rand_num);
input clk, rst;
output [7:0] rand_num;
wire feedback;
reg [7:0] out;
assign feedback = (out[7]^out[3])^(out[1]^out[2]);
assign rand_num = out % 200;
always @(posedge clk) begin
    if(rst) begin
        out <= 8'b10111101;
        //out <= 8'b00000000;
    end
    else begin
        out = {out[6:0], feedback};
    end
end
endmodule
