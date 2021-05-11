	Nios_Screen_Reader u0 (
		.clk_clk                   (<connected-to-clk_clk>),                   //                  clk.clk
		.clock_bridge_out_clk_clk  (<connected-to-clock_bridge_out_clk_clk>),  // clock_bridge_out_clk.clk
		.events_export             (<connected-to-events_export>),             //               events.export
		.input_data_export         (<connected-to-input_data_export>),         //           input_data.export
		.loading_percentage_export (<connected-to-loading_percentage_export>), //   loading_percentage.export
		.output_address_export     (<connected-to-output_address_export>),     //       output_address.export
		.reset_reset_n             (<connected-to-reset_reset_n>),             //                reset.reset_n
		.response_export           (<connected-to-response_export>),           //             response.export
		.sdram_addr                (<connected-to-sdram_addr>),                //                sdram.addr
		.sdram_ba                  (<connected-to-sdram_ba>),                  //                     .ba
		.sdram_cas_n               (<connected-to-sdram_cas_n>),               //                     .cas_n
		.sdram_cke                 (<connected-to-sdram_cke>),                 //                     .cke
		.sdram_cs_n                (<connected-to-sdram_cs_n>),                //                     .cs_n
		.sdram_dq                  (<connected-to-sdram_dq>),                  //                     .dq
		.sdram_dqm                 (<connected-to-sdram_dqm>),                 //                     .dqm
		.sdram_ras_n               (<connected-to-sdram_ras_n>),               //                     .ras_n
		.sdram_we_n                (<connected-to-sdram_we_n>),                //                     .we_n
		.sdram_clk_clk             (<connected-to-sdram_clk_clk>)              //            sdram_clk.clk
	);

