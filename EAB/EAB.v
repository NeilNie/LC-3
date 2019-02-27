//
// EAB

module EAB(
	IR,
	Ra,
	PC,
	selEAB1,
	selEAB2,
	eabOut
//	adder_input_1,
//	adder_input_2
);

input [15:0] Ra, PC;
input [10:0] IR;
input [1:0] selEAB2;
input selEAB1;

output [15:0] eabOut;

reg [15:0] mux_2_input;

reg [15:0] adder_input_2, adder_input_1;

always @(selEAB1 or Ra or PC) begin
	
	if (selEAB1 == 1'b1) begin
		adder_input_1 = Ra;
	end else if (selEAB1 == 1'b0) begin
		adder_input_1 = PC;
	end

end

always @(*) begin

	if (selEAB2 == 2'b00) begin
		adder_input_2 = 0;
	end else if (selEAB2 == 2'b11) begin
		mux_2_input = {IR[10],IR[10],IR[10],IR[10],IR[10]};
		adder_input_2 = {mux_2_input, IR[10:0]};
	end else if (selEAB2 == 2'b10) begin
		mux_2_input = {IR[8],IR[8],IR[8],IR[8],IR[8],IR[8],IR[8]};
		adder_input_2 = {mux_2_input, IR[8:0]};
	end else if (selEAB2 == 2'b01) begin
		mux_2_input = {IR[5],IR[5],IR[5],IR[5],IR[5],IR[5],IR[5],IR[5],IR[5],IR[5]};
		adder_input_2 = {mux_2_input, IR[5:0]};
	end

end

assign eabOut = adder_input_2 + adder_input_1;

endmodule
