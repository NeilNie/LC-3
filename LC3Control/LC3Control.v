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
		
		next_state <= 6'b010010;
	end
	
	// ========================================================
	// ========= Preload instructions into the memory =========
	// ========================================================
	else if (current_state == 6'b000000) begin
		
		MDRSpcIn <= 16'b1110001000000111;	// LEA, R1, OffSet=7
		MARSpcIn <= 16'h3001;
		ldMAR <= 1;
		ldMDR <= 1;
		ldMARSpcIn <= 1;
		selMDR <= 2'b11;
		
		next_state <= 6'b111111;
	end
	
	// this is an empty state
	else if (current_state == 6'b111111) begin
		
		next_state <= 6'b110000;
	end
	
	else if (current_state == 6'b110000) begin
		
		MDRSpcIn <= 16'b0001100001000011;	// ADD, R4, R1, R3
		MARSpcIn <= 16'h3003;
		ldMAR <= 1;
		ldMDR <= 1;
		selMDR <= 2'b11;
		ldMARSpcIn <= 1;
		memWE <= 1;
		
		next_state <= 6'b111000;
	end
	
	else if (current_state == 6'b111000) begin
		
		MDRSpcIn <= 16'b0001101001101111;	// ADD, R5, R1, 01111
		MARSpcIn <= 16'h3004;
		ldMAR <= 1;
		ldMDR <= 1;
		ldMARSpcIn <= 1;
		selMDR <= 2'b11;
		memWE <= 1;
		
		next_state <= 6'b111110;
	end
	
	// testing reading values
	else if (current_state == 6'b111110) begin
		
		MARSpcIn <= 16'h3001;
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
	
	else if (current_state == 6'b101011) begin
		
		enaMDR <= 0;
		enaALU <= 0;
		enaMARM <= 0;
		enaPC <= 0;
		ldPC <= 0;
		
		next_state <= 6'b010010;
	end
	
//	else if (current_state == 6'b111100) begin
//		next_state <= 6'b010010;
//		ldPC <= 1;
//		
//		memWE <= 0;
//		ldMAR <= 0;
//		ldMDR <= 0;
//		ldMDRSpcIn <= 0;
//		ldMARSpcIn <= 0;
//	end
	
	// ========================================================
	// ========================================================
	// ========================================================
	
end

always @ (negedge clk) begin
	
	current_state <= next_state;
end

endmodule
