//
// MARMux
//

module MARMux(
IR,
eabOut,
selMAR,
MARMuxOut
);

input [7:0] IR;
input [15:0] eabOut;
input selMAR;

output [15:0] MARMuxOut;

endmodule
