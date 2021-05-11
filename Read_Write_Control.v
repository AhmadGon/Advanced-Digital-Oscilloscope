//================================================================
//     Read-Write Module
//		 
//		 This module is responsible for communicating with the 
//		 SDRAM controller through Avalon Memory-Mapped Slave port
//		 and then pass control to Nios after finish writing data
//================================================================
module Read_Write_Control(
	/** VGA_CLK is used to write data, but the whole module is clocked with SDRAM_CLK */
	input VGA_CLK, SDRAM_CLK, Reset, ScreenCapture, Blank_N, Nios_Finish_Reading_Flag,
	input[9:0] H_Pixel, V_Pixel,
	/** Write pixel data to SDRAM */
	input[23:0] Write_Data,
	/** Nios read address */
//	input[24:0] Read_Address,
	/** Chip select */
	output reg CS,
	/** Since we need to only write 24 bits so we need to enable 3 bytes, this signal is responsible for this */
	output[3:0] ByteEnable_N,
	/** Output signal results from read/write operation through this module */
	output[24:0] Address,
	output COM_Read_N, COM_Write_N,
	output[23:0] COM_Write_Data
);

reg Read_Write_N, ScreenCaptureFinish_Flag, ScreenCaptureStart_Flag, ScreenCaptureStartFlagDectected;
reg[24:0] Write_Address, Read_Address;

assign Address = (!Read_Write_N)? Write_Address : Read_Address;
assign COM_Read_N = (Read_Write_N)? 0 : 1;
assign COM_Write_N = (!Read_Write_N)? 0 : 1;
assign ByteEnable_N = 4'b1000; /** activate 3 bytes (24 bits) */
assign COM_Write_Data = Write_Data;

//====================================
/** Controls the starting and finishing events */
always @(posedge SDRAM_CLK)
	begin
	if (!Reset) ScreenCaptureStartFlagDectected <= 0;
	else
		begin
		if (ScreenCaptureStart_Flag) ScreenCaptureStartFlagDectected <= 1;
		if (ScreenCaptureFinish_Flag) ScreenCaptureStartFlagDectected <= 0;
		if (!ScreenCapture) ScreenCaptureStartFlagDectected <= 0;
		end
	end
//====================================
/** Controls the starting and finishing events */
always @(posedge SDRAM_CLK)
	begin
	if (!Reset) 
		begin
		ScreenCaptureFinish_Flag <= 0;
		ScreenCaptureStart_Flag <= 0;
		end
	else 
		begin
		if (!ScreenCaptureFinish_Flag)
			begin
			/** This means we are at the first pixel of the screen */
			if (Blank_N && H_Pixel == 1 && V_Pixel == 0 && ScreenCapture) ScreenCaptureStart_Flag <= 1;
			else if (Write_Address == 307199) ScreenCaptureFinish_Flag <= 1;
			else
				begin
				ScreenCaptureStart_Flag <= 0;
				ScreenCaptureFinish_Flag <= 0;
				end
			end
		else
			begin
			/** after finished writing to SDRAM, we wait for Nios to finish reading from it after finish reading and if ScreenCapture is high */
			/** the screen capture event will happen again to avoid that we need to make sure that the ScreenCapture switch is set to low to */
			/** give a chance for another screen capture event otherwise no screen capturing will happen */
			if (Nios_Finish_Reading_Flag && !ScreenCapture) 
				begin
				ScreenCaptureStart_Flag <= 0;
				ScreenCaptureFinish_Flag <= 0;
				end
			end
		end
	end
//====================================
/** Activating SDRAM only when writing and reading data */
always @(posedge SDRAM_CLK)
	begin
	if (!Reset) CS <= 0;
	else
		begin
		if (ScreenCapture && !Nios_Finish_Reading_Flag) CS <= 1;
		else CS <= 0;
		end
	end
//====================================
/** Activating SDRAM only when writing and reading data */
always @(posedge VGA_CLK)
	begin
	if (!Reset) Write_Address <= 0;
	else 
		begin
		if (Blank_N && ScreenCaptureStartFlagDectected) Write_Address <= Write_Address + 1;
		if (!ScreenCapture || Write_Address == 307199) Write_Address <= 0;
		end
	end
//====================================
/** If screen capture is set to high it means start taking screen shot until receiving capture finish flag */
always @(posedge ScreenCaptureStart_Flag or posedge ScreenCaptureFinish_Flag or negedge Reset)
	begin
	if (!Reset) Read_Write_N <= 0;
	else
		begin
		if (ScreenCaptureStart_Flag) Read_Write_N <= 0;
		if (ScreenCaptureFinish_Flag) Read_Write_N <= 1;
		end
	end
//====================================
/** Block to generate testing address */
always @(posedge SDRAM_CLK)
	begin
	if (!Reset) Read_Address <= 0;
	else
		begin
		if (Read_Write_N) Read_Address <= Read_Address + 1;
		else Read_Address <= 0;
		end
	end
endmodule 