//
// EAB

module EAB(
IR,
Ra,
PC,
selEAB1,
selEAB2,
eabOut
);

input [15:0] Ra, PC;
input [10:0] IR;
input [1:0] selEAB2;
input selEAB1;

output [15:0] eabOut;

endmodule
