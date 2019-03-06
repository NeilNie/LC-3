
module clock_1hz(clk, out);

input clk;
output out;

// generate 1 Hz from 50 MHz
reg [25:0] count_reg = 0;
reg out_1hz = 0;

always @(posedge clk) begin
    
	 if (count_reg < 25000000) begin
        count_reg <= count_reg + 1;
    end else begin
        count_reg <= 0;
        out_1hz <= ~out_1hz;
    end
end

assign out = out_1hz;

endmodule
