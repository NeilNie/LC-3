//
// PC

module PC(
	clk,
	reset,
	ldPC,
	eabOut,
	selPC,
	Bus,
	PCOut
);

// I/O
input [15:0] eabOut, Bus;
input [1:0] selPC;
input clk, reset, ldPC;

output [15:0] PCOut;

// internal variables
reg [15:0] PC_inc, PC;

// the PC register
bit_16_register pc_reg(.D(PC), .Q(PCOut), .en(ldPC), .reset(reset), .clk(clk));

initial begin
	PC <= 16'h3000;
end

always @ (posedge clk) begin
	if (ldPC == 1'b1) begin
		PC_inc = PC + 1;
	end
end
		
always @ (eabOut or Bus or PC_inc or selPC) begin
	
	if (selPC == 2'b00) begin
		PC <= PC_inc;
	end else if (selPC == 2'b01) begin
		PC <= eabOut;
	end else if (selPC == 2'b10) begin
		PC <= Bus;
	end

end

endmodule
