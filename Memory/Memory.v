//
// Memory
// (c) Neil Nie, 2019
//

module Memory(
	Bus,
	ldMAR,
	ldMDR,
	memWE,
	selMDR,
	MDROut,
	clk,
	reset,
	
	// memory special inputs
	MDRSpcIn,
	MARSpcIn,
	ldMARSpcIn
);

// module I/O
input [15:0] Bus, MARSpcIn, MDRSpcIn;
input ldMAR, ldMDR, ldMARSpcIn, memWE, clk, reset;
input [1:0] selMDR;
output [15:0] MDROut;

// internal variables
reg [15:0] MDRIn;
reg [15:0] MARIn;
wire [15:0] memOut;
wire [15:0] MAROut;

// MDRMux
always @ (Bus or memOut or MDRSpcIn) begin
	
	if (selMDR == 2'b01)
		MDRIn <= memOut;
	else if (selMDR == 2'b00)
		MDRIn <= Bus;
	else if (selMDR == 2'b11)
		MDRIn <= MDRSpcIn;
end

// handle MAR special input
always @ (ldMARSpcIn or MARSpcIn or Bus) begin
	
	if (ldMARSpcIn == 1) begin
		MARIn <= MARSpcIn;
	end else begin
		MARIn <= Bus;
	end

end

// declare the two registers
bit_16_register MAR_reg(.D(MARIn), .Q(MAROut), .en(ldMAR), .reset(reset), .clk(clk));
bit_16_register MDR_reg(.D(MDRIn), .Q(MDROut), .en(ldMDR), .reset(reset), .clk(clk));

// declare the memory block
mem mem_inst (
	.address (MAROut),
	.clock (clk),
	.data (MDROut),
	.wren (memWE),
	.q (memOut)
);

endmodule
