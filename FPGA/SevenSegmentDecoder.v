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

// PROGRAM		"Quartus Prime"
// VERSION		"Version 18.1.0 Build 625 09/12/2018 SJ Lite Edition"
// CREATED		"Sat Oct 13 12:53:06 2018"

module SevenSegmentDecoder(
	in,
	HEX0
);


input wire	[3:0] in;
output wire	[6:0] HEX0;

wire	SYNTHESIZED_WIRE_54;
wire	SYNTHESIZED_WIRE_55;
wire	SYNTHESIZED_WIRE_56;
wire	SYNTHESIZED_WIRE_3;
wire	SYNTHESIZED_WIRE_4;
wire	SYNTHESIZED_WIRE_5;
wire	SYNTHESIZED_WIRE_57;
wire	SYNTHESIZED_WIRE_58;
wire	SYNTHESIZED_WIRE_12;
wire	SYNTHESIZED_WIRE_13;
wire	SYNTHESIZED_WIRE_59;
wire	SYNTHESIZED_WIRE_60;
wire	SYNTHESIZED_WIRE_16;
wire	SYNTHESIZED_WIRE_17;
wire	SYNTHESIZED_WIRE_18;
wire	SYNTHESIZED_WIRE_61;
wire	SYNTHESIZED_WIRE_62;
wire	SYNTHESIZED_WIRE_24;
wire	SYNTHESIZED_WIRE_25;
wire	SYNTHESIZED_WIRE_63;
wire	SYNTHESIZED_WIRE_37;
wire	SYNTHESIZED_WIRE_38;
wire	SYNTHESIZED_WIRE_39;
wire	SYNTHESIZED_WIRE_42;
wire	SYNTHESIZED_WIRE_43;
wire	SYNTHESIZED_WIRE_44;
wire	SYNTHESIZED_WIRE_48;
wire	SYNTHESIZED_WIRE_51;




assign	SYNTHESIZED_WIRE_61 =  ~in[0];

assign	SYNTHESIZED_WIRE_58 =  ~in[1];

assign	SYNTHESIZED_WIRE_56 = SYNTHESIZED_WIRE_54 & SYNTHESIZED_WIRE_55;

assign	SYNTHESIZED_WIRE_3 = in[1] | in[0];

assign	SYNTHESIZED_WIRE_5 = SYNTHESIZED_WIRE_56 & SYNTHESIZED_WIRE_3;

assign	HEX0[5] = SYNTHESIZED_WIRE_4 | SYNTHESIZED_WIRE_5 | SYNTHESIZED_WIRE_57;

assign	SYNTHESIZED_WIRE_59 = SYNTHESIZED_WIRE_54 & in[2] & SYNTHESIZED_WIRE_58;

assign	SYNTHESIZED_WIRE_12 = SYNTHESIZED_WIRE_55 & SYNTHESIZED_WIRE_58 & in[0];

assign	SYNTHESIZED_WIRE_13 = SYNTHESIZED_WIRE_54 & in[0];

assign	HEX0[4] = SYNTHESIZED_WIRE_12 | SYNTHESIZED_WIRE_13 | SYNTHESIZED_WIRE_59;

assign	HEX0[3] = SYNTHESIZED_WIRE_60 | SYNTHESIZED_WIRE_16 | SYNTHESIZED_WIRE_17;

assign	SYNTHESIZED_WIRE_16 = SYNTHESIZED_WIRE_18 & SYNTHESIZED_WIRE_61;

assign	SYNTHESIZED_WIRE_55 =  ~in[2];

assign	SYNTHESIZED_WIRE_18 = SYNTHESIZED_WIRE_62 | SYNTHESIZED_WIRE_59;

assign	SYNTHESIZED_WIRE_62 = in[3] & SYNTHESIZED_WIRE_55 & in[1];

assign	SYNTHESIZED_WIRE_63 = in[3] & in[2] & SYNTHESIZED_WIRE_61;

assign	SYNTHESIZED_WIRE_24 = in[3] & in[2] & in[1];

assign	HEX0[2] = SYNTHESIZED_WIRE_24 | SYNTHESIZED_WIRE_25 | SYNTHESIZED_WIRE_63;

assign	SYNTHESIZED_WIRE_25 = SYNTHESIZED_WIRE_56 & in[1] & SYNTHESIZED_WIRE_61;

assign	SYNTHESIZED_WIRE_44 = in[2] & in[1] & SYNTHESIZED_WIRE_61;

assign	SYNTHESIZED_WIRE_42 = in[3] & in[1] & in[0];

assign	SYNTHESIZED_WIRE_43 = SYNTHESIZED_WIRE_59 & in[0];

assign	SYNTHESIZED_WIRE_17 = SYNTHESIZED_WIRE_55 & SYNTHESIZED_WIRE_58 & in[0];

assign	SYNTHESIZED_WIRE_54 =  ~in[3];

assign	SYNTHESIZED_WIRE_37 = in[2] & SYNTHESIZED_WIRE_58 & SYNTHESIZED_WIRE_61;

assign	SYNTHESIZED_WIRE_38 = SYNTHESIZED_WIRE_56 & SYNTHESIZED_WIRE_58 & in[0];

assign	HEX0[0] = SYNTHESIZED_WIRE_37 | SYNTHESIZED_WIRE_38 | SYNTHESIZED_WIRE_39 | SYNTHESIZED_WIRE_57;

assign	HEX0[1] = SYNTHESIZED_WIRE_63 | SYNTHESIZED_WIRE_42 | SYNTHESIZED_WIRE_43 | SYNTHESIZED_WIRE_44;

assign	SYNTHESIZED_WIRE_39 = SYNTHESIZED_WIRE_62 & in[0];

assign	SYNTHESIZED_WIRE_51 = SYNTHESIZED_WIRE_55 & SYNTHESIZED_WIRE_58;

assign	HEX0[6] = SYNTHESIZED_WIRE_48 & SYNTHESIZED_WIRE_54;

assign	SYNTHESIZED_WIRE_60 = in[2] & in[1] & in[0];

assign	SYNTHESIZED_WIRE_48 = SYNTHESIZED_WIRE_60 | SYNTHESIZED_WIRE_51;

assign	SYNTHESIZED_WIRE_57 = in[3] & in[2] & SYNTHESIZED_WIRE_58;

assign	SYNTHESIZED_WIRE_4 = SYNTHESIZED_WIRE_54 & in[1] & in[0];


endmodule
