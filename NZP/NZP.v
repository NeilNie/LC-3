//
// NZP
//
// Copyright (c) 2018 by Neil Nie
// All Rights Resered. 
// MIT License
// Contact: contact@neilnie.com
// 

module NZP (
	Bus,
	clk,
	regWE,
	reset,
	N,	Z,	P
);

input [15:0] Bus;
input clk, regWE, reset;
output N, Z, P;

reg N_buffer, Z_buffer, P_buffer;

initial begin
	N_buffer <= 0;
	Z_buffer <= 0;
	P_buffer <= 0;
end

NZP_register register(.D({N_buffer, Z_buffer, P_buffer}), .Q({N, Z, P}), .en(regWE), .reset(reset), .clk(clk));

always @ (Bus) begin

	if (Bus[15] == 1) begin
		N_buffer <= 1;
		P_buffer <= 0;
		Z_buffer <= 0;
	end else if (Bus > 16'b0) begin
		P_buffer <= 1;
		N_buffer <= 0;
		Z_buffer <= 0;
	end else if (Bus == 16'b0) begin
		Z_buffer <= 1;
		P_buffer <= 0;
		N_buffer <= 0;
	end

end

endmodule
