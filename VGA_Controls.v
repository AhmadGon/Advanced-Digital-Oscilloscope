//================================================================
//     VGA Control Module
//		 
//		 This module generates necessary signals for displaying
//     images with 640×480 resolution at 60Hz refresh rate
//================================================================
module VGA_Controls(
	/** Clock and reset */
	input Main_CLK, Reset,
	/** VGA control signals */
	output reg VGA_CLK, Hsync, Vsync, Blank_N, ScreenActiveStart_Flag, ScreenActiveFinish_Flag,
	output Sync_N,
	/** Horizontal and vertical pixel counters */
	output reg[9:0] H_Pixel, V_Pixel
);

reg[10:0] H_Counter, V_Counter;
reg Divider;

/** Tell the ADV7123 DAC to generate outputs synchronously */
assign Sync_N = 0;

//====================================
/** Generate 25MHz pixel clock */
always @(posedge Main_CLK)
	begin
	if (!Reset) Divider <= 0;
	else
		begin
		Divider <= Divider + 1;
		if (Divider == 0) VGA_CLK <= 0;
		else VGA_CLK <= 1;
		end
	end
//====================================
/** Generate Hsync synchronization signal */
always @(posedge VGA_CLK)
	begin
	if (!Reset)
		begin
		Hsync <= 0;
		H_Counter <= 0;
		end
	else
		begin
		H_Counter <= H_Counter + 1;
		if (H_Counter > 94) 
			begin
			Hsync <= 1;
			if (H_Counter == 799) 
				begin
				H_Counter <= 0;
				Hsync <= 0;
				end
			end
		else Hsync <= 0;
		end
	end
//====================================
/** Generate Vsync synchronization signal */
always @(posedge Hsync)
	begin
	if (!Reset) 
		begin
		Vsync <= 0;
		V_Counter <= 0;
		end
	else
		begin
		V_Counter <= V_Counter + 1;
		if (V_Counter > 0) 
			begin
			Vsync <= 1;
			if (V_Counter == 524) 
				begin
				V_Counter <= 0;
				Vsync <= 0;
				end
			end
		else Vsync <= 0;
		end
	end
//====================================
/** Set Blank_N flag */
always @(posedge VGA_CLK)
	begin
	if (H_Counter > 144 && H_Counter < 785 && V_Counter > 35 && V_Counter < 516) Blank_N <= 1;
	else Blank_N <= 0;
	end
//====================================
/** Ignite the H_Pixel counter */
always @(posedge VGA_CLK)
	begin
	if (!Reset) H_Pixel <= 0;
	else
		begin
		if (H_Counter > 144 && H_Counter < 785)
			begin
			H_Pixel <= H_Pixel + 1;
			end
		else H_Pixel <= 0;
		end
	end
//====================================
/** Ignite the V_Pixel counter */
always @(posedge Hsync)
	begin
	if (!Reset) V_Pixel <= 0;
	else
		begin
		if (V_Counter > 35 && V_Counter < 516)
			begin
			V_Pixel <= V_Pixel + 1;
			end
		else V_Pixel <= 0;
		end
	end
always @(posedge Main_CLK)
	begin
	if (H_Counter == 145 && V_Counter == 36) ScreenActiveStart_Flag <= 1;
	else if (H_Pixel == 639 && V_Pixel == 479) ScreenActiveFinish_Flag <= 1;
	else 
		begin
		ScreenActiveStart_Flag <= 0;
		ScreenActiveFinish_Flag <= 0;
		end
	end
endmodule 