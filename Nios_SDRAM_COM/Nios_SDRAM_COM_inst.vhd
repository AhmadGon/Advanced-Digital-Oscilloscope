	component Nios_SDRAM_COM is
		port (
			clk_clk                  : in  std_logic                     := 'X';             -- clk
			events_export            : in  std_logic_vector(2 downto 0)  := (others => 'X'); -- export
			input_data_export        : in  std_logic_vector(15 downto 0) := (others => 'X'); -- export
			output_address_export    : out std_logic_vector(19 downto 0);                    -- export
			reset_reset_n            : in  std_logic                     := 'X';             -- reset_n
			clock_bridge_out_clk_clk : out std_logic                                         -- clk
		);
	end component Nios_SDRAM_COM;

	u0 : component Nios_SDRAM_COM
		port map (
			clk_clk                  => CONNECTED_TO_clk_clk,                  --                  clk.clk
			events_export            => CONNECTED_TO_events_export,            --               events.export
			input_data_export        => CONNECTED_TO_input_data_export,        --           input_data.export
			output_address_export    => CONNECTED_TO_output_address_export,    --       output_address.export
			reset_reset_n            => CONNECTED_TO_reset_reset_n,            --                reset.reset_n
			clock_bridge_out_clk_clk => CONNECTED_TO_clock_bridge_out_clk_clk  -- clock_bridge_out_clk.clk
		);

