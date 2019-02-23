// Copyright (C) 2018  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details.

// *****************************************************************************
// This file contains a Verilog test bench with test vectors .The test vectors  
// are exported from a vector file in the Quartus Waveform Editor and apply to  
// the top level entity of the current Quartus project .The user can use this   
// testbench to simulate his design using a third-party simulation tool .       
// *****************************************************************************
// Generated on "02/20/2019 23:14:22"
// Verilog Test Bench (with test vectors) for design :                          LC3
// 
// Simulation tool : 3rd Party
// 

`timescale 1 ps/ 1 ps

module general_tb();

// constants                                           
// general purpose registers
reg clk;
reg [10:0] count;
// wires                                               
wire [15:0] Bus;
wire [15:0] IR;
wire [15:0] MARSpcIn;
wire [15:0] MDRSpcIn;
wire [15:0] PC;
wire [5:0] current_state;
wire ldMARSpcIn;
wire [15:0] memOut;

// assign statements (if any)                          
LC3 i1 (
// port map - connection between master ports and signals/registers   
	.Bus(Bus),
	.IR(IR),
	.MARSpcIn(MARSpcIn),
	.MDRSpcIn(MDRSpcIn),
	.PC(PC),
	.clk(clk),
	.current_state(current_state),
	.ldMARSpcIn(ldMARSpcIn),
	.memOut(memOut)
);

initial begin

clk = 0;
count = 0;

end

// clk
always begin
	#10 clk = !clk;
end

always @ (posedge clk) begin
	
	count = count + 1;
	if (count == 15) begin
		$stop;
	end

end

endmodule

