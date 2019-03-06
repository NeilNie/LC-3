//
// ALU with IR Mux included
//
// Copyright (c) 2018 by Neil Nie
// All Rights Resered. 
// MIT License
// Contact: contact@neilnie.com
// 


module ALU(
	Ra,
	Rb,
	IR,
	aluControl,
	aluOut
);

input [15:0] Ra, Rb;
input [5:0] IR;
input [1:0] aluControl;

output reg [15:0] aluOut;

reg [15:0] adder_in_b;

// Rb mux
// selecting between IR or Rb
// --------------------------
always @ (IR or Rb) begin

	if (IR[5] == 0) begin
		adder_in_b = Rb;
	end else begin
		adder_in_b = {IR[4],IR[4],IR[4],IR[4],IR[4],IR[4],IR[4],IR[4],IR[4],IR[4], IR[4]};
		adder_in_b = {adder_in_b, IR[4:0]};
	end
		
end

always @ (aluControl or Ra or adder_in_b) begin
	if (aluControl == 2'b00)
		aluOut <= Ra;
	else if (aluControl == 2'b01)
		aluOut <= Ra + adder_in_b;
	else if (aluControl == 2'b10)
		aluOut <= Ra & adder_in_b;
	else if (aluControl == 2'b11)
		aluOut <= ~Ra;
end

endmodule
