//
// LC3 FPGA
//
// Neil Nie

module LC3FPGA(

	HEX0, HEX1, HEX2, HEX3, HEX6, HEX7, 
	LEDR, KEY, SW
);

input [17:0] SW;
input [2:0] KEY;

output [6:0] HEX0; 
output [6:0] HEX1;
output [6:0] HEX2;
output [6:0] HEX3;
output [6:0] HEX6;
output [6:0] HEX7;
output [17:0] LEDR;

// internal wires
wire [5:0] current_state;
wire [15:0] IR;
wire [15:0] reg_output;

reg [15:0] HEX0_out;
reg [15:0] HEX1_out;
reg [15:0] HEX2_out;
reg [15:0] HEX3_out;

wire [15:0] disp0_wire;
wire [15:0] disp1_wire;
wire [15:0] disp2_wire;
wire [15:0] disp3_wire;
wire [15:0] disp4_wire;
wire [15:0] disp5_wire;
wire [15:0] disp6_wire;
wire [15:0] disp7_wire;

wire [15:0] mem_out;

LC3 processor(

	.clk(~KEY[0]),
	.clk_r(~KEY[1]),
	.SR_r(SW),
	.Out_r(reg_output),
	
	.IR(IR),
	
	.current_state(current_state),
	.address_in_direct(SW[15:0]),
	.clk_direct(~KEY[2]),
	.mem_out_direct(mem_out)
	// .data_in_direct(),
	//	PC,
);

assign LEDR[15:0] = IR;
assign LEDR[17] = ~KEY[0];

// seven segment display reg
SevenSegmentDecoder disp1(.in(reg_output[3:0]),		.HEX0(disp0_wire));
SevenSegmentDecoder disp2(.in(reg_output[7:4]),		.HEX0(disp1_wire));
SevenSegmentDecoder disp3(.in(reg_output[11:8]),	.HEX0(disp2_wire));
SevenSegmentDecoder disp4(.in(reg_output[15:12]),	.HEX0(disp3_wire));

// seven segment display mem
SevenSegmentDecoder disp5(.in(mem_out[3:0]),			.HEX0(disp4_wire));
SevenSegmentDecoder disp6(.in(mem_out[7:4]),			.HEX0(disp5_wire));
SevenSegmentDecoder disp7(.in(mem_out[11:8]),		.HEX0(disp6_wire));
SevenSegmentDecoder disp8(.in(mem_out[15:12]),		.HEX0(disp7_wire));

SevenSegmentDecoder state_disp1(.in(current_state[3:0]),	.HEX0(HEX6));
SevenSegmentDecoder state_disp2(.in((4'b0000 + current_state[5:4])),	.HEX0(HEX7));

// HEX display output
always @ (SW) begin

	if (SW[17] == 1) begin
	
		HEX0_out <= disp0_wire;
		HEX1_out <= disp1_wire;
		HEX2_out <= disp2_wire;
		HEX3_out <= disp3_wire;
		
	end else begin
		
		HEX0_out <= disp4_wire;
		HEX1_out <= disp5_wire;
		HEX2_out <= disp6_wire;
		HEX3_out <= disp7_wire;
	
	end

end

assign HEX0 = HEX0_out;
assign HEX1 = HEX1_out;
assign HEX2 = HEX2_out;
assign HEX3 = HEX3_out;

endmodule
