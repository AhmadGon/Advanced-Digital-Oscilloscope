	component Nios_Screen_Reader is
		port (
			clk_clk                   : in    std_logic                     := 'X';             -- clk
			clock_bridge_out_clk_clk  : out   std_logic;                                        -- clk
			events_export             : in    std_logic_vector(2 downto 0)  := (others => 'X'); -- export
			input_data_export         : in    std_logic_vector(15 downto 0) := (others => 'X'); -- export
			loading_percentage_export : out   std_logic_vector(6 downto 0);                     -- export
			output_address_export     : out   std_logic_vector(19 downto 0);                    -- export
			reset_reset_n             : in    std_logic                     := 'X';             -- reset_n
			response_export           : out   std_logic_vector(2 downto 0);                     -- export
			sdram_addr                : out   std_logic_vector(12 downto 0);                    -- addr
			sdram_ba                  : out   std_logic_vector(1 downto 0);                     -- ba
			sdram_cas_n               : out   std_logic;                                        -- cas_n
			sdram_cke                 : out   std_logic;                                        -- cke
			sdram_cs_n                : out   std_logic;                                        -- cs_n
			sdram_dq                  : inout std_logic_vector(31 downto 0) := (others => 'X'); -- dq
			sdram_dqm                 : out   std_logic_vector(3 downto 0);                     -- dqm
			sdram_ras_n               : out   std_logic;                                        -- ras_n
			sdram_we_n                : out   std_logic;                                        -- we_n
			sdram_clk_clk             : out   std_logic                                         -- clk
		);
	end component Nios_Screen_Reader;

	u0 : component Nios_Screen_Reader
		port map (
			clk_clk                   => CONNECTED_TO_clk_clk,                   --                  clk.clk
			clock_bridge_out_clk_clk  => CONNECTED_TO_clock_bridge_out_clk_clk,  -- clock_bridge_out_clk.clk
			events_export             => CONNECTED_TO_events_export,             --               events.export
			input_data_export         => CONNECTED_TO_input_data_export,         --           input_data.export
			loading_percentage_export => CONNECTED_TO_loading_percentage_export, --   loading_percentage.export
			output_address_export     => CONNECTED_TO_output_address_export,     --       output_address.export
			reset_reset_n             => CONNECTED_TO_reset_reset_n,             --                reset.reset_n
			response_export           => CONNECTED_TO_response_export,           --             response.export
			sdram_addr                => CONNECTED_TO_sdram_addr,                --                sdram.addr
			sdram_ba                  => CONNECTED_TO_sdram_ba,                  --                     .ba
			sdram_cas_n               => CONNECTED_TO_sdram_cas_n,               --                     .cas_n
			sdram_cke                 => CONNECTED_TO_sdram_cke,                 --                     .cke
			sdram_cs_n                => CONNECTED_TO_sdram_cs_n,                --                     .cs_n
			sdram_dq                  => CONNECTED_TO_sdram_dq,                  --                     .dq
			sdram_dqm                 => CONNECTED_TO_sdram_dqm,                 --                     .dqm
			sdram_ras_n               => CONNECTED_TO_sdram_ras_n,               --                     .ras_n
			sdram_we_n                => CONNECTED_TO_sdram_we_n,                --                     .we_n
			sdram_clk_clk             => CONNECTED_TO_sdram_clk_clk              --            sdram_clk.clk
		);

