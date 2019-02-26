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
	MAROut,
	memOut,
	MARIn,
	MDRIn,
	
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
output reg [15:0] MDRIn;
output reg [15:0] MARIn;
output [15:0] memOut;
output [15:0] MAROut;


// handle MAR special input 
always @ (*) begin

	if (selMDR == 2'b01)
		MDRIn <= memOut;
	else if (selMDR == 2'b00)
		MDRIn <= Bus;
	else if (selMDR == 2'b11)
		MDRIn <= MDRSpcIn;
	
	if (ldMARSpcIn == 1) begin
		MARIn <= MARSpcIn;
	end else if (ldMAR == 1) begin
		MARIn <= Bus;
	end
		
end

// declare the two registers
bit_16_reg MAR_reg(.D(MARIn), .Q(MAROut), .en(ldMAR), .reset(reset), .clk(clk));
bit_16_reg MDR_reg(.D(MDRIn), .Q(MDROut), .en(ldMDR), .reset(reset), .clk(clk));

// declare the memory block
mem mem_inst (
	.address (MAROut),
	.clock (clk),
	.data (MDROut),
	.wren (memWE),
	.q (memOut)
);

endmodule
