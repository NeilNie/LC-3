//
// EAB (the Effecretive Address Block)
// 
// Copyright (c) 2018 by Neil Nie
// All Rights Resered. 
// MIT License
// Contact: contact@neilnie.com
// 

module EAB(
	IR,
	Ra,
	PC,
	selEAB1,
	selEAB2,
	eabOut
);

// I/Os
input [15:0] Ra, PC;
input [10:0] IR;
input [1:0] selEAB2;
input selEAB1;

output [15:0] eabOut;

// internal variables
reg [15:0] mux_2_input, adder_input_2, adder_input_1;

always @(selEAB1 or Ra or PC) begin
	
	if (selEAB1 == 1'b1) begin
		adder_input_1 = Ra;
	end else if (selEAB1 == 1'b0) begin
		adder_input_1 = PC;
	end

end

always @(*) begin

	// sign extension
	if (selEAB2 == 2'b00) begin
		adder_input_2 = 0;
	end else if (selEAB2 == 2'b11)
		adder_input_2 = {IR[10],IR[10],IR[10],IR[10],IR[10], IR[10:0]};
	else if (selEAB2 == 2'b10) begin
		adder_input_2 = {IR[8],IR[8],IR[8],IR[8],IR[8],IR[8],IR[8], IR[8:0]};
	end else if (selEAB2 == 2'b01) begin
		adder_input_2 = {IR[5],IR[5],IR[5],IR[5],IR[5],IR[5],IR[5],IR[5],IR[5],IR[5], IR[5:0]};
	end

end

// addition operation
assign eabOut = adder_input_2 + adder_input_1;

endmodule
