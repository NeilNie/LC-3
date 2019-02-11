//
// Bus tri state buffer
//
//

module bus_tri_state_buffer(
	MARMuxOut,
	enaMARM,
	PC,
	enaPC,
	aluOut,
	enaALU,
	MDROut,
	enaMDR,
	Bus
);

output reg [15:0] Bus;
input [15:0] MARMuxOut, PC, aluOut, MDROut;
input enaMARM, enaPC, enaALU, enaMDR;

always @ (MARMuxOut or enaMARM or PC or enaPC or aluOut or enaALU or MDROut or enaMDR) begin

	if (enaMARM == 1'b1) begin
		Bus <= MARMuxOut;
	end else if (enaPC == 1'b1) begin
		Bus <= PC;
	end else if (enaALU == 1'b1) begin
		Bus <= aluOut;
	end else if (enaMDR == 1'b1) begin
		Bus <= MDROut;
	end
end

endmodule

