//================================================================
//     SRAM control Module
//		 
//		 This module is responsible for saving a screen shot in 
//		 external SRAM and then pass control to Nios to read the
//		 stored data and stream it to external PC host which is 
//		 saved on disc as .txt file
//================================================================
module SRAM_Control(
	input VGA_CLK, Main_CLK, SRAM_CLK, Reset, ScreenCapture, Nios_Finish_Reading_Flag, ScreenActiveStart_Flag, ScreenActiveFinish_Flag, Blank_N,
	input[19:0] Read_Address,
	input[23:0] Pixel_Data,
	input[9:0] H_Pixel, V_Pixel,
	output[15:0] Data_Chunk,
	output[19:0] Address,
	output OE_N, CE_N, LB_N, UB_N, WE_N,
	output reg WriteFinish_Flag
);

reg[15:0] Data;
reg[19:0] Pixel_Address;
reg[15:0] Data_Vaild_Flag;
reg StartFlagDetected, IgniteAddressing;
reg[11:0] DeBounce_Counter;

wire Enable_Write_Address;

assign Data_Chunk = Data & Data_Vaild_Flag;
assign Address = (WriteFinish_Flag)? Read_Address : Pixel_Address;
assign OE_N = 0;
assign CE_N = (ScreenCapture)? 0 : 1;
assign LB_N = 0;
assign UB_N = 0;
assign WE_N = (ScreenCapture && !WriteFinish_Flag)? 0 : 1;
//====================================
/** Check first pixel and last pixel pulses */
always @(SRAM_CLK)
	begin
	if (!Reset) StartFlagDetected = 0;
	else
		begin
		if (ScreenActiveStart_Flag) StartFlagDetected = 1;
		else if (ScreenActiveFinish_Flag) StartFlagDetected = 0;
		end
	end
//====================================
/** Specify writing range to be exactly filling the whole screen */
assign Enable_Write_Address = (StartFlagDetected && Blank_N)? 1 : 0;
//====================================
/** Control writing operation */
always @(posedge Main_CLK)
	begin
	if (!Reset) 
		begin
		Pixel_Address <= 0;
		WriteFinish_Flag <= 0;
		end
	else
		begin
		if (ScreenCapture && !WriteFinish_Flag) 
			begin
			if (Enable_Write_Address && IgniteAddressing) Pixel_Address <= Pixel_Address + 1;
			if (Pixel_Address == 614399)
				begin
				WriteFinish_Flag <= 1;
				Pixel_Address <= 0;
				end
			else WriteFinish_Flag <= 0;
			end
		else if (!ScreenCapture && Nios_Finish_Reading_Flag) WriteFinish_Flag <= 0;
		else Pixel_Address <= 0;
		end
	end
//====================================
/** Pixel data chunk */
always @(posedge Main_CLK)
	begin
	if (!Reset) Data <= 0;
	else
		begin
		if (H_Pixel > 515 && H_Pixel < 625 && V_Pixel > 380 && V_Pixel < 425)
			begin
			if (Pixel_Address % 2 == 0) Data <= {8'h00,8'h00};
			else Data <= {8'h00, 8'h00};
			end
		else
			begin
			if (Pixel_Address % 2 == 0) Data <= {Pixel_Data[23:16],Pixel_Data[15:8]};
			else Data <= {Pixel_Data[7:0], 8'h00};
			end
		end
	end
//====================================
always @(Main_CLK)
	begin
	if (ScreenCapture && ScreenActiveStart_Flag) IgniteAddressing <= 1;
	if ((ScreenCapture && ScreenActiveFinish_Flag) || !ScreenCapture) IgniteAddressing <= 0;
	end
//====================================
always @(posedge SRAM_CLK)
	begin
	if (!Reset) Data_Vaild_Flag <= 16'h0000;
	else
		begin
		if (IgniteAddressing) Data_Vaild_Flag <= 16'hFFFF;
		else Data_Vaild_Flag <= 16'h0000;
		end
	end
endmodule 