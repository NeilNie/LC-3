//
// ALU
//

module ALU(
A,
B,
aluControl,
aluOut
);

input [15:0] A, B;
input [1:0] aluControl;

output reg [15:0] aluOut;

always @ (*) begin
	if (aluControl == 2'b00)
		aluOut <= A;
	else if (aluControl == 2'b01)
		aluOut <= A + B;
	else if (aluControl == 2'b10)
		aluOut <= A & B;
	else if (aluControl == 2'b11)
		aluOut <= ~A;
end

endmodule
