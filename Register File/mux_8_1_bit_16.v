//
// 128 -> 16 Mux
// Neil Nie
// (c) 2019, All Rights Reserved
//


module mux_8_1_bit_16(
sel,
in0, in1, in2, in3, in4, in5, in6, in7,
out
);

input [2:0] sel;
input [15:0] in0, in1, in2, in3, in4, in5, in6, in7;
output reg [15:0] out;

always @(*) begin
	
	if (sel == 3'b000)
		out <= in0;
	else if (sel == 3'b001)
		out <= in1;
	else if (sel == 3'b010)
		out <= in2;
	else if (sel == 3'b011)
		out <= in3;
	else if (sel == 3'b100)
		out <= in4;
	else if (sel == 3'b101)
		out <= in5;
	else if (sel == 3'b110)
		out <= in6;
	else if (sel == 3'b111)
		out <= in7;

end

endmodule
