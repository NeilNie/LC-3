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
	
output reg reset, enaALU;
output reg regWE, enaMARM, selMAR, selEAB1, enaPC;
output reg ldPC, ldIR, ldMAR, ldMDR, selMDR, memWE, enaMDR;
output reg [1:0] aluControl, selPC, selEAB2;
output reg [2:0] SR1, SR2, DR;

reg [5:0] current_state;
reg [5:0] J;


always @ (posedge clk) begin

	//
	//
	// begin ============= instruction fetch ==================
	
	// state #: 18
	if (current_state == 6'b010010) begin
		
		// MAR <- PC
		// PC <- PC + 1
		enaPC <= 1;
		ldMAR <= 1;
		selPC <= 2'b00;
		ldPC <= 1;
		
		J <= 6'b100001;
	end
	
	// state #: 33
	else if (current_state == 6'b100001) begin
	
		// MDR <- M
		selMDR <= 1;
		ldMDR <= 1;
		enaPC <= 0; 	// close PC tri state buffer
		
		J <= 6'b100011;
	end
	
	// state #: 35
	else if (current_state == 6'b100011) begin
		
		// IR <- MDR
		enaMDR <= 1;
		ldIR <= 1;
		
		J <= 6'b100000;
	end
	// end ============== instruction fetch ===================
	
	// 
	//
	
	// begin ============= instruction parse ==================
	
	else if (current_state == 6'b100000) begin
		J <= {2'b00, IR[15:12]};
	end
	// end =============== instruction parse ==================
	//
	//
	// begin ============ instruction execute =================
	
	// state #: 1 (ADD)
	else if (current_state == 6'b000001) begin
		
		// DR <- SR1 + Op
		DR <= IR[11:9];
		SR1 <= IR[8:6];
		SR2 <= IR[2:0];
		aluControl <= 2'b01;
		
		enaALU <= 1;
		regWE <= 1;
		
		J <= 6'b010010;
	end
	
	// state #: 5 (AND)
	else if (current_state == 6'b000101) begin
		
		// DR <- SR1 & Op
		DR <= IR[11:9];
		SR1 <= IR[8:6];
		SR2 <= IR[2:0];
		aluControl <= 2'b10;
		J <= 6'b010010;
		
		enaALU <= 1;
		regWE <= 1;
	end
	
	// state #: 9 (NOT)
	else if (current_state == 6'b001001) begin
		
		// DR <- NOT SR1
		DR <= IR[11:9];
		SR1 <= IR[8:6];
		aluControl <= 2'b11;
		J <= 6'b010010;
		
		enaALU <= 1;
		regWE <= 1;
		
	end

end

always @ (negedge clk) begin
	
	current_state <= J;
end

endmodule
