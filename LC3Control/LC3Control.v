//
// LC3Control
//
// The State Machine of the LC-3
// Microprocessor. 
// 
// Copyright (c) 2018 by Neil Nie
// All Rights Resered. 
// MIT License
// Contact: contact@neilnie.com
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
	current_state
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

// internal variables
output reg [5:0] current_state;
reg [5:0] next_state;

initial begin
	current_state <= 6'b101111;
end


always @ (posedge clk) begin

	
	case (current_state) 
		
		//
		// begin ============= instruction fetch ==================
	
		18: begin
		
			// MAR <- PC
			// PC <- PC + 1
			memWE <= 0;		regWE <= 0;
			DR <= 3'b000; 	SR1 <= 3'b000; 	SR2 <= 3'b000;
			enaMARM <= 0; 	enaMDR <= 0; 		enaALU <= 0; enaPC <= 1;
			selPC <= 2'b00;
			ldMAR <= 1;		ldPC <= 1;

			next_state <= 6'b100001;
		
		end
		
		33: begin
			
			
			// MDR <- M[MAR]
			selMDR <= 2'b01;	selPC <= 2'b00;
			ldMDR <= 1;			ldMAR <= 0;			ldPC <= 0;
			SR1 <= 3'b000; 	SR2 <= 3'b000; 	DR <= 3'b000;
			enaMARM <= 0;		enaMDR <= 0;		enaALU <= 0;	enaPC <= 0;
		
			next_state <= 6'b100011;
		
		end
		
		35: begin
		
			// IR <- MDR
			enaMARM <= 0;	enaMDR <= 1;	enaALU <= 0;	enaPC <= 0;
			ldPC <= 0;		ldIR <= 1;		ldMDR <= 0;
			
			next_state <= 6'b100000;
		
		end
		
		// end ============== instruction fetch ===================
		// 
		//
		// begin ============= instruction parse ==================
	
		32: begin
		
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
		1: begin
		
			// DR <- SR1 + Op
			enaMARM <= 0; 		enaMDR <= 0; 		enaALU <= 1; 	enaPC <= 0; 
			DR <= IR[11:9]; 	SR1 <= IR[8:6]; 	SR2 <= IR[2:0];
			
			aluControl <= 2'b01;
			
			regWE <= 1;
			
			next_state <= 6'b010010;
		
		end
		
		// state #: 5 (AND)
		5: begin
		
			// DR <- SR1 & Op
			DR <= IR[11:9];	SR1 <= IR[8:6];	SR2 <= IR[2:0];
			aluControl <= 2'b10;
			
			enaMARM <= 0; 		enaMDR <= 0; 		enaALU <= 1; 	enaPC <= 0;
			regWE <= 1;
			
			next_state <= 6'b010010;
		
		end
		
		// state #: 9 (NOT)
		9: begin
	
			// DR <- NOT SR1
			DR <= IR[11:9];	SR1 <= IR[8:6]; 	SR2 <= 3'b000;
			aluControl <= 2'b11;
			
			enaMARM <= 0; 		enaMDR <= 0; 		enaALU <= 1; 	enaPC <= 0;
			regWE <= 1;
			
			next_state <= 6'b010010;
		
		end
		
		// state #: 14 (LEA)
		14: begin
		
			// DR <- PC + OffSet9
			regWE <= 1;
			
			DR <= IR[11:9];	SR2 <= 3'b000; 	SR1 <= 3'b000;
			selEAB1 <= 0; 		selEAB2 <= 2'b10;	selMAR <= 0;
			enaMDR <= 0;		enaALU <= 0;		enaPC <= 0;			enaMARM <= 1;
			
			next_state <= 6'b010010;
		
		end
		
		// state #: 2 (LD)
		2: begin
		
			selEAB2 <= 2'b10;	selEAB1 <= 0;	selMAR <= 0;
			ldMAR <= 1;			ldMDR <= 0;		ldIR <= 0;		ldPC <= 0;
			enaMARM <= 1;		enaPC <= 0;		enaMDR <= 0; 	enaALU <= 0;
			
			next_state <= 25;
		end
		
		// state #: 25
		25: begin
		
			selMDR <= 1;	
			ldMDR <= 1;		ldMAR <= 0;		ldIR <= 0;		ldPC <= 0;
			enaMARM <= 0;		enaPC <= 0;		enaMDR <= 0; 	enaALU <= 0;
			
			next_state <= 27;
		
		end
		
		// state #: 27
		27: begin
		
			DR <= IR[11:9];	regWE <= 1;
			SR1 <= 3'b000;		SR2 <= 3'b111;
			ldMDR <= 0;		ldMAR <= 0;		ldIR <= 0;		ldPC <= 0;
			enaMARM <= 0;		enaPC <= 0;		enaMDR <= 1; 	enaALU <= 0;
			
			next_state <= 18;
			
		end
		
		// state #: 6	(LDR)
		6: begin
			
			SR1 <= IR[8:6];		SR2 <= 3'b111;	DR <= 3'b000;
			selEAB2 <= 2'b10;	selEAB1 <= 1;	selMAR <= 0;
			ldMAR <= 1;			ldMDR <= 0;		ldIR <= 0;		ldPC <= 0;
			enaMARM <= 1;		enaPC <= 0;		enaMDR <= 0; 	enaALU <= 0;
			
			next_state <= 25;
			
		end
		
		// state #: 10 (LDI)
		10: begin
		
			next_state <= 24;
			
		end
		
		// state #: 24
		24: begin
			next_state <= 26;
			
		end
		
		// state #: 26
		26: begin
		
			next_state <= 25;
			
		end
		
		// state #: 3 (ST)
		3: begin
		
			// MAR <= PC + Offset9
		
			enaMDR <= 0;		enaALU <= 0;		enaPC <= 0;			enaMARM <= 1;
			selEAB2 <= 2'b10;	selEAB1 <= 1'b0;	selMAR <= 1'b0;
			ldMAR <= 1;			ldPC <= 0; 			ldIR <= 0;			ldMDR <= 0;
			SR1 <= 3'b000; 	SR2 <= 3'b000; 	DR <= 3'b000;
			memWE <= 0;			regWE <= 0;
			
			next_state <= 6'b010111;
		
		end
		
		// state #: 23
		23: begin
		
			// MDR <= SR
			SR1 <= IR[11:9]; 	SR2 <= IR[11:9]; 	DR <= 3'b000;
			regWE <= 0;			memWE <= 0;
			aluControl <= 2'b00;
			selMDR <= 0;
			
			enaMDR <= 0;		enaALU <= 1;		enaPC <= 0;			enaMARM <= 0;
			ldMAR <= 0;			ldPC <= 0; 			ldIR <= 0;			ldMDR <= 1;
			
			next_state <= 6'b010000;
		
		end
		
		// state #: 16
		16: begin
		
			// M[MAR] <= MDR
			memWE <= 1;
			regWE <= 0;
			
			// make sure to turn everyhting else off 
			SR1 <= 3'b000; 	SR2 <= 3'b000; 	DR <= 3'b000;
			enaMDR <= 0;		enaALU <= 0;		enaPC <= 0;			enaMARM <= 0;
			ldMAR <= 0;			ldPC <= 0; 			ldIR <= 0;			ldMDR <= 0;
			
			next_state <= 6'b010010;
		
		end
		
		// state #: 0 (BR)
		0: begin
			
			reg [2:0] cond_code;
			cond_code <= {IR[11], IR[10], IR[9]};
			
			if (N == IR[11] && Z == IR[10] && P == IR[9]) begin
				
				enaPC <= 0;	enaMARM <= 0; enaMDR <= 0; enaALU <= 0;
				ldMAR <= 0; ldMDR <= 0;
				regWE <= 0;	memWE <= 0;
				
				selEAB1 <= 0; selEAB2 <= 2'b10;
				selPC <= 2'b01;	ldPC <= 1;
			end 
			
			next_state <= 6'b010010;
			
		end
		
		// state #: 0 (TRAP)
		15: begin
			
			if (IR[7:0] == 8'b00100101) begin
				next_state <= 6'b111111;
			end
		
		end
		
		default: begin
			
			// outputs
			reset <= 0; enaALU <= 0;
			regWE <= 0; enaMARM <= 0; selMAR <= 0; selEAB1 <= 0; enaPC <= 0;
			ldPC <= 0; ldIR <= 0; ldMAR <= 0; ldMDR <= 0; memWE <= 0; enaMDR <= 0;
			aluControl <= 2'b00; selPC <= 2'b00; selEAB2 <= 2'b00; selMDR <= 2'b00;
			SR1 <= 3'b000; SR2 <= 3'b000; DR <= 3'b000;
		end
	
	endcase
	
	// ========================================================
	// =================== initializationn ====================
	// ========================================================

	if (current_state == 6'b101111) begin
		
		ldPC <= 1;
		selPC <= 2'b00;
		
		next_state <= 6'b101011;
	end
	
	// return to state 18
	else if (current_state == 6'b101011) begin
		
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
