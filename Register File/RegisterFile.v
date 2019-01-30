//
// Register File for LC-3 Processor
// Neil Nie
// (c) 2019, All Rights Reserved.
//


module RegisterFile(
Bus,
Out1,
Out2,

clk, 
WE,
reset,
DR,
SR1,
SR2

);

input [15:0] Bus;
output [15:0] Out1;
output [15:0] Out2;

input clk, WE, reset;
input [2:0] DR;
input [2:0] SR1;
input [2:0] SR2;

Register r0(.D(Bus), .Q(Out1), .en(WE), .reset(reset), .clk(clk));
//Register r1(.D(Bus), .Q(Out1), .en(WE), .reset(reset), .clk(clk));
//Register r2(.D(Bus), .Q(Out1), .en(WE), .reset(reset), .clk(clk));
//Register r3(.D(Bus), .Q(Out1), .en(WE), .reset(reset), .clk(clk));
//Register r4(.D(Bus), .Q(Out1), .en(WE), .reset(reset), .clk(clk));
//Register r5(.D(Bus), .Q(Out1), .en(WE), .reset(reset), .clk(clk));
//Register r6(.D(Bus), .Q(Out1), .en(WE), .reset(reset), .clk(clk));
//Register r7(.D(Bus), .Q(Out1), .en(WE), .reset(reset), .clk(clk));

endmodule
