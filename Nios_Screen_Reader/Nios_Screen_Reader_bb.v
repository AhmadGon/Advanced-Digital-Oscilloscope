
module Nios_Screen_Reader (
	clk_clk,
	clock_bridge_out_clk_clk,
	events_export,
	input_data_export,
	loading_percentage_export,
	output_address_export,
	reset_reset_n,
	response_export,
	sdram_addr,
	sdram_ba,
	sdram_cas_n,
	sdram_cke,
	sdram_cs_n,
	sdram_dq,
	sdram_dqm,
	sdram_ras_n,
	sdram_we_n,
	sdram_clk_clk);	

	input		clk_clk;
	output		clock_bridge_out_clk_clk;
	input	[2:0]	events_export;
	input	[15:0]	input_data_export;
	output	[6:0]	loading_percentage_export;
	output	[19:0]	output_address_export;
	input		reset_reset_n;
	output	[2:0]	response_export;
	output	[12:0]	sdram_addr;
	output	[1:0]	sdram_ba;
	output		sdram_cas_n;
	output		sdram_cke;
	output		sdram_cs_n;
	inout	[31:0]	sdram_dq;
	output	[3:0]	sdram_dqm;
	output		sdram_ras_n;
	output		sdram_we_n;
	output		sdram_clk_clk;
endmodule
