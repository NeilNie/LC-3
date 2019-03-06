//
// IR
//
// Copyright (c) 2018 by Neil Nie
// All Rights Resered. 
// MIT License
// Contact: contact@neilnie.com
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

bit_16_reg register(.D(Bus), .Q(IR), .en(ldIR), .reset(reset), .clk(clk));

endmodule
