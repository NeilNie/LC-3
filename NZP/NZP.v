//
// NZP
//

module NZP (
	Bus,
	clk,
	regWE,
	reset,
	N,
	Z,
	P
);

input [15:0] Bus;
input clk, regWE, reset;
output N, Z, P;

endmodule
