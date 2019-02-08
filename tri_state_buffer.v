//
// tri_state_buffer
// Neil Nie
// (c) 2019, All Rights Reserved
// 

module tri_state_buffer(
	sel,
	in,
	out
);

input sel;
input [15:0] in;
output reg [15:0] out;

// reg [15:0] in;

always @ (*)
	if (sel == 1'b1)
		out <= in;
	
endmodule

