//
// D flip flop
// Neil Nie
// Jan 30th, 2019
// (c) All Rights Reserved

module d_flip_flop(clk, D, sel, Q, clr);

input D, clk, sel, clr;
output Q;

reg Q;

wire in;
assign in = (D & ~sel) + (Q & sel);

always @(posedge clk)
	if (clr == 1'b1) begin
		Q <= 1'b0;
	end else begin
		Q <= in;
	end
 
endmodule
