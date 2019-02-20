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
	current_state <= 6'b000000;
	next_state <= 6'b000000;
end


always @ (posedge clk) begin

	//
	//
	// begin ============= instruction fetch ==================
	
	// state #: 18
	if (current_state == 6'b010010) begin
		
		// MAR <- PC
		// PC <- PC + 1
		
		memWE <= 0;
		enaMARM <= 0;
		enaMDR <= 0;
		enaALU <= 0;
		
		enaPC <= 1;
		ldMAR <= 1;
		selPC <= 2'b00;
		ldPC <= 1;
		
		next_state <= 6'b100001;
	end
	
	// state #: 33
	else if (current_state == 6'b100001) begin
	
		// MDR <- M
		ldPC <= 0;
		enaMARM <= 0;
		enaMDR <= 0;
		enaALU <= 0;
		enaPC <= 0; 	// close all tri state buffer
		
		selMDR <= 2'b01;
		ldMDR <= 1;
		
		next_state <= 6'b100011;
	end
	
	// state #: 35
	else if (current_state == 6'b100011) begin
		
		// IR <- MDR
		enaMARM <= 0;
		enaMDR <= 1;
		enaALU <= 0;
		enaPC <= 0; 	// close all tri state buffer
		ldPC <= 0;
		ldIR <= 1;
		
		next_state <= 6'b100000;
	end
	// end ============== instruction fetch ===================
	
	// 
	//
	
	// begin ============= instruction parse ==================
	
	else if (current_state == 6'b100000) begin
		enaMARM <= 0;
		enaMDR <= 0;
		enaALU <= 0;
		enaPC <= 0; 	// close all tri state buffer
		ldPC <= 0;
		next_state <= {2'b00, IR[15:12]};
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
		
		next_state <= 6'b010010;
	end
	
	// state #: 5 (AND)
	else if (current_state == 6'b000101) begin
		
		// DR <- SR1 & Op
		DR <= IR[11:9];
		SR1 <= IR[8:6];
		SR2 <= IR[2:0];
		aluControl <= 2'b10;
		next_state <= 6'b010010;
		
		enaALU <= 1;
		regWE <= 1;
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
		
		DR <= IR[11:9];
		
		selEAB1 <= 0;
		selEAB2 <= 2'b10;
		selMAR <= 0;
		enaMARM <= 1;
		
		// ldPC <= 1;
		
		next_state <= 6'b010010;
	end
	
	// state #: 3 (ST)
	else if (current_state == 6'b000011) begin
		
		// MAR <= PC + Offset9
		
		enaMDR <= 0;
		enaALU <= 0;
		enaPC <= 0;
		
		selEAB2 <= 2'b10;
		selEAB1 <= 1'b0;
		selMAR <= 1'b0;
		enaMARM <= 1'b1;
		ldMAR <= 1'b1;
		
		next_state <= 6'b010111;
	end
	
	// state #: 23
	else if (current_state == 6'b010111) begin
		
		// MDR <= SR
		
		enaMDR <= 0;
		enaALU <= 1;
		enaPC <= 0;
		enaMARM <= 0;
		
		SR1 <= IR[11:9];
		regWE <= 1'b0;
		aluControl <= 2'b00;
		selMDR <= 2'b00;
		ldMDR <= 1'b1;
		
		next_state <= 6'b010000;
	end
	
	// state #: 16
	else if (current_state == 6'b010000) begin
	
		// M[MAR <= MDR
		
		memWE <= 1;
		next_state <= 6'b010010;
	end
	
	
	// ========================================================
	// ========= Preload instructions into the memory =========
	// ========================================================
	
	// first instruction address
	else if (current_state == 6'b000000) begin
		
		MARSpcIn <= 16'h3001;
		ldMAR <= 1;
		ldMARSpcIn <= 1;
		memWE <= 1;
		next_state <= 6'b111111;
		
	end
	
	// first instruction value
	else if (current_state == 6'b111111) begin
		
		MDRSpcIn <= 16'b1110001000000111;	// LEA, R1, OffSet=7
		ldMDR <= 1;
		selMDR <= 2'b11;
		memWE <= 1;
		
		next_state <= 6'b110000;
	end
	
	// second instruction address
	else if (current_state == 6'b110000) begin
		
		MARSpcIn <= 16'h3002;
		ldMAR <= 1;
		ldMARSpcIn <= 1;
		memWE <= 1;
		next_state <= 6'b101000;
		
	end
	
	// second instruction value
	else if (current_state == 6'b101000) begin
		
		MDRSpcIn <= 16'b0011001000000000;	// ST, R1, OffSet=0
		ldMDR <= 1;
		selMDR <= 2'b11;
		memWE <= 1;

		next_state <= 6'b111110;
	end
	
	
	// ------------------------------------------------------
	// testing reading values
	// ------------------------------------------------------
	else if (current_state == 6'b111110) begin
		
		MARSpcIn <= 16'h3002;
		ldMAR <= 1;
		ldMARSpcIn <= 1;
		memWE <= 0;
		
		next_state <= 6'b101010;
	
	end
	
	else if (current_state == 6'b101010) begin
	
		selMDR <= 2'b01;
		ldMDR <= 1;
		
		enaMDR <= 1;
		enaALU <= 0;
		enaMARM <= 0;
		enaPC <= 0;
		
		ldPC <= 1;
		
		next_state <= 6'b101011;
	end
	
	// return to state 18
	else if (current_state == 6'b101011) begin
		
		enaMDR <= 0;
		enaALU <= 0;
		enaMARM <= 0;
		enaPC <= 0;
		ldPC <= 0;
		
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
