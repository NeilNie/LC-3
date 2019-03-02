//
// Register File for LC-3 Processor
// Neil Nie
// (c) 2019, All Rights Reserved.
//


module RegisterFile(

	Bus, Out0, Out1,
	clk, WE, reset,
	DR, SR0, SR1,
	
	// input, clk, output 2
	clk_r, SR_r, Out_r
);

input [15:0] Bus;
output [15:0] Out0;
output [15:0] Out1;

input clk, WE, reset;
input [2:0] DR;
input [2:0] SR0;
input [2:0] SR1;

// debug read I/O
input clk_r;
input [2:0] SR_r;
output reg [15:0] Out_r;

wire [15:0] reg0_out;
wire [15:0] reg1_out;
wire [15:0] reg2_out;
wire [15:0] reg3_out;
wire [15:0] reg4_out;
wire [15:0] reg5_out;
wire [15:0] reg6_out;
wire [15:0] reg7_out;

// use the 3-8 decoder to get DR select
wire [7:0] DR_sel;
decoder_3_8 decoder(.in(DR), .out(DR_sel));

// declare the 8 registers
bit_16_reg r0(.D(Bus), .Q(reg0_out), .en((WE & DR_sel[0])), .reset(reset), .clk(clk));
bit_16_reg r1(.D(Bus), .Q(reg1_out), .en((WE & DR_sel[1])), .reset(reset), .clk(clk));
bit_16_reg r2(.D(Bus), .Q(reg2_out), .en((WE & DR_sel[2])), .reset(reset), .clk(clk));
bit_16_reg r3(.D(Bus), .Q(reg3_out), .en((WE & DR_sel[3])), .reset(reset), .clk(clk));
bit_16_reg r4(.D(Bus), .Q(reg4_out), .en((WE & DR_sel[4])), .reset(reset), .clk(clk));
bit_16_reg r5(.D(Bus), .Q(reg5_out), .en((WE & DR_sel[5])), .reset(reset), .clk(clk));
bit_16_reg r6(.D(Bus), .Q(reg6_out), .en((WE & DR_sel[6])), .reset(reset), .clk(clk));
bit_16_reg r7(.D(Bus), .Q(reg7_out), .en((WE & DR_sel[7])), .reset(reset), .clk(clk));

// output mux
mux_8_1_bit_16 mux0(	.sel(SR0), 
							.in0(reg0_out), .in1(reg1_out), 
							.in2(reg2_out), .in3(reg3_out), 
							.in4(reg4_out), .in5(reg5_out), 
							.in6(reg6_out), .in7(reg7_out), 
							.out(Out0)); 
							
mux_8_1_bit_16 mux1(	.sel(SR1), 
							.in0(reg0_out), .in1(reg1_out), 
							.in2(reg2_out), .in3(reg3_out), 
							.in4(reg4_out), .in5(reg5_out), 
							.in6(reg6_out), .in7(reg7_out), 
							.out(Out1));
							

always @ (posedge clk_r) begin

	case (SR_r) 
	
		0: Out_r <= reg0_out;
		1: Out_r <= reg1_out;
		2: Out_r <= reg2_out;
		3: Out_r <= reg3_out;
		4: Out_r <= reg4_out;
		5: Out_r <= reg5_out;
		6: Out_r <= reg6_out;
		7: Out_r <= reg7_out;

		default: Out_r <= 16'h0000;
		
	endcase

end	
	
endmodule
