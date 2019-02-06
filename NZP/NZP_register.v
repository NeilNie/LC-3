//
// NZP Register

module NZP_register(D, Q, en, reset, clk);

input en, reset, clk;
input [2:0] D;
output [2:0] Q;

d_negedge_flip_flop ff_0(.clk(clk), .D(D[0]), .sel(en), .Q(Q[0]), .clr(reset));
d_negedge_flip_flop ff_1(.clk(clk), .D(D[1]), .sel(en), .Q(Q[1]), .clr(reset));
d_negedge_flip_flop ff_2(.clk(clk), .D(D[2]), .sel(en), .Q(Q[2]), .clr(reset));

endmodule