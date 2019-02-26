// 
// 16_bit all purpose register 
// Neil Nie, (c) 2018
// 

module bit_16_reg(
	D,
	en,
	Q,
	reset,
	clk
);

input en, reset, clk;
input [15:0] D;
output reg [15:0] Q;

always @ (negedge clk) begin

	if (en == 1)
		Q <= D;
	else if (reset == 1)
		Q <= 16'h0000;
	else 
		Q <= Q;

end

endmodule
