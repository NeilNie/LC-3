//
// MARMux
//

module MARMux(
	IR,
	eabOut,
	selMAR,
	MARMuxOut
);

input [7:0] IR;
input [15:0] eabOut;
input selMAR;

output reg [15:0] MARMuxOut;

always @ (*) begin

	if (selMAR == 1) 
		MARMuxOut <= 16'b0 + IR;
	else 
		MARMuxOut <= eabOut;
	
end

endmodule
