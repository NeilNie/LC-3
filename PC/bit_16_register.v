//
// One single register
// Neil Nie
// Jan 30th, 2019
// (c) All Rights Reserved 
// (Using negedge d flip flop)


module bit_16_register(D, Q, en, reset, clk);

input en, reset, clk;
input [15:0] D;
output [15:0] Q;

d_negedge_flip_flop ff_0(.clk(clk), .D(D[0]), .sel(en), .Q(Q[0]), .clr(reset));
d_negedge_flip_flop ff_1(.clk(clk), .D(D[1]), .sel(en), .Q(Q[1]), .clr(reset));
d_negedge_flip_flop ff_2(.clk(clk), .D(D[2]), .sel(en), .Q(Q[2]), .clr(reset));
d_negedge_flip_flop ff_3(.clk(clk), .D(D[3]), .sel(en), .Q(Q[3]), .clr(reset));
d_negedge_flip_flop ff_4(.clk(clk), .D(D[4]), .sel(en), .Q(Q[4]), .clr(reset));
d_negedge_flip_flop ff_5(.clk(clk), .D(D[5]), .sel(en), .Q(Q[5]), .clr(reset));
d_negedge_flip_flop ff_6(.clk(clk), .D(D[6]), .sel(en), .Q(Q[6]), .clr(reset));
d_negedge_flip_flop ff_7(.clk(clk), .D(D[7]), .sel(en), .Q(Q[7]), .clr(reset));
d_negedge_flip_flop ff_8(.clk(clk), .D(D[8]), .sel(en), .Q(Q[8]), .clr(reset));
d_negedge_flip_flop ff_9(.clk(clk), .D(D[9]), .sel(en), .Q(Q[9]), .clr(reset));
d_negedge_flip_flop ff_10(.clk(clk), .D(D[10]), .sel(en), .Q(Q[10]), .clr(reset));
d_negedge_flip_flop ff_11(.clk(clk), .D(D[11]), .sel(en), .Q(Q[11]), .clr(reset));
d_negedge_flip_flop ff_12(.clk(clk), .D(D[12]), .sel(en), .Q(Q[12]), .clr(reset));
d_negedge_flip_flop ff_13(.clk(clk), .D(D[13]), .sel(en), .Q(Q[13]), .clr(reset));
d_negedge_flip_flop ff_14(.clk(clk), .D(D[14]), .sel(en), .Q(Q[14]), .clr(reset));
d_negedge_flip_flop ff_15(.clk(clk), .D(D[15]), .sel(en), .Q(Q[15]), .clr(reset));

endmodule
