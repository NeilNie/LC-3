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
	
	// direct input
	address_in_direct,
	data_in_direct,
	clk_direct,
	mem_out_direct,
	
	// debugging
	MAROut,
	memOut
);

// module I/O
input [15:0] Bus, address_in_direct, data_in_direct;
input ldMAR, ldMDR, memWE, clk, clk_direct, reset, selMDR;
output [15:0] MDROut, mem_out_direct;

// internal variables
reg [15:0] MDRIn;
output [15:0] memOut;
output [15:0] MAROut;

//// MDRMux
always @ (Bus or memOut or selMDR) begin
	
	if (selMDR == 1'b1)
		MDRIn <= memOut;
	else if (selMDR == 1'b0)
		MDRIn <= Bus;
end

// declare the two registers
bit_16_register MAR_reg(.D(Bus), .Q(MAROut), .en(ldMAR), .reset(reset), .clk(clk));
bit_16_register MDR_reg(.D(MDRIn), .Q(MDROut), .en(ldMDR), .reset(reset), .clk(clk));

// declare the memory block
two_port_ram	two_port_ram_inst (
	.address_a (MAROut),
	.address_b (address_in_direct),
	.clock_a (clk),
	.clock_b (clk_direct),
	.data_a (MDROut),
	.data_b (data_in_direct),
	.wren_a (memWE),
	.wren_b (memWE),
	.q_a (memOut),
	.q_b (mem_out_direct));

endmodule
