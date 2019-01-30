

module ped_flip_flop(clk, D, Q);

input D, clk;
output Q;

wire Qm, Qs;

gated_d_latch latch1(
	.clk(~clk), 
	.D(D), 
	.Q(Qm)
);

gated_d_latch latch2(
	.clk(clk), 
	.D(Qm), 
	.Q(Qs)
);

assign Q = Qs;

endmodule
