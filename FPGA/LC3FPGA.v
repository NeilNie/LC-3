//
// LC3 FPGA
//
// Neil Nie

module LC3FPGA(HEX0, HEX1, HEX2, HEX3, HEX6, HEX7, LEDR, KEY, SW);

input [2:0] SW;
input [1:0] KEY;

output [6:0] HEX0; 
output [6:0] HEX1;
output [6:0] HEX2;
output [6:0] HEX3;
output [6:0] HEX6;
output [6:0] HEX7;
output [17:0] LEDR;

wire [5:0] current_state;
wire [15:0] IR;
wire [15:0] reg_output;

LC3 processor(

	.clk(~KEY[0]),
	.clk_r(~KEY[1]),
	.SR_r(SW),
	.Out_r(reg_output),
	
	.IR(IR),
//	Bus,
//	PC,
	.current_state(current_state)
//
//	memOut,
//	MAROut,
//	MDROut,
//	MDRIn,
//	
	// direct input
//	address_in_direct,
//	data_in_direct,
//	clk_direct,
//	mem_out_direct
	// ------------------------------
);

assign LEDR[15:0] = IR;
assign LEDR[17] = KEY[0];

SevenSegmentDecoder disp1(.SW(reg_output[3:0]),		.HEX0(HEX0));
SevenSegmentDecoder disp2(.SW(reg_output[7:4]),		.HEX0(HEX1));
SevenSegmentDecoder disp3(.SW(reg_output[11:8]),	.HEX0(HEX2));
SevenSegmentDecoder disp4(.SW(reg_output[15:12]),	.HEX0(HEX3));

SevenSegmentDecoder state_disp1(.SW(current_state[3:0]),	.HEX0(HEX6));
SevenSegmentDecoder state_disp2(.SW({2'b00, current_state[5:4]}),	.HEX0(HEX7));

endmodule
