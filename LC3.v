//
// LC-3 Processor
// Neil Nie
// (c) 2019, All Rights Reserved
//

module LC3 (clk,
	
	// for testing purposes only ----
	// comment out when not testing -
//	reset,
//	aluControl,
//	enaALU, enaMARM, enaMDR, enaPC,
//	selMAR, selEAB1, selEAB2,
//	ldPC, ldIR, ldMAR, ldMDR,
//	selPC, selMDR,
//	SR0, SR1, DR,
//	regWE, memWE,
	IR,
	Bus,
	PC,
	current_state,
	
	MDRSpcIn, MARSpcIn,
	ldMARSpcIn,
	memOut
	// ------------------------------
);

input clk;
output [5:0] current_state;

wire [1:0] selEAB2;
wire [1:0] aluControl;
wire [1:0] selPC;
wire reset, enaALU, enaMARM, enaMDR, enaPC;
wire selMAR, selEAB1;
wire ldPC, ldIR, ldMAR, ldMDR;
wire [1:0] selMDR;
wire [2:0] SR0, SR1, DR;
wire regWE, memWE;

// internal wires
output [15:0] IR, Bus, PC;
wire [15:0] ALUOut;
wire [15:0] MDROut;
wire [15:0] MARMuxOut;
wire [15:0] regOut0;
wire [15:0] regOut1;
wire [15:0] eabOut;
wire [15:0] IR;
wire N, Z, P;

// memory special inputs
output [15:0] MDRSpcIn, MARSpcIn, memOut;
output ldMARSpcIn;

// =======================================================================
// ===================== Implementation begin ============================
// =======================================================================

bus_tri_state_buffer tsb(.MARMuxOut(MARMuxOut),
								 .enaMARM(enaMARM),
								 .PC(PC),
								 .enaPC(enaPC),
								 .aluOut(ALUOut),
								 .enaALU(enaALU),
								 .MDROut(MDROut),
								 .enaMDR(enaMDR),
								 .Bus(Bus));

// -----------------------------------------------------

// Finite State Machine Control 
LC3Control FSM(

	// inputs
	.IR(IR),
	.N(N), .Z(Z), .P(P),
	// outputs
	.clk(clk),
	.reset(reset),
	.aluControl(aluControl),
	.enaALU(enaALU), .enaMARM(enaMARM), .enaMDR(enaMDR), .enaPC(enaPC),
	.selMAR(selMAR), .selEAB1(selEAB1), .selEAB2(selEAB2),
	.ldPC(ldPC), .ldIR(ldIR), .ldMAR(ldMAR), .ldMDR(ldMDR),
	.selPC(selPC), .selMDR(selMDR),
	.SR1(SR0), .SR2(SR1), .DR(DR),
	.regWE(regWE), .memWE(memWE),
	.current_state(current_state),
	.MDRSpcIn(MDRSpcIn),
	.MARSpcIn(MARSpcIn),
	.ldMARSpcIn(ldMARSpcIn)
);

// -----------------------------------------------------

RegisterFile reg_file(
	.Bus(Bus), .Out0(regOut0), .Out1(regOut1),
	.clk(clk), .WE(regWE), .reset(reset),
	.DR(DR), .SR0(SR0), .SR1(SR1)
);

// -----------------------------------------------------

PC pc(.clk(clk),
		.reset(reset),
		.ldPC(ldPC),
		.eabOut(eabOut),
		.selPC(selPC),
		.Bus(Bus),
		.PCOut(PC));

// -----------------------------------------------------

NZP nzp(
	.Bus(Bus),
	.clk(clk),
	.regWE(regWE),
	.reset(reset),
	.N(N), .Z(Z), .P(P)
);

// -----------------------------------------------------

Memory memory(
	.Bus(Bus),
	.ldMAR(ldMAR),
	.ldMDR(ldMDR),
	.memWE(memWE),
	.selMDR(selMDR),
	.clk(clk),
	.reset(reset),
	.MDROut(MDROut),
	// memory special inputs
	.MDRSpcIn(MDRSpcIn),
	.MARSpcIn(MARSpcIn),
	.ldMARSpcIn(ldMARSpcIn),
	.memOut(memOut));

// -----------------------------------------------------

MARMux mar_mux(
	.IR(IR),
	.eabOut(eabOut),
	.selMAR(selMAR),
	.MARMuxOut(MARMuxOut));

// -----------------------------------------------------

IR ir(.clk(clk),
		.ldIR(ldIR),
		.reset(reset),
		.Bus(Bus),
		.IR(IR));

// -----------------------------------------------------

EAB eab(.IR(IR),
		  .Ra(regOut0),
		  .PC(PC),
		  .selEAB1(selEAB1),
		  .selEAB2(selEAB2),
		  .eabOut(eabOut),);

// -----------------------------------------------------

ALU alu(.Ra(regOut0),
		  .Rb(regOut1),
		  .IR(IR),
		  .aluControl(aluControl),
		  .aluOut(ALUOut));

// =======================================================================
// ====================== Implementation ends ============================
// =======================================================================

endmodule
