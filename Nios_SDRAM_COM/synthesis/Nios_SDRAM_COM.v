// Nios_SDRAM_COM.v

// Generated using ACDS version 18.0 614

`timescale 1 ps / 1 ps
module Nios_SDRAM_COM (
		input  wire        clk_clk,                  //                  clk.clk
		output wire        clock_bridge_out_clk_clk, // clock_bridge_out_clk.clk
		input  wire [2:0]  events_export,            //               events.export
		input  wire [15:0] input_data_export,        //           input_data.export
		output wire [19:0] output_address_export,    //       output_address.export
		input  wire        reset_reset_n             //                reset.reset_n
	);

	wire  [31:0] niosii_data_master_readdata;                          // mm_interconnect_0:NiosII_data_master_readdata -> NiosII:d_readdata
	wire         niosii_data_master_waitrequest;                       // mm_interconnect_0:NiosII_data_master_waitrequest -> NiosII:d_waitrequest
	wire         niosii_data_master_debugaccess;                       // NiosII:debug_mem_slave_debugaccess_to_roms -> mm_interconnect_0:NiosII_data_master_debugaccess
	wire  [18:0] niosii_data_master_address;                           // NiosII:d_address -> mm_interconnect_0:NiosII_data_master_address
	wire   [3:0] niosii_data_master_byteenable;                        // NiosII:d_byteenable -> mm_interconnect_0:NiosII_data_master_byteenable
	wire         niosii_data_master_read;                              // NiosII:d_read -> mm_interconnect_0:NiosII_data_master_read
	wire         niosii_data_master_readdatavalid;                     // mm_interconnect_0:NiosII_data_master_readdatavalid -> NiosII:d_readdatavalid
	wire         niosii_data_master_write;                             // NiosII:d_write -> mm_interconnect_0:NiosII_data_master_write
	wire  [31:0] niosii_data_master_writedata;                         // NiosII:d_writedata -> mm_interconnect_0:NiosII_data_master_writedata
	wire  [31:0] niosii_instruction_master_readdata;                   // mm_interconnect_0:NiosII_instruction_master_readdata -> NiosII:i_readdata
	wire         niosii_instruction_master_waitrequest;                // mm_interconnect_0:NiosII_instruction_master_waitrequest -> NiosII:i_waitrequest
	wire  [18:0] niosii_instruction_master_address;                    // NiosII:i_address -> mm_interconnect_0:NiosII_instruction_master_address
	wire         niosii_instruction_master_read;                       // NiosII:i_read -> mm_interconnect_0:NiosII_instruction_master_read
	wire         niosii_instruction_master_readdatavalid;              // mm_interconnect_0:NiosII_instruction_master_readdatavalid -> NiosII:i_readdatavalid
	wire         mm_interconnect_0_jtag_avalon_jtag_slave_chipselect;  // mm_interconnect_0:JTAG_avalon_jtag_slave_chipselect -> JTAG:av_chipselect
	wire  [31:0] mm_interconnect_0_jtag_avalon_jtag_slave_readdata;    // JTAG:av_readdata -> mm_interconnect_0:JTAG_avalon_jtag_slave_readdata
	wire         mm_interconnect_0_jtag_avalon_jtag_slave_waitrequest; // JTAG:av_waitrequest -> mm_interconnect_0:JTAG_avalon_jtag_slave_waitrequest
	wire   [0:0] mm_interconnect_0_jtag_avalon_jtag_slave_address;     // mm_interconnect_0:JTAG_avalon_jtag_slave_address -> JTAG:av_address
	wire         mm_interconnect_0_jtag_avalon_jtag_slave_read;        // mm_interconnect_0:JTAG_avalon_jtag_slave_read -> JTAG:av_read_n
	wire         mm_interconnect_0_jtag_avalon_jtag_slave_write;       // mm_interconnect_0:JTAG_avalon_jtag_slave_write -> JTAG:av_write_n
	wire  [31:0] mm_interconnect_0_jtag_avalon_jtag_slave_writedata;   // mm_interconnect_0:JTAG_avalon_jtag_slave_writedata -> JTAG:av_writedata
	wire  [31:0] mm_interconnect_0_systemid_control_slave_readdata;    // SystemID:readdata -> mm_interconnect_0:SystemID_control_slave_readdata
	wire   [0:0] mm_interconnect_0_systemid_control_slave_address;     // mm_interconnect_0:SystemID_control_slave_address -> SystemID:address
	wire  [31:0] mm_interconnect_0_niosii_debug_mem_slave_readdata;    // NiosII:debug_mem_slave_readdata -> mm_interconnect_0:NiosII_debug_mem_slave_readdata
	wire         mm_interconnect_0_niosii_debug_mem_slave_waitrequest; // NiosII:debug_mem_slave_waitrequest -> mm_interconnect_0:NiosII_debug_mem_slave_waitrequest
	wire         mm_interconnect_0_niosii_debug_mem_slave_debugaccess; // mm_interconnect_0:NiosII_debug_mem_slave_debugaccess -> NiosII:debug_mem_slave_debugaccess
	wire   [8:0] mm_interconnect_0_niosii_debug_mem_slave_address;     // mm_interconnect_0:NiosII_debug_mem_slave_address -> NiosII:debug_mem_slave_address
	wire         mm_interconnect_0_niosii_debug_mem_slave_read;        // mm_interconnect_0:NiosII_debug_mem_slave_read -> NiosII:debug_mem_slave_read
	wire   [3:0] mm_interconnect_0_niosii_debug_mem_slave_byteenable;  // mm_interconnect_0:NiosII_debug_mem_slave_byteenable -> NiosII:debug_mem_slave_byteenable
	wire         mm_interconnect_0_niosii_debug_mem_slave_write;       // mm_interconnect_0:NiosII_debug_mem_slave_write -> NiosII:debug_mem_slave_write
	wire  [31:0] mm_interconnect_0_niosii_debug_mem_slave_writedata;   // mm_interconnect_0:NiosII_debug_mem_slave_writedata -> NiosII:debug_mem_slave_writedata
	wire  [31:0] mm_interconnect_0_pll_pll_slave_readdata;             // PLL:readdata -> mm_interconnect_0:PLL_pll_slave_readdata
	wire   [1:0] mm_interconnect_0_pll_pll_slave_address;              // mm_interconnect_0:PLL_pll_slave_address -> PLL:address
	wire         mm_interconnect_0_pll_pll_slave_read;                 // mm_interconnect_0:PLL_pll_slave_read -> PLL:read
	wire         mm_interconnect_0_pll_pll_slave_write;                // mm_interconnect_0:PLL_pll_slave_write -> PLL:write
	wire  [31:0] mm_interconnect_0_pll_pll_slave_writedata;            // mm_interconnect_0:PLL_pll_slave_writedata -> PLL:writedata
	wire         mm_interconnect_0_onchip_memory_s1_chipselect;        // mm_interconnect_0:OnChip_memory_s1_chipselect -> OnChip_memory:chipselect
	wire  [31:0] mm_interconnect_0_onchip_memory_s1_readdata;          // OnChip_memory:readdata -> mm_interconnect_0:OnChip_memory_s1_readdata
	wire  [14:0] mm_interconnect_0_onchip_memory_s1_address;           // mm_interconnect_0:OnChip_memory_s1_address -> OnChip_memory:address
	wire   [3:0] mm_interconnect_0_onchip_memory_s1_byteenable;        // mm_interconnect_0:OnChip_memory_s1_byteenable -> OnChip_memory:byteenable
	wire         mm_interconnect_0_onchip_memory_s1_write;             // mm_interconnect_0:OnChip_memory_s1_write -> OnChip_memory:write
	wire  [31:0] mm_interconnect_0_onchip_memory_s1_writedata;         // mm_interconnect_0:OnChip_memory_s1_writedata -> OnChip_memory:writedata
	wire         mm_interconnect_0_onchip_memory_s1_clken;             // mm_interconnect_0:OnChip_memory_s1_clken -> OnChip_memory:clken
	wire  [31:0] mm_interconnect_0_data_s1_readdata;                   // DATA:readdata -> mm_interconnect_0:DATA_s1_readdata
	wire   [1:0] mm_interconnect_0_data_s1_address;                    // mm_interconnect_0:DATA_s1_address -> DATA:address
	wire         mm_interconnect_0_address_s1_chipselect;              // mm_interconnect_0:Address_s1_chipselect -> Address:chipselect
	wire  [31:0] mm_interconnect_0_address_s1_readdata;                // Address:readdata -> mm_interconnect_0:Address_s1_readdata
	wire   [1:0] mm_interconnect_0_address_s1_address;                 // mm_interconnect_0:Address_s1_address -> Address:address
	wire         mm_interconnect_0_address_s1_write;                   // mm_interconnect_0:Address_s1_write -> Address:write_n
	wire  [31:0] mm_interconnect_0_address_s1_writedata;               // mm_interconnect_0:Address_s1_writedata -> Address:writedata
	wire  [31:0] mm_interconnect_0_event_register_s1_readdata;         // Event_Register:readdata -> mm_interconnect_0:Event_Register_s1_readdata
	wire   [1:0] mm_interconnect_0_event_register_s1_address;          // mm_interconnect_0:Event_Register_s1_address -> Event_Register:address
	wire         irq_mapper_receiver0_irq;                             // JTAG:av_irq -> irq_mapper:receiver0_irq
	wire  [31:0] niosii_irq_irq;                                       // irq_mapper:sender_irq -> NiosII:irq
	wire         rst_controller_reset_out_reset;                       // rst_controller:reset_out -> [Address:reset_n, DATA:reset_n, Event_Register:reset_n, JTAG:rst_n, NiosII:reset_n, OnChip_memory:reset, SystemID:reset_n, irq_mapper:reset, mm_interconnect_0:NiosII_reset_reset_bridge_in_reset_reset, rst_translator:in_reset]
	wire         rst_controller_reset_out_reset_req;                   // rst_controller:reset_req -> [NiosII:reset_req, OnChip_memory:reset_req, rst_translator:reset_req_in]
	wire         niosii_debug_reset_request_reset;                     // NiosII:debug_reset_request -> [rst_controller:reset_in1, rst_controller_001:reset_in1]
	wire         rst_controller_001_reset_out_reset;                   // rst_controller_001:reset_out -> [PLL:reset, mm_interconnect_0:PLL_inclk_interface_reset_reset_bridge_in_reset_reset]

	Nios_SDRAM_COM_Address address (
		.clk        (clock_bridge_out_clk_clk),                //                 clk.clk
		.reset_n    (~rst_controller_reset_out_reset),         //               reset.reset_n
		.address    (mm_interconnect_0_address_s1_address),    //                  s1.address
		.write_n    (~mm_interconnect_0_address_s1_write),     //                    .write_n
		.writedata  (mm_interconnect_0_address_s1_writedata),  //                    .writedata
		.chipselect (mm_interconnect_0_address_s1_chipselect), //                    .chipselect
		.readdata   (mm_interconnect_0_address_s1_readdata),   //                    .readdata
		.out_port   (output_address_export)                    // external_connection.export
	);

	Nios_SDRAM_COM_DATA data (
		.clk      (clock_bridge_out_clk_clk),           //                 clk.clk
		.reset_n  (~rst_controller_reset_out_reset),    //               reset.reset_n
		.address  (mm_interconnect_0_data_s1_address),  //                  s1.address
		.readdata (mm_interconnect_0_data_s1_readdata), //                    .readdata
		.in_port  (input_data_export)                   // external_connection.export
	);

	Nios_SDRAM_COM_Event_Register event_register (
		.clk      (clock_bridge_out_clk_clk),                     //                 clk.clk
		.reset_n  (~rst_controller_reset_out_reset),              //               reset.reset_n
		.address  (mm_interconnect_0_event_register_s1_address),  //                  s1.address
		.readdata (mm_interconnect_0_event_register_s1_readdata), //                    .readdata
		.in_port  (events_export)                                 // external_connection.export
	);

	Nios_SDRAM_COM_JTAG jtag (
		.clk            (clock_bridge_out_clk_clk),                             //               clk.clk
		.rst_n          (~rst_controller_reset_out_reset),                      //             reset.reset_n
		.av_chipselect  (mm_interconnect_0_jtag_avalon_jtag_slave_chipselect),  // avalon_jtag_slave.chipselect
		.av_address     (mm_interconnect_0_jtag_avalon_jtag_slave_address),     //                  .address
		.av_read_n      (~mm_interconnect_0_jtag_avalon_jtag_slave_read),       //                  .read_n
		.av_readdata    (mm_interconnect_0_jtag_avalon_jtag_slave_readdata),    //                  .readdata
		.av_write_n     (~mm_interconnect_0_jtag_avalon_jtag_slave_write),      //                  .write_n
		.av_writedata   (mm_interconnect_0_jtag_avalon_jtag_slave_writedata),   //                  .writedata
		.av_waitrequest (mm_interconnect_0_jtag_avalon_jtag_slave_waitrequest), //                  .waitrequest
		.av_irq         (irq_mapper_receiver0_irq)                              //               irq.irq
	);

	Nios_SDRAM_COM_NiosII niosii (
		.clk                                 (clock_bridge_out_clk_clk),                             //                       clk.clk
		.reset_n                             (~rst_controller_reset_out_reset),                      //                     reset.reset_n
		.reset_req                           (rst_controller_reset_out_reset_req),                   //                          .reset_req
		.d_address                           (niosii_data_master_address),                           //               data_master.address
		.d_byteenable                        (niosii_data_master_byteenable),                        //                          .byteenable
		.d_read                              (niosii_data_master_read),                              //                          .read
		.d_readdata                          (niosii_data_master_readdata),                          //                          .readdata
		.d_waitrequest                       (niosii_data_master_waitrequest),                       //                          .waitrequest
		.d_write                             (niosii_data_master_write),                             //                          .write
		.d_writedata                         (niosii_data_master_writedata),                         //                          .writedata
		.d_readdatavalid                     (niosii_data_master_readdatavalid),                     //                          .readdatavalid
		.debug_mem_slave_debugaccess_to_roms (niosii_data_master_debugaccess),                       //                          .debugaccess
		.i_address                           (niosii_instruction_master_address),                    //        instruction_master.address
		.i_read                              (niosii_instruction_master_read),                       //                          .read
		.i_readdata                          (niosii_instruction_master_readdata),                   //                          .readdata
		.i_waitrequest                       (niosii_instruction_master_waitrequest),                //                          .waitrequest
		.i_readdatavalid                     (niosii_instruction_master_readdatavalid),              //                          .readdatavalid
		.irq                                 (niosii_irq_irq),                                       //                       irq.irq
		.debug_reset_request                 (niosii_debug_reset_request_reset),                     //       debug_reset_request.reset
		.debug_mem_slave_address             (mm_interconnect_0_niosii_debug_mem_slave_address),     //           debug_mem_slave.address
		.debug_mem_slave_byteenable          (mm_interconnect_0_niosii_debug_mem_slave_byteenable),  //                          .byteenable
		.debug_mem_slave_debugaccess         (mm_interconnect_0_niosii_debug_mem_slave_debugaccess), //                          .debugaccess
		.debug_mem_slave_read                (mm_interconnect_0_niosii_debug_mem_slave_read),        //                          .read
		.debug_mem_slave_readdata            (mm_interconnect_0_niosii_debug_mem_slave_readdata),    //                          .readdata
		.debug_mem_slave_waitrequest         (mm_interconnect_0_niosii_debug_mem_slave_waitrequest), //                          .waitrequest
		.debug_mem_slave_write               (mm_interconnect_0_niosii_debug_mem_slave_write),       //                          .write
		.debug_mem_slave_writedata           (mm_interconnect_0_niosii_debug_mem_slave_writedata),   //                          .writedata
		.dummy_ci_port                       ()                                                      // custom_instruction_master.readra
	);

	Nios_SDRAM_COM_OnChip_memory onchip_memory (
		.clk        (clock_bridge_out_clk_clk),                      //   clk1.clk
		.address    (mm_interconnect_0_onchip_memory_s1_address),    //     s1.address
		.clken      (mm_interconnect_0_onchip_memory_s1_clken),      //       .clken
		.chipselect (mm_interconnect_0_onchip_memory_s1_chipselect), //       .chipselect
		.write      (mm_interconnect_0_onchip_memory_s1_write),      //       .write
		.readdata   (mm_interconnect_0_onchip_memory_s1_readdata),   //       .readdata
		.writedata  (mm_interconnect_0_onchip_memory_s1_writedata),  //       .writedata
		.byteenable (mm_interconnect_0_onchip_memory_s1_byteenable), //       .byteenable
		.reset      (rst_controller_reset_out_reset),                // reset1.reset
		.reset_req  (rst_controller_reset_out_reset_req),            //       .reset_req
		.freeze     (1'b0)                                           // (terminated)
	);

	Nios_SDRAM_COM_PLL pll (
		.clk                (clk_clk),                                   //       inclk_interface.clk
		.reset              (rst_controller_001_reset_out_reset),        // inclk_interface_reset.reset
		.read               (mm_interconnect_0_pll_pll_slave_read),      //             pll_slave.read
		.write              (mm_interconnect_0_pll_pll_slave_write),     //                      .write
		.address            (mm_interconnect_0_pll_pll_slave_address),   //                      .address
		.readdata           (mm_interconnect_0_pll_pll_slave_readdata),  //                      .readdata
		.writedata          (mm_interconnect_0_pll_pll_slave_writedata), //                      .writedata
		.c0                 (clock_bridge_out_clk_clk),                  //                    c0.clk
		.scandone           (),                                          //           (terminated)
		.scandataout        (),                                          //           (terminated)
		.areset             (1'b0),                                      //           (terminated)
		.locked             (),                                          //           (terminated)
		.phasedone          (),                                          //           (terminated)
		.phasecounterselect (4'b0000),                                   //           (terminated)
		.phaseupdown        (1'b0),                                      //           (terminated)
		.phasestep          (1'b0),                                      //           (terminated)
		.scanclk            (1'b0),                                      //           (terminated)
		.scanclkena         (1'b0),                                      //           (terminated)
		.scandata           (1'b0),                                      //           (terminated)
		.configupdate       (1'b0)                                       //           (terminated)
	);

	Nios_SDRAM_COM_SystemID systemid (
		.clock    (clock_bridge_out_clk_clk),                          //           clk.clk
		.reset_n  (~rst_controller_reset_out_reset),                   //         reset.reset_n
		.readdata (mm_interconnect_0_systemid_control_slave_readdata), // control_slave.readdata
		.address  (mm_interconnect_0_systemid_control_slave_address)   //              .address
	);

	Nios_SDRAM_COM_mm_interconnect_0 mm_interconnect_0 (
		.clk_0_clk_clk                                         (clk_clk),                                              //                                       clk_0_clk.clk
		.PLL_c0_clk                                            (clock_bridge_out_clk_clk),                             //                                          PLL_c0.clk
		.NiosII_reset_reset_bridge_in_reset_reset              (rst_controller_reset_out_reset),                       //              NiosII_reset_reset_bridge_in_reset.reset
		.PLL_inclk_interface_reset_reset_bridge_in_reset_reset (rst_controller_001_reset_out_reset),                   // PLL_inclk_interface_reset_reset_bridge_in_reset.reset
		.NiosII_data_master_address                            (niosii_data_master_address),                           //                              NiosII_data_master.address
		.NiosII_data_master_waitrequest                        (niosii_data_master_waitrequest),                       //                                                .waitrequest
		.NiosII_data_master_byteenable                         (niosii_data_master_byteenable),                        //                                                .byteenable
		.NiosII_data_master_read                               (niosii_data_master_read),                              //                                                .read
		.NiosII_data_master_readdata                           (niosii_data_master_readdata),                          //                                                .readdata
		.NiosII_data_master_readdatavalid                      (niosii_data_master_readdatavalid),                     //                                                .readdatavalid
		.NiosII_data_master_write                              (niosii_data_master_write),                             //                                                .write
		.NiosII_data_master_writedata                          (niosii_data_master_writedata),                         //                                                .writedata
		.NiosII_data_master_debugaccess                        (niosii_data_master_debugaccess),                       //                                                .debugaccess
		.NiosII_instruction_master_address                     (niosii_instruction_master_address),                    //                       NiosII_instruction_master.address
		.NiosII_instruction_master_waitrequest                 (niosii_instruction_master_waitrequest),                //                                                .waitrequest
		.NiosII_instruction_master_read                        (niosii_instruction_master_read),                       //                                                .read
		.NiosII_instruction_master_readdata                    (niosii_instruction_master_readdata),                   //                                                .readdata
		.NiosII_instruction_master_readdatavalid               (niosii_instruction_master_readdatavalid),              //                                                .readdatavalid
		.Address_s1_address                                    (mm_interconnect_0_address_s1_address),                 //                                      Address_s1.address
		.Address_s1_write                                      (mm_interconnect_0_address_s1_write),                   //                                                .write
		.Address_s1_readdata                                   (mm_interconnect_0_address_s1_readdata),                //                                                .readdata
		.Address_s1_writedata                                  (mm_interconnect_0_address_s1_writedata),               //                                                .writedata
		.Address_s1_chipselect                                 (mm_interconnect_0_address_s1_chipselect),              //                                                .chipselect
		.DATA_s1_address                                       (mm_interconnect_0_data_s1_address),                    //                                         DATA_s1.address
		.DATA_s1_readdata                                      (mm_interconnect_0_data_s1_readdata),                   //                                                .readdata
		.Event_Register_s1_address                             (mm_interconnect_0_event_register_s1_address),          //                               Event_Register_s1.address
		.Event_Register_s1_readdata                            (mm_interconnect_0_event_register_s1_readdata),         //                                                .readdata
		.JTAG_avalon_jtag_slave_address                        (mm_interconnect_0_jtag_avalon_jtag_slave_address),     //                          JTAG_avalon_jtag_slave.address
		.JTAG_avalon_jtag_slave_write                          (mm_interconnect_0_jtag_avalon_jtag_slave_write),       //                                                .write
		.JTAG_avalon_jtag_slave_read                           (mm_interconnect_0_jtag_avalon_jtag_slave_read),        //                                                .read
		.JTAG_avalon_jtag_slave_readdata                       (mm_interconnect_0_jtag_avalon_jtag_slave_readdata),    //                                                .readdata
		.JTAG_avalon_jtag_slave_writedata                      (mm_interconnect_0_jtag_avalon_jtag_slave_writedata),   //                                                .writedata
		.JTAG_avalon_jtag_slave_waitrequest                    (mm_interconnect_0_jtag_avalon_jtag_slave_waitrequest), //                                                .waitrequest
		.JTAG_avalon_jtag_slave_chipselect                     (mm_interconnect_0_jtag_avalon_jtag_slave_chipselect),  //                                                .chipselect
		.NiosII_debug_mem_slave_address                        (mm_interconnect_0_niosii_debug_mem_slave_address),     //                          NiosII_debug_mem_slave.address
		.NiosII_debug_mem_slave_write                          (mm_interconnect_0_niosii_debug_mem_slave_write),       //                                                .write
		.NiosII_debug_mem_slave_read                           (mm_interconnect_0_niosii_debug_mem_slave_read),        //                                                .read
		.NiosII_debug_mem_slave_readdata                       (mm_interconnect_0_niosii_debug_mem_slave_readdata),    //                                                .readdata
		.NiosII_debug_mem_slave_writedata                      (mm_interconnect_0_niosii_debug_mem_slave_writedata),   //                                                .writedata
		.NiosII_debug_mem_slave_byteenable                     (mm_interconnect_0_niosii_debug_mem_slave_byteenable),  //                                                .byteenable
		.NiosII_debug_mem_slave_waitrequest                    (mm_interconnect_0_niosii_debug_mem_slave_waitrequest), //                                                .waitrequest
		.NiosII_debug_mem_slave_debugaccess                    (mm_interconnect_0_niosii_debug_mem_slave_debugaccess), //                                                .debugaccess
		.OnChip_memory_s1_address                              (mm_interconnect_0_onchip_memory_s1_address),           //                                OnChip_memory_s1.address
		.OnChip_memory_s1_write                                (mm_interconnect_0_onchip_memory_s1_write),             //                                                .write
		.OnChip_memory_s1_readdata                             (mm_interconnect_0_onchip_memory_s1_readdata),          //                                                .readdata
		.OnChip_memory_s1_writedata                            (mm_interconnect_0_onchip_memory_s1_writedata),         //                                                .writedata
		.OnChip_memory_s1_byteenable                           (mm_interconnect_0_onchip_memory_s1_byteenable),        //                                                .byteenable
		.OnChip_memory_s1_chipselect                           (mm_interconnect_0_onchip_memory_s1_chipselect),        //                                                .chipselect
		.OnChip_memory_s1_clken                                (mm_interconnect_0_onchip_memory_s1_clken),             //                                                .clken
		.PLL_pll_slave_address                                 (mm_interconnect_0_pll_pll_slave_address),              //                                   PLL_pll_slave.address
		.PLL_pll_slave_write                                   (mm_interconnect_0_pll_pll_slave_write),                //                                                .write
		.PLL_pll_slave_read                                    (mm_interconnect_0_pll_pll_slave_read),                 //                                                .read
		.PLL_pll_slave_readdata                                (mm_interconnect_0_pll_pll_slave_readdata),             //                                                .readdata
		.PLL_pll_slave_writedata                               (mm_interconnect_0_pll_pll_slave_writedata),            //                                                .writedata
		.SystemID_control_slave_address                        (mm_interconnect_0_systemid_control_slave_address),     //                          SystemID_control_slave.address
		.SystemID_control_slave_readdata                       (mm_interconnect_0_systemid_control_slave_readdata)     //                                                .readdata
	);

	Nios_SDRAM_COM_irq_mapper irq_mapper (
		.clk           (clock_bridge_out_clk_clk),       //       clk.clk
		.reset         (rst_controller_reset_out_reset), // clk_reset.reset
		.receiver0_irq (irq_mapper_receiver0_irq),       // receiver0.irq
		.sender_irq    (niosii_irq_irq)                  //    sender.irq
	);

	altera_reset_controller #(
		.NUM_RESET_INPUTS          (2),
		.OUTPUT_RESET_SYNC_EDGES   ("deassert"),
		.SYNC_DEPTH                (2),
		.RESET_REQUEST_PRESENT     (1),
		.RESET_REQ_WAIT_TIME       (1),
		.MIN_RST_ASSERTION_TIME    (3),
		.RESET_REQ_EARLY_DSRT_TIME (1),
		.USE_RESET_REQUEST_IN0     (0),
		.USE_RESET_REQUEST_IN1     (0),
		.USE_RESET_REQUEST_IN2     (0),
		.USE_RESET_REQUEST_IN3     (0),
		.USE_RESET_REQUEST_IN4     (0),
		.USE_RESET_REQUEST_IN5     (0),
		.USE_RESET_REQUEST_IN6     (0),
		.USE_RESET_REQUEST_IN7     (0),
		.USE_RESET_REQUEST_IN8     (0),
		.USE_RESET_REQUEST_IN9     (0),
		.USE_RESET_REQUEST_IN10    (0),
		.USE_RESET_REQUEST_IN11    (0),
		.USE_RESET_REQUEST_IN12    (0),
		.USE_RESET_REQUEST_IN13    (0),
		.USE_RESET_REQUEST_IN14    (0),
		.USE_RESET_REQUEST_IN15    (0),
		.ADAPT_RESET_REQUEST       (0)
	) rst_controller (
		.reset_in0      (~reset_reset_n),                     // reset_in0.reset
		.reset_in1      (niosii_debug_reset_request_reset),   // reset_in1.reset
		.clk            (clock_bridge_out_clk_clk),           //       clk.clk
		.reset_out      (rst_controller_reset_out_reset),     // reset_out.reset
		.reset_req      (rst_controller_reset_out_reset_req), //          .reset_req
		.reset_req_in0  (1'b0),                               // (terminated)
		.reset_req_in1  (1'b0),                               // (terminated)
		.reset_in2      (1'b0),                               // (terminated)
		.reset_req_in2  (1'b0),                               // (terminated)
		.reset_in3      (1'b0),                               // (terminated)
		.reset_req_in3  (1'b0),                               // (terminated)
		.reset_in4      (1'b0),                               // (terminated)
		.reset_req_in4  (1'b0),                               // (terminated)
		.reset_in5      (1'b0),                               // (terminated)
		.reset_req_in5  (1'b0),                               // (terminated)
		.reset_in6      (1'b0),                               // (terminated)
		.reset_req_in6  (1'b0),                               // (terminated)
		.reset_in7      (1'b0),                               // (terminated)
		.reset_req_in7  (1'b0),                               // (terminated)
		.reset_in8      (1'b0),                               // (terminated)
		.reset_req_in8  (1'b0),                               // (terminated)
		.reset_in9      (1'b0),                               // (terminated)
		.reset_req_in9  (1'b0),                               // (terminated)
		.reset_in10     (1'b0),                               // (terminated)
		.reset_req_in10 (1'b0),                               // (terminated)
		.reset_in11     (1'b0),                               // (terminated)
		.reset_req_in11 (1'b0),                               // (terminated)
		.reset_in12     (1'b0),                               // (terminated)
		.reset_req_in12 (1'b0),                               // (terminated)
		.reset_in13     (1'b0),                               // (terminated)
		.reset_req_in13 (1'b0),                               // (terminated)
		.reset_in14     (1'b0),                               // (terminated)
		.reset_req_in14 (1'b0),                               // (terminated)
		.reset_in15     (1'b0),                               // (terminated)
		.reset_req_in15 (1'b0)                                // (terminated)
	);

	altera_reset_controller #(
		.NUM_RESET_INPUTS          (2),
		.OUTPUT_RESET_SYNC_EDGES   ("deassert"),
		.SYNC_DEPTH                (2),
		.RESET_REQUEST_PRESENT     (0),
		.RESET_REQ_WAIT_TIME       (1),
		.MIN_RST_ASSERTION_TIME    (3),
		.RESET_REQ_EARLY_DSRT_TIME (1),
		.USE_RESET_REQUEST_IN0     (0),
		.USE_RESET_REQUEST_IN1     (0),
		.USE_RESET_REQUEST_IN2     (0),
		.USE_RESET_REQUEST_IN3     (0),
		.USE_RESET_REQUEST_IN4     (0),
		.USE_RESET_REQUEST_IN5     (0),
		.USE_RESET_REQUEST_IN6     (0),
		.USE_RESET_REQUEST_IN7     (0),
		.USE_RESET_REQUEST_IN8     (0),
		.USE_RESET_REQUEST_IN9     (0),
		.USE_RESET_REQUEST_IN10    (0),
		.USE_RESET_REQUEST_IN11    (0),
		.USE_RESET_REQUEST_IN12    (0),
		.USE_RESET_REQUEST_IN13    (0),
		.USE_RESET_REQUEST_IN14    (0),
		.USE_RESET_REQUEST_IN15    (0),
		.ADAPT_RESET_REQUEST       (0)
	) rst_controller_001 (
		.reset_in0      (~reset_reset_n),                     // reset_in0.reset
		.reset_in1      (niosii_debug_reset_request_reset),   // reset_in1.reset
		.clk            (clk_clk),                            //       clk.clk
		.reset_out      (rst_controller_001_reset_out_reset), // reset_out.reset
		.reset_req      (),                                   // (terminated)
		.reset_req_in0  (1'b0),                               // (terminated)
		.reset_req_in1  (1'b0),                               // (terminated)
		.reset_in2      (1'b0),                               // (terminated)
		.reset_req_in2  (1'b0),                               // (terminated)
		.reset_in3      (1'b0),                               // (terminated)
		.reset_req_in3  (1'b0),                               // (terminated)
		.reset_in4      (1'b0),                               // (terminated)
		.reset_req_in4  (1'b0),                               // (terminated)
		.reset_in5      (1'b0),                               // (terminated)
		.reset_req_in5  (1'b0),                               // (terminated)
		.reset_in6      (1'b0),                               // (terminated)
		.reset_req_in6  (1'b0),                               // (terminated)
		.reset_in7      (1'b0),                               // (terminated)
		.reset_req_in7  (1'b0),                               // (terminated)
		.reset_in8      (1'b0),                               // (terminated)
		.reset_req_in8  (1'b0),                               // (terminated)
		.reset_in9      (1'b0),                               // (terminated)
		.reset_req_in9  (1'b0),                               // (terminated)
		.reset_in10     (1'b0),                               // (terminated)
		.reset_req_in10 (1'b0),                               // (terminated)
		.reset_in11     (1'b0),                               // (terminated)
		.reset_req_in11 (1'b0),                               // (terminated)
		.reset_in12     (1'b0),                               // (terminated)
		.reset_req_in12 (1'b0),                               // (terminated)
		.reset_in13     (1'b0),                               // (terminated)
		.reset_req_in13 (1'b0),                               // (terminated)
		.reset_in14     (1'b0),                               // (terminated)
		.reset_req_in14 (1'b0),                               // (terminated)
		.reset_in15     (1'b0),                               // (terminated)
		.reset_req_in15 (1'b0)                                // (terminated)
	);

endmodule
