//
// IR
//

module IR (
	clk,
	ldIR,
	reset,
	Bus,
	IR
);

input clk, ldIR, reset;
input [15:0] Bus;
output [15:0] IR;

bit_16_register register(.D(Bus), .Q(IR), .en(ldIR), .reset(reset), .clk(clk));

endmodule
