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

reg [5:0] current_state;
reg [5:0] next_state;


always @ (posedge clk) begin

	//
	//
	// begin ============= instruction fetch ==================
	
	// state #: 18
	if (current_state == 6'b010010) begin
		// MAR <- PC
		// PC <- PC + 1
		next_state <= 6'b100001;
	end
	
	// state #: 33
	else if (current_state == 6'b100001) begin
		// MDR <- M
		next_state <= 6'b100011;
	end
	
	// state #: 35
	else if (current_state == 6'b100011) begin
		
		// IR <- MDR
		next_state <= 6'b100000;
	end
	
	// end ============== instruction fetch ===================
	// 
	//
	// begin ============= instruction parse ==================
	
	else if (current_state == 6'b100000) begin
	
	end
	// end =============== instruction parse ==================
	//
	// begin ============ instruction execute =================

	

end

always @ (negedge clk) begin
	
	current_state <= next_state;
end

endmodule
