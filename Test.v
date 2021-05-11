module Test(
	input CS, VGA_CLK,
	output reg [11:0] CH1_Third_Stage, CH2_Third_Stage
);

reg [13:0] count_1, count_2;
always@(posedge CS)
	begin
	if (count_2 == 15359) count_2 <= 0; 
	else count_2 <= count_2 + 1;
	if (count_1 == 15359) count_1 <= 0; 
	else count_1 <= count_1 + 1;
	end
	
/** Metastability protection */
reg [11:0] CH1_First_Stage, CH2_First_Stage, CH1_Second_Stage, CH2_Second_Stage;
always @(posedge VGA_CLK)
	begin
	CH1_First_Stage <= test_1;
	CH1_Second_Stage <= CH1_First_Stage;
	CH1_Third_Stage <= CH1_Second_Stage;
	
	CH2_First_Stage <= test_2;
	CH2_Second_Stage <= CH2_First_Stage;
	CH2_Third_Stage <= CH2_Second_Stage;
	end
	
wire [11:0] test_1, test_2;
TestCH1	TestCH1_inst (
	.address ( count_1 ),
	.clock ( CS ),
	.q ( test_1 )
	);
TestCH2	TestCH2_inst (
	.address ( count_2 ),
	.clock ( CS ),
	.q ( test_2 )
	);
	
endmodule 