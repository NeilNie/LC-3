//
// LC-3 Processor
// Neil Nie
// (c) 2019, All Rights Reserved
//

module LC3 (clk,
	
	// for testing purposes only ----
	// comment out when not testing -
	reset,
	aluControl,
	enaALU, enaMARM, enaMDR, enaPC,
	selMAR, selEAB1, selEAB2,
	ldPC, ldIR, ldMAR, ldMDR,
	selPC, selMDR,
	SR1, SR2, DR,
	regWE, memWE,
	// ------------------------------
);

input clk;

//wire reset, aluControl, enaALU, enaMARM, enaMDR, enaPC;
//wire selMAR, selEAB1, selEAB2;
//wire ldPC, ldIR, ldMAR, ldMDR;
//wire selPC, selMDR;
//wire SR1, SR2, DR;
//wire regWE, memWE;

// for testing purposes only ---------------
input [1:0] selEAB2;
input [1:0] aluControl;
input [1:0] selPC;
input reset, enaALU, enaMARM, enaMDR, enaPC;
input selMAR, selEAB1;
input ldPC, ldIR, ldMAR, ldMDR;
input selMDR;
input SR1, SR2, DR;
input regWE, memWE;
// ----------------------------------------

// internal wires
reg [15:0] Bus_reg;
wire [15:0] PC;
wire [15:0] Bus;
wire [15:0] aluOut;
wire [15:0] MDROut;
wire [15:0] MARMuxOut;
wire [15:0] sa, regOut1;
wire [15:0] eabOut;
wire [15:0] IR;
wire N, Z, P;

// =======================================================================
// ===================== Implementation begin ============================
// =======================================================================

tri_state_buffer MARBuffer(.sel(enaMARM), .in(MARMuxOut), .out(Bus_reg));
tri_state_buffer PCBuffer(.sel(enaPC), .in(PC), .out(Bus_reg));
tri_state_buffer ALUBuffer(.sel(enaALU), .in(aluOut), .out(Bus_reg));
tri_state_buffer MemBuffer(.sel(enaMDR), .in(MDROut), .out(Bus_reg));

// Finite State Machine Control 
//LC3Control FSM(
//
//	// inputs
//	.IR(IR),
//	.N(N), .Z(Z), .P(P),
//	// outputs
//	.clk(clk),
//	.reset(reset),
//	.aluControl(aluControl),
//	.enaALU(enaALU), .enaMARM(enaMARM), .enaMDR(enaMDR), .enaPC(enaPC),
//	.selMAR(selMAR), .selEAB1(selEAB1), .selEAB2(selEAB2),
//	.ldPC(ldPC), .ldIR(ldIR), .ldMAR(ldMAR), .ldMDR(ldMDR),
//	.selPC(selPC), .selMDR(selMDR),
//	.SR1(SR1), .SR2(SR2), .DR(DR),
//	.regWE(regWE), .memWE(memWE),
//);

// -----------------------------------------------------

RegisterFile reg_file(

	.Bus(Bus), .Out0(regOut0), .Out1(regOut0),
	.clk(clk), .WE(regWE), .reset(reset),
	.DR(DR), .SR0(SR0), .SR1(SR1)
);

// -----------------------------------------------------

PC pc(
	.clk(clk),
	.reset(reset),
	.ldPC(ldPC),
	.eabOut(eabOut),
	.selPC(selPC),
	.Bus(Bus),
	.PCOut(PC)
);

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
	.MDROut(MDROut)
);

// -----------------------------------------------------

MARMux mar_mux(
	.IR(IR),
	.eabOut(eabOut),
	.selMAR(selMAR),
	.MARMuxOut(MARMuxOut)
);

// -----------------------------------------------------

IR ir(
	.clk(clk),
	.ldIR(ldIR),
	.reset(reset),
	.Bus(Bus),
	.IR(IR)
);

// -----------------------------------------------------

EAB eab(
	.IR(IR),
	.Ra(regOut0),
	.PC(PC),
	.selEAB1(selEAB1),
	.selEAB2(selEAB2),
	.eabOut(eabOut),
);

// -----------------------------------------------------

ALU alu(
	.Ra(regOut0),
	.Rb(regOut1),
	.IR(IR),
	.aluControl(aluControl),
	.aluOut(aluOut)
);

// =======================================================================
// ====================== Implementation ends ============================
// =======================================================================

endmodule
