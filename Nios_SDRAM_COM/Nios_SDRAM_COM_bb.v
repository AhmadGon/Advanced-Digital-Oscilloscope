
module Nios_SDRAM_COM (
	clk_clk,
	events_export,
	input_data_export,
	output_address_export,
	reset_reset_n,
	clock_bridge_out_clk_clk);	

	input		clk_clk;
	input	[2:0]	events_export;
	input	[15:0]	input_data_export;
	output	[19:0]	output_address_export;
	input		reset_reset_n;
	output		clock_bridge_out_clk_clk;
endmodule
