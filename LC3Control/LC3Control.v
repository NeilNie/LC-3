//
// LC3Control
// Neil Nie, (c) 2018
//
//

module LC3Control(

	// inputs
	clk,
	IR,
	N,Z,P,
	
	// outputs
	reset,
	aluControl,
	enaALU, enaMARM, enaMDR, enaPC,
	selMAR, selEAB1, selEAB2,
	ldPC, ldIR, ldMAR, ldMDR,
	selPC, selMDR,
	SR1, SR2, DR,
	regWE, memWE
);

input [15:0] IR;
input clk, N,Z,P;
	
output reset, enaALU;
output regWE, enaMARM, selMAR, selEAB1, enaPC;
output ldPC, ldIR, ldMAR, ldMDR, selMDR, memWE, enaMDR;
output [1:0] aluControl, selPC, selEAB2;
output [2:0] SR1, SR2, DR;


endmodule
