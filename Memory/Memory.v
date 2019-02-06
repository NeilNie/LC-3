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
	clk,
	reset
);

// module I/O
input [15:0] Bus;
input ldMAR, ldMDR, memWE, selMDR, clk, reset;

// internal variables
reg [15:0] MDRIn;
wire [15:0] memOut;
wire [15:0] MAROut;
wire [15:0] MDROut;

// MDRMux
always @ (Bus or memOut) 
	if (selMDR == 1)
		MDRIn <= memOut;
	else 
		MDRIn <= Bus;

// declare the two registers
bit_16_register MAR_reg(.D(Bus), .Q(MAROut), .en(ldMAR), .reset(reset), .clk(clk));
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
