//
// LC3Control
// Neil Nie, (c) 2018
// The State Machine of the LC-3
// Microprocessor. 
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
	regWE, memWE,
	current_state,
	
	// memory special outputs
	MDRSpcIn,
	MARSpcIn,
	ldMARSpcIn
);

// inputs
input [15:0] IR;
input clk, N,Z,P;

// outputs
output reg reset, enaALU;
output reg regWE, enaMARM, selMAR, selEAB1, enaPC;
output reg ldPC, ldIR, ldMAR, ldMDR, memWE, enaMDR;
output reg [1:0] aluControl, selPC, selEAB2, selMDR;
output reg [2:0] SR1, SR2, DR;

// special memory outputs
// memory special inputs
output reg [15:0] MDRSpcIn, MARSpcIn;
output reg ldMARSpcIn;

output reg [5:0] current_state;
reg [5:0] next_state;

initial begin
	current_state <= 6'b101111;
	// next_state <= 6'b000000;
end


always @ (posedge clk) begin

	//
	//
	// begin ============= instruction fetch ==================
	
	// state #: 18
	if (current_state == 6'b010010) begin
		
		// MAR <- PC
		memWE <= 0;		regWE <= 0;
		DR <= 3'b000; 	SR1 <= 3'b000; 	SR2 <= 3'b000;
		
		enaMARM <= 0; 	enaMDR <= 0; 		enaALU <= 0; enaPC <= 1;
		ldMAR <= 1;		ldPC <= 0;

		next_state <= 6'b100001;
	end
	
	// state #: 33
	else if (current_state == 6'b100001) begin
		
		// PC <- PC + 1
		// MDR <- M[MAR]

		selMDR <= 2'b01;
		ldMDR <= 1;
		ldMAR <= 0;
		ldPC <= 1;
		selPC <= 2'b00;
		
		enaMARM <= 0;	enaMDR <= 0;	enaALU <= 0;	enaPC <= 0;
	
		next_state <= 6'b100011;
	end
	
	// state #: 35
	else if (current_state == 6'b100011) begin
		
		// IR <- MDR
		enaMARM <= 0;	enaMDR <= 1;	enaALU <= 0;	enaPC <= 0;
		ldPC <= 0;		ldIR <= 1;		ldMDR <= 0;
		
		next_state <= 6'b100000;
	end
	// end ============== instruction fetch ===================
	// 
	//
	// begin ============= instruction parse ==================
	
	else if (current_state == 6'b100000) begin
		
		// close all tri state buffer
		enaMARM <= 0; 	enaMDR <= 0; 	enaALU <= 0; 	enaPC <= 0; 	
		
		ldPC <= 0;		ldIR <= 0;		ldMAR <= 0;		ldMDR <= 0;
		
		next_state <= {2'b00, IR[15:12]};
	end
	// end =============== instruction parse ==================
	//
	//
	// begin ============ instruction execute =================
	
	// state #: 1 (ADD)
	else if (current_state == 6'b000001) begin
		
		// DR <- SR1 + Op
		enaMARM <= 0; 		enaMDR <= 0; 		enaALU <= 1; 	enaPC <= 0; 
		DR <= IR[11:9]; 	SR1 <= IR[8:6]; 	SR2 <= IR[2:0];
		
		aluControl <= 2'b01;
		
		regWE <= 1;
		
		next_state <= 6'b010010;
		
	end
	
	// state #: 5 (AND)
	else if (current_state == 6'b000101) begin
		
		// DR <- SR1 & Op
		DR <= IR[11:9];
		SR1 <= IR[8:6];
		SR2 <= IR[2:0];
		aluControl <= 2'b10;
		
		enaMARM <= 0; 		enaMDR <= 0; 		enaALU <= 1; 	enaPC <= 0;
		regWE <= 1;
		
		next_state <= 6'b010010;
	end
	
	// state #: 9 (NOT)
	else if (current_state == 6'b001001) begin
		
		// DR <- NOT SR1
		DR <= IR[11:9];
		SR1 <= IR[8:6];
		aluControl <= 2'b11;
		next_state <= 6'b010010;
		
		enaALU <= 1;
		regWE <= 1;
		
	end
	
	// state #: 14 (LEA)
	else if (current_state == 6'b001110) begin
		
		// DR <- PC + OffSet9
		regWE <= 1;
		DR <= IR[11:9];	SR2 <= 3'b000; 	DR <= 3'b000;
		selEAB1 <= 0; 		selEAB2 <= 2'b10;	selMAR <= 0;
		enaMDR <= 0;		enaALU <= 0;		enaPC <= 0;			enaMARM <= 1;
		
		next_state <= 6'b010010;
	end
	
	// state #: 3 (ST)
	else if (current_state == 6'b000011) begin
		
		// MAR <= PC + Offset9
	
		enaMDR <= 0;		enaALU <= 0;		enaPC <= 0;			enaMARM <= 1'b1;
		selEAB2 <= 2'b10;	selEAB1 <= 1'b0;	selMAR <= 1'b0;
		ldMAR <= 1;			ldPC <= 0; 			ldIR <= 0;			ldMDR <= 0;
		SR1 <= 3'b000; 	SR2 <= 3'b000; 	DR <= 3'b000;
		memWE <= 0;			regWE <= 0;
		
		next_state <= 6'b010111;
	end
	
	// state #: 23
	else if (current_state == 6'b010111) begin
		
		// MDR <= SR
		
		enaMDR <= 0;		enaALU <= 1;		enaPC <= 0;			enaMARM <= 0;
		ldMAR <= 0;			ldPC <= 0; 			ldIR <= 0;			ldMDR <= 1;
		SR1 <= IR[11:9]; 	SR2 <= 3'b000; 	DR <= 3'b000;
		regWE <= 1'b0;		memWE <= 0;
		aluControl <= 2'b00;
		selMDR <= 2'b00;
		
		next_state <= 6'b010000;
	end
	
	// state #: 16
	else if (current_state == 6'b010000) begin
	
		// M[MAR] <= MDR
		
		memWE <= 1;
		next_state <= 6'b010010;
	end
	
	
	// ========================================================
	// ========= Preload instructions into the memory =========
	// ========================================================

	else if (current_state == 6'b101111) begin
		
		ldPC <= 1;
		selPC <= 2'b00;
		
		next_state <= 6'b101011;
	end
	
	// return to state 18
	else if (current_state == 6'b101011) begin
		
		ldMARSpcIn <= 0;
		
		next_state <= 6'b010010;
	end
	
	// ========================================================
	// ========================================================
	// ========================================================
	
end

always @ (negedge clk) begin
	
	current_state <= next_state;
end

endmodule
