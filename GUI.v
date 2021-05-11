//================================================================
//     GUI Module
//		 
//		 This module is responsible for displaying scope's graphical
//		 User Interface
//================================================================
module GUI(
	/** VGA Clock and reset */
	input Main_CLK, VGA_CLK, Reset, Blank_N, ScreenActiveStart_Flag, ScreenActiveFinish_Flag,
	/** Horizontal and vertical pixel counters */
	input [9:0] H_Pixel, V_Pixel,
	/** Input Data from ADCs */
	/** Outputs red, green and blue signals */
	output reg[7:0] Red, Green, Blue,
	/**Input data from Memory**/
	input [23:0] Color_Of_Images,
	/** Signal from Memory Management */
	input [11:0] Data_CH_1, Data_CH_2,
	input [7:0] Font_Out,
	input [15:0] String_Data,
	input [71:0] Long_String_Data,
	output reg[13:0] Address_CH_read,
	output reg[11:0] Address_Fig_AMP, Address_Fig_Freq,
	output reg[18:0] Address_Guide,
	output reg[2:0] Key_Fig,
	output reg[10:0] Font_Address,
	output reg[3:0] String_Address,
	output reg[4:0] Long_String_Address,
	/** User controls */
	input TimeScale_1, TimeScale_2, TimeScale_3, TimeScale_4, TimeScale_5, Cursors_Enable, ScreenCapture,
	input Cursor_Channel_Switch, Cursor_Right_Left_Switch, Cursor_Direction_Switch, Cursor_Moving_Button,
	input Move_Up_Down_Drawn_Signal, Signal_Move_Button, Cursor_Up_Down_Switch, Amplitude_Cursor_Direction_Switch,
	input Amplitude_Cursor_Moving_Button, Guide_Activated,
	input [2:0] Amplitude_Binary,
	/** Signals from Nios */
	input [6:0] Loading_Percentage,
	input Nios_Finish_Reading_Flag
);


/** Drawing priorities */
/** The highest priority is Priority_0 */
parameter Priority_0 = 0; /** Data drawing priority */
parameter Priority_1 = 1; /** Grid priority */
parameter Priority_2 = 2; 

reg [2:0] Priority;
reg [11:0] CH1_DATA;
reg [11:0] CH2_DATA;
reg H_CH1_eneble, V_CH1_eneble, H_CH2_eneble, V_CH2_eneble, H_Freq1_eneble, V_Freq1_eneble;
reg H_Freq2_eneble, V_Freq2_eneble, H_Amp1_eneble, V_Amp1_eneble, H_Amp2_eneble, V_Amp2_eneble, H_Screen_eneble, V_Screen_eneble;
reg H_Guide_enable, V_Guide_enable;
reg H_CH1_channle_eneble, V_CH1_channle_eneble, H_CH2_channle_eneble, V_CH2_channle_eneble, IgniteAddressing;
reg [5:0] TimeScale;
reg [6:0] AmplitudeScale;

reg [8:0] CH1_Right_Time_Cursor = 120;
reg [8:0] CH1_Left_Time_Cursor = 320;
reg [8:0] CH2_Right_Time_Cursor = 220;
reg [8:0] CH2_Left_Time_Cursor = 370;

reg [8:0] CH1_Up_Amplitude_Cursor = 43;
reg [8:0] CH1_Down_Amplitude_Cursor = 150;
reg [8:0] CH2_Up_Amplitude_Cursor = 280;
reg [8:0] CH2_Down_Amplitude_Cursor = 330;

reg [9:0] CH1_Offset, CH2_Offset;

wire[4:0] TimeScale_Counter;
wire[19:0] CH1_BCD, CH2_BCD, CH1_Amplitude_BCD, CH2_Amplitude_BCD;

assign TimeScale_Counter = TimeScale_1 + TimeScale_2 + TimeScale_3 + TimeScale_4 + TimeScale_5;
//====================================
Frequency_Calculator Frequency_Calculator_Inst(
	.Main_CLK(Main_CLK),
	.TimeScale(TimeScale),
	.CH1_Right_Time_Cursor(CH1_Right_Time_Cursor),
	.CH1_Left_Time_Cursor(CH1_Left_Time_Cursor),
	.CH2_Right_Time_Cursor(CH2_Right_Time_Cursor),
	.CH2_Left_Time_Cursor(CH2_Left_Time_Cursor),
	.CH1_BCD(CH1_BCD),
	.CH2_BCD(CH2_BCD)
);
//====================================
Amplitude_Calculator Amplitude_Calculator_Inst(
	.Main_CLK(Main_CLK),
	.Amplitude_Scale(AmplitudeScale),
	.CH1_Up_Amplitude_Cursor(CH1_Up_Amplitude_Cursor),
	.CH1_Down_Amplitude_Cursor(CH1_Down_Amplitude_Cursor),
	.CH2_Up_Amplitude_Cursor(CH2_Up_Amplitude_Cursor),
	.CH2_Down_Amplitude_Cursor(CH2_Down_Amplitude_Cursor),
	.CH1_BCD(CH1_Amplitude_BCD),
	.CH2_BCD(CH2_Amplitude_BCD)
);
//====================================
/** Updating cursor clock */
reg [19:0] Updating_Counter;
reg Update_CLK;
always @(posedge VGA_CLK)
	begin
	if (!Reset) Updating_Counter <= 0;
	else
		begin
		if (!Cursor_Moving_Button || !Signal_Move_Button || !Amplitude_Cursor_Moving_Button) Updating_Counter <= Updating_Counter + 1;
		if (Updating_Counter == 499999) Update_CLK <= !Update_CLK;
		if (Updating_Counter == 999999) 
			begin
			Updating_Counter <= 0;
			Update_CLK <= !Update_CLK;
			end
		end
	end
/** Update time cursors locations */
always @(posedge Update_CLK)
	begin
	/** If cursors for channel 1 is enabled */
	if (Cursor_Channel_Switch)
		begin
		/** If the right cursor is chosen */
		if (Cursor_Right_Left_Switch)
			begin
			/** If moving to the right is enabled */
			if (Cursor_Direction_Switch)
				begin
				if (!Cursor_Moving_Button && Cursors_Enable)
					begin
					CH1_Right_Time_Cursor <= CH1_Right_Time_Cursor + 1;
					if (CH1_Right_Time_Cursor > 498) CH1_Right_Time_Cursor <= 498;
					if (CH1_Right_Time_Cursor < 19) CH1_Right_Time_Cursor <= 19;
					end
				end
			/** If moving to the left is enabled */
			else
				begin
				if (!Cursor_Moving_Button && Cursors_Enable)
					begin
					CH1_Right_Time_Cursor <= CH1_Right_Time_Cursor - 1;
					if (CH1_Right_Time_Cursor > 498) CH1_Right_Time_Cursor <= 498;
					if (CH1_Right_Time_Cursor < 19) CH1_Right_Time_Cursor <= 19;
					end
				end
			end
		/** If the left cursor is chosen */
		else
			begin
			/** If moving to the right is enabled */
			if (Cursor_Direction_Switch)
				begin
				/** If moving push button is pressed */
				if (!Cursor_Moving_Button && Cursors_Enable)
					begin
					CH1_Left_Time_Cursor <= CH1_Left_Time_Cursor + 1;
					if (CH1_Left_Time_Cursor > 498) CH1_Left_Time_Cursor <= 498;
					if (CH1_Left_Time_Cursor < 19) CH1_Left_Time_Cursor <= 19;
					end
				end
			/** If moving to the left is enabled */
			else
				begin
				/** If moving push button is pressed */
				if (!Cursor_Moving_Button && Cursors_Enable)
					begin
					CH1_Left_Time_Cursor <= CH1_Left_Time_Cursor - 1;
					if (CH1_Left_Time_Cursor > 498) CH1_Left_Time_Cursor <= 498;
					if (CH1_Left_Time_Cursor < 19) CH1_Left_Time_Cursor <= 19;
					end
				end
			end
		end
	/** If cursors for channel 2 is enabled */
	else
		begin
		/** If the right cursor is chosen */
		if (Cursor_Right_Left_Switch)
			begin
			/** If moving to the right is enabled */
			if (Cursor_Direction_Switch)
				begin
				/** If moving push button is pressed */
				if (!Cursor_Moving_Button && Cursors_Enable)
					begin
					CH2_Right_Time_Cursor <= CH2_Right_Time_Cursor + 1;
					if (CH2_Right_Time_Cursor > 498) CH2_Right_Time_Cursor <= 498;
					if (CH2_Right_Time_Cursor < 19) CH2_Right_Time_Cursor <= 19;
					end
				end
			/** If moving to the left is enabled */
			else
				begin
				/** If moving push button is pressed */
				if (!Cursor_Moving_Button && Cursors_Enable)
					begin
					CH2_Right_Time_Cursor <= CH2_Right_Time_Cursor - 1;
					if (CH2_Right_Time_Cursor > 498) CH2_Right_Time_Cursor <= 498;
					if (CH2_Right_Time_Cursor < 19) CH2_Right_Time_Cursor <= 19;
					end
				end
			end
		/** If the left cursor is chosen */
		else
			begin
			/** If moving to the right is enabled */
			if (Cursor_Direction_Switch)
				begin
				/** If moving push button is pressed */
				if (!Cursor_Moving_Button && Cursors_Enable)
					begin
					CH2_Left_Time_Cursor <= CH2_Left_Time_Cursor + 1;
					if (CH2_Left_Time_Cursor > 498) CH2_Left_Time_Cursor <= 498;
					if (CH2_Left_Time_Cursor < 19) CH2_Left_Time_Cursor <= 19;
					end
				end
			else
				begin
				/** If moving push button is pressed */
				if (!Cursor_Moving_Button && Cursors_Enable)
					begin
					CH2_Left_Time_Cursor <= CH2_Left_Time_Cursor - 1;
					if (CH2_Left_Time_Cursor > 498) CH2_Left_Time_Cursor <= 498;
					if (CH2_Left_Time_Cursor < 19) CH2_Left_Time_Cursor <= 19;
					end
				end
			end
		end
	end
/** Offset the drawn signal */
always @(posedge Update_CLK)
	begin
	/** If CH1 is chosen */
	if (Cursor_Channel_Switch)
		begin
		if (!Signal_Move_Button)
			begin
			if (Move_Up_Down_Drawn_Signal)
				begin
				CH1_Offset <= CH1_Offset + 1;
				if (CH1_Offset > 196) CH1_Offset <= 196;
				end
			else
				begin
				CH1_Offset <= CH1_Offset - 1;
				if (CH1_Offset < 1) CH1_Offset <= 0;
				end
			end
		end
	/** If CH2 is chosen */
	else
		begin
		if (!Signal_Move_Button)
			begin
			if (Move_Up_Down_Drawn_Signal)
				begin
				CH2_Offset <= CH2_Offset + 1;
				if (CH2_Offset > 196) CH2_Offset <= 196;
				end
			else
				begin
				CH2_Offset <= CH2_Offset - 1;
				if (CH2_Offset < 1) CH2_Offset <= 0;
				end
			end
		end
	end
/** Update amplitude cursors locations */
always @(posedge Update_CLK)
	begin
	/** If CH1 is chosen */
	if (Cursor_Channel_Switch)
		begin
		/** If upper cursor is chosen*/
		if (Cursor_Up_Down_Switch)
			begin
			if (!Amplitude_Cursor_Moving_Button && Cursors_Enable)
				begin
				/** If moving up is enabled */
				if (Amplitude_Cursor_Direction_Switch)
					begin
					CH1_Up_Amplitude_Cursor <= CH1_Up_Amplitude_Cursor - 1;
					if (CH1_Up_Amplitude_Cursor < 13) CH1_Up_Amplitude_Cursor <= 13;
					end
				/** If moving down is enabled */
				else
					begin
					CH1_Up_Amplitude_Cursor <= CH1_Up_Amplitude_Cursor + 1;
					if (CH1_Up_Amplitude_Cursor > 227) CH1_Up_Amplitude_Cursor <= 228;
					end
				end
			end
		/** If lower cursor is chosen */
		else
			begin
			if (!Amplitude_Cursor_Moving_Button && Cursors_Enable)
				begin
				/** If moving up is enabled */
				if (Amplitude_Cursor_Direction_Switch)
					begin
					CH1_Down_Amplitude_Cursor <= CH1_Down_Amplitude_Cursor - 1;
					if (CH1_Down_Amplitude_Cursor < 13) CH1_Down_Amplitude_Cursor <= 13;
					end
				/** If moving down is enabled */
				else
					begin
					CH1_Down_Amplitude_Cursor <= CH1_Down_Amplitude_Cursor + 1;
					if (CH1_Down_Amplitude_Cursor > 227) CH1_Down_Amplitude_Cursor <= 228;
					end
				end
			end
		end
	/** If CH2 is chosen */
	else
		begin
		/** If upper cursor is chosen*/
		if (Cursor_Up_Down_Switch)
			begin
			if (!Amplitude_Cursor_Moving_Button && Cursors_Enable)
				begin
				/** If moving up is enabled */
				if (Amplitude_Cursor_Direction_Switch)
					begin
					CH2_Up_Amplitude_Cursor <= CH2_Up_Amplitude_Cursor - 1;
					if (CH2_Up_Amplitude_Cursor < 244) CH2_Up_Amplitude_Cursor <= 244;
					end
				/** If moving down is enabled */
				else
					begin
					CH2_Up_Amplitude_Cursor <= CH2_Up_Amplitude_Cursor + 1;
					if (CH2_Up_Amplitude_Cursor > 462) CH2_Up_Amplitude_Cursor <= 462;
					end
				end
			end
		/** If lower cursor is chosen */
		else
			begin
			if (!Amplitude_Cursor_Moving_Button && Cursors_Enable)
				begin
				/** If moving up is enabled */
				if (Amplitude_Cursor_Direction_Switch)
					begin
					CH2_Down_Amplitude_Cursor <= CH2_Down_Amplitude_Cursor - 1;
					if (CH2_Down_Amplitude_Cursor < 244) CH2_Down_Amplitude_Cursor <= 244;
					end
				/** If moving down is enabled */
				else
					begin
					CH2_Down_Amplitude_Cursor <= CH2_Down_Amplitude_Cursor + 1;
					if (CH2_Down_Amplitude_Cursor > 462) CH2_Down_Amplitude_Cursor <= 462;
					end
				end
			end		
		end
	end
//====================================
/** Time scale control */
always @(Main_CLK)
	begin
	case(TimeScale_Counter)
	0: TimeScale = 1;
	1: TimeScale = 2;
	2: TimeScale = 4;
	3: TimeScale = 8;
	4: TimeScale = 16;
	5: TimeScale = 32;
	default: TimeScale = 1;
	endcase
	end
//====================================
/** Amplitude scale control */
always @(Main_CLK)
	begin
	case(Amplitude_Binary)
	3'b000: AmplitudeScale = 1;
	3'b001: AmplitudeScale = 2;
	3'b010: AmplitudeScale = 4;
	3'b011: AmplitudeScale = 8;
	3'b100: AmplitudeScale = 16;
	3'b101: AmplitudeScale = 32;
	3'b110: AmplitudeScale = 64;
	3'b111: AmplitudeScale = 128;
	default: AmplitudeScale = 1;
	endcase
	end
//====================================
/** Specify drawing priorities */
always @(posedge Main_CLK)
	begin
	if (!Reset) Priority <= 3'h00;
	else if ((V_Pixel == ((Data_CH_1 / AmplitudeScale) + (13 + CH1_Offset))) || (V_Pixel == (Data_CH_2 / AmplitudeScale + 247 + CH2_Offset))) Priority <= Priority_0;
	else if ((V_Pixel >= 11 && V_Pixel <= 230) || (V_Pixel >= 244 && V_Pixel <= 463)) Priority <= Priority_1;
	else Priority <= Priority_2;
	end 
//====================================
/** Eneble signals to show Images**/
always @(Main_CLK)
	begin	
	if (V_Pixel >= 16 & V_Pixel < 36) V_Freq1_eneble <= 1; 
	else V_Freq1_eneble <= 0;
	if (H_Pixel >= 530 & H_Pixel < 605) H_Freq1_eneble <= 1;
	else H_Freq1_eneble <= 0;
	
	if (V_Pixel >= 249 & V_Pixel < 269) V_Freq2_eneble <= 1; 
	else V_Freq2_eneble <= 0;
	if (H_Pixel >= 530 & H_Pixel < 605) H_Freq2_eneble <= 1;
	else H_Freq2_eneble <= 0;
	
	if (V_Pixel > 90 & V_Pixel < 112) V_Amp1_eneble <= 1; 
	else V_Amp1_eneble <= 0;
	if (H_Pixel > 529 & H_Pixel < 605) H_Amp1_eneble <= 1;
	else H_Amp1_eneble <= 0;
	
	if (V_Pixel >= 324 & V_Pixel < 345) V_Amp2_eneble <= 1; 
	else V_Amp2_eneble <= 0;
	if (H_Pixel >= 530 & H_Pixel < 605) H_Amp2_eneble <= 1;
	else H_Amp2_eneble <= 0;
	
	if (V_Pixel > 0 & V_Pixel < 481) V_Guide_enable <= 1; 
	else V_Guide_enable <= 0;
	if (H_Pixel > 0 & H_Pixel < 641) H_Guide_enable <= 1;
	else H_Guide_enable <= 0;
	
	if (V_Pixel >= 13 & V_Pixel < 229) V_CH1_channle_eneble <= 1; 
	else V_CH1_channle_eneble <= 0;
	if (H_Pixel >= 19 & H_Pixel < 499) H_CH1_channle_eneble <= 1;
	else H_CH1_channle_eneble <= 0;
	
	if (V_Pixel >= 244 & V_Pixel < 464) V_CH2_channle_eneble <= 1; 
	else V_CH2_channle_eneble <= 0;
	if (H_Pixel >= 19 & H_Pixel < 499) H_CH2_channle_eneble <= 1;
	else H_CH2_channle_eneble <= 0;		
	end
//====================================
/** Data enabling signals */
always @(posedge VGA_CLK)
	begin
	if(H_CH1_channle_eneble & V_CH1_channle_eneble)
		begin
		if (Address_CH_read == 15359) Address_CH_read <= 0; 
		else Address_CH_read <= Address_CH_read + TimeScale;
		end
	else if(H_CH2_channle_eneble & V_CH2_channle_eneble)
		begin
		if (Address_CH_read == 15359) Address_CH_read <= 0; 
		else Address_CH_read <= Address_CH_read + TimeScale;
		end
	else Address_CH_read <= 0;
	end
//====================================
/** Drawing always block */
always @(posedge VGA_CLK)
	begin
	if (!Reset)
		begin
		Red <= 8'h00;
		Green <= 8'h00;
		Blue <= 8'h00;
		Address_Fig_Freq <= 0;
		Address_Fig_AMP <= 0;
		Address_Guide <= 0;
		end
	else
		begin
		Blue <= Color_Of_Images[7:0];
		Green <= Color_Of_Images[15:8];
		Red <= Color_Of_Images[23:16];
		/** Display scope page */
		if (!Guide_Activated)
			begin
			/** Draw time cursors */
			if (Cursors_Enable && CH1_Right_Time_Cursor == H_Pixel && V_CH1_channle_eneble)
				begin
				Red  <= 8'hFF;
				Green<= 8'h00;
				Blue <= 8'h00; 
				end
			else if (Cursors_Enable && CH1_Left_Time_Cursor == H_Pixel && V_CH1_channle_eneble)
				begin
				Red  <= 8'h00;
				Green<= 8'hFF;
				Blue <= 8'h00; 
				end
			else if (Cursors_Enable && CH2_Right_Time_Cursor == H_Pixel && V_CH2_channle_eneble)
				begin
				Red  <= 8'hFF;
				Green<= 8'h00;
				Blue <= 8'h00; 
				end
			else if (Cursors_Enable && CH2_Left_Time_Cursor == H_Pixel && V_CH2_channle_eneble)
				begin
				Red  <= 8'h00;
				Green<= 8'hFF;
				Blue <= 8'h00; 
				end
			/** Draw amplitude cursors */
			else if (Cursors_Enable && CH1_Up_Amplitude_Cursor == V_Pixel && V_CH1_channle_eneble && H_CH1_channle_eneble)
				begin
				Red  <= 8'hFF;
				Green<= 8'h00;
				Blue <= 8'h00; 
				end
			else if (Cursors_Enable && CH1_Down_Amplitude_Cursor == V_Pixel && V_CH1_channle_eneble && H_CH1_channle_eneble)
				begin
				Red  <= 8'h00;
				Green<= 8'hFF;
				Blue <= 8'h00; 
				end
			else if (Cursors_Enable && CH2_Up_Amplitude_Cursor == V_Pixel && V_CH2_channle_eneble && H_CH2_channle_eneble)
				begin
				Red  <= 8'hFF;
				Green<= 8'h00;
				Blue <= 8'h00; 
				end
			else if (Cursors_Enable && CH2_Down_Amplitude_Cursor == V_Pixel && V_CH2_channle_eneble && H_CH2_channle_eneble)
				begin
				Red  <= 8'h00;
				Green<= 8'hFF;
				Blue <= 8'h00; 
				end
			/** Draw Channels */
			else if (H_CH1_channle_eneble && V_CH1_channle_eneble && Priority == Priority_0) 
				begin
				if (((Data_CH_1 / AmplitudeScale) + (13 + CH1_Offset)) == V_Pixel)
					begin 
					Red  <= 8'd137;
					Green<= 8'd208;
					Blue <= 8'd40;  
					end
				else 
					begin
					Red <= 8'h00;
					Green <= 8'h00;
					Blue <= 8'h00;
					end
				end
			else if (H_CH2_channle_eneble && V_CH2_channle_eneble && Priority == Priority_0) 
				begin
				if (((Data_CH_2 / AmplitudeScale + (247 + CH2_Offset))) == V_Pixel)
					begin 
					Red <= 8'd39;
					Green <= 8'd206;
					Blue <= 8'd220;  
					end
				else 
					begin
					Red <= 8'h00;
					Green <= 8'h00;
					Blue <= 8'h00;
					end
				end
			/** Draw the terminal Vertical line of Grid */
			else if ((H_Pixel == 18 || H_Pixel == 499) && Priority == Priority_1)
				begin
				if ((V_Pixel > 11 && V_Pixel < 230) || (V_Pixel > 244 && V_Pixel < 463))
					begin
					Red <= 8'h7F;
					Green <= 8'h7F;
					Blue <= 8'h7F;
					end
				else
					begin
					Red <= 8'h00;
					Green <= 8'h00;
					Blue <= 8'h00;
					end
				end
			/** Draw the vertical dash lines of Grid */
			else if ((V_Pixel > 11 && V_Pixel < 230 || V_Pixel > 244 && V_Pixel < 463) && H_Pixel > 19 && H_Pixel < 500)
				begin
				if (V_Pixel % 4 == 0)
					begin
					if (H_Pixel == 68 || H_Pixel == 116 || H_Pixel == 164 || H_Pixel == 212 || H_Pixel == 260 || H_Pixel == 308 || H_Pixel == 356 || H_Pixel == 404 || H_Pixel == 452 )
						begin
						Red <= 8'h5A;
						Green <= 8'h5A;
						Blue <= 8'h5A;
						end		
					else 
						begin
						Red <= 8'h00;
						Green <= 8'h00;
						Blue <= 8'h00;
						end			
					end
				/** Draw the horizontal dash lines of Grid */
				else if (H_Pixel % 4 == 0)
					begin
					if (V_Pixel == 54 || V_Pixel == 98 || V_Pixel == 142 || V_Pixel == 186 || V_Pixel == 289 || V_Pixel == 333 || V_Pixel == 377 || V_Pixel == 421 )
						begin
						Red <= 8'h5A;
						Green <= 8'h5A;
						Blue <= 8'h5A;					
						end
					else 
						begin
						Red <= 8'h00;
						Green <= 8'h00;
						Blue <= 8'h00;
						end
					end
				else 
					begin
					Red <= 8'h00;
					Green <= 8'h00;
					Blue <= 8'h00;
					end
				end
			/** Draw Streaming string */
			else if (H_Pixel > 519 && H_Pixel < 593 && V_Pixel > 382 && V_Pixel < 400 && ScreenCapture && !Nios_Finish_Reading_Flag)
				begin
				Long_String_Address <= V_Pixel - 385;
				if (H_Pixel > 521 && H_Pixel < 595 && V_Pixel > 384 && V_Pixel < 402)
					begin
					if (Long_String_Data[83 - H_Pixel[6:0]] == 1)
						begin
						Red <= 8'h82;
						Green <= 8'h82;
						Blue <= 8'h82;
						end
					else
						begin
						Red <= 8'h00;
						Green <= 8'h00;
						Blue <= 8'h00;
						end
					end
				else
					begin
					Red <= 8'h00;
					Green <= 8'h00;
					Blue <= 8'h00;
					end
				end
			/** Draw loading bar */
			else if (H_Pixel > 518 && H_Pixel < 624 && V_Pixel > 401 && V_Pixel < 422 && ScreenCapture && !Nios_Finish_Reading_Flag)
				begin
				Red <= 8'h37;
				Green <= 8'h53; 
				Blue <= 8'h79;
				if (H_Pixel > 519 && H_Pixel < 623 && V_Pixel > 402 && V_Pixel < 421)
					begin
					Red <= 8'h00;
					Green <= 8'h00; 
					Blue <= 8'h00;
					if (H_Pixel > 520 && H_Pixel < (622 - (100 - Loading_Percentage)) && V_Pixel > 403 && V_Pixel < 420)
						begin
						Red <= 8'h37;
						Green <= 8'h53; 
						Blue <= 8'h79;
						end
					end
				end
			/** Draw Image **/
			else if (H_Freq1_eneble & V_Freq1_eneble)
				begin
				Key_Fig <= 3;
				if (Address_Fig_Freq == 1499) Address_Fig_Freq <= 0; 
				else Address_Fig_Freq <= Address_Fig_Freq + 1;
				end
			else if (H_Freq2_eneble & V_Freq2_eneble)
				begin
				Key_Fig <= 3;
				if (Address_Fig_Freq == 1499) Address_Fig_Freq <= 0; 
				else Address_Fig_Freq <= Address_Fig_Freq + 1;
				end
			else if (H_Amp1_eneble & V_Amp1_eneble)
				begin
				Key_Fig <= 4;
				if (Address_Fig_AMP == 1574) Address_Fig_AMP <= 0; 
				else Address_Fig_AMP <= Address_Fig_AMP + 1;
				end
			else if (H_Amp2_eneble & V_Amp2_eneble)
				begin
				Key_Fig <= 4;
				if (Address_Fig_AMP == 1574) Address_Fig_AMP <= 0; 
				else Address_Fig_AMP <= Address_Fig_AMP + 1;
				end
			/** Draw frequency value for CH1 */
			/** Draw ten_thous digit */
			else if (H_Pixel > 531 && H_Pixel < 541 && V_Pixel > 41 && V_Pixel < 59)
				begin
				case(CH1_BCD[19:16])
				4'h0: Font_Address <= V_Pixel + 36 + 690; 
				4'h1: Font_Address <= V_Pixel + 36 + 706;
				4'h2: Font_Address <= V_Pixel + 36 + 722;
				4'h3: Font_Address <= V_Pixel + 36 + 738;
				4'h4: Font_Address <= V_Pixel + 36 + 754;
				4'h5: Font_Address <= V_Pixel + 36 + 770;
				4'h6: Font_Address <= V_Pixel + 36 + 786;
				4'h7: Font_Address <= V_Pixel + 36 + 802;
				4'h8: Font_Address <= V_Pixel + 36 + 818;
				4'h9: Font_Address <= V_Pixel + 36 + 834;
				default: Font_Address <= V_Pixel + 36 + 690;
				endcase
				if (H_Pixel > 533 && H_Pixel < 543 && V_Pixel > 43 && V_Pixel < 61)
					begin
					if (Font_Out[13-H_Pixel[2:0]] == 1) 
						begin
						Red <= 8'h82;
						Green <= 8'h82;
						Blue <= 8'h82;
						end
					else
						begin
						Red <= 8'h00;
						Green <= 8'h00;
						Blue <= 8'h00;
						end
					end
				else
					begin
					Red <= 8'h00;
					Green <= 8'h00;
					Blue <= 8'h00;
					end
				end
			/** Draw thous digit */
			else if (H_Pixel > 543 && H_Pixel < 553 && V_Pixel > 41 && V_Pixel < 59)
				begin
				case(CH1_BCD[15:12])
				4'h0: Font_Address <= V_Pixel + 36 + 690; 
				4'h1: Font_Address <= V_Pixel + 36 + 706;
				4'h2: Font_Address <= V_Pixel + 36 + 722;
				4'h3: Font_Address <= V_Pixel + 36 + 738;
				4'h4: Font_Address <= V_Pixel + 36 + 754;
				4'h5: Font_Address <= V_Pixel + 36 + 770;
				4'h6: Font_Address <= V_Pixel + 36 + 786;
				4'h7: Font_Address <= V_Pixel + 36 + 802;
				4'h8: Font_Address <= V_Pixel + 36 + 818;
				4'h9: Font_Address <= V_Pixel + 36 + 834;
				default: Font_Address <= V_Pixel + 36 + 690;
				endcase
				if (H_Pixel > 545 && H_Pixel < 555 && V_Pixel > 43 && V_Pixel < 61)
					begin
					if (Font_Out[9-H_Pixel[2:0]] == 1) 
						begin
						Red <= 8'h82;
						Green <= 8'h82;
						Blue <= 8'h82;
						end
					else
						begin
						Red <= 8'h00;
						Green <= 8'h00;
						Blue <= 8'h00;
						end
					end
				else
					begin
					Red <= 8'h00;
					Green <= 8'h00;
					Blue <= 8'h00;
					end
				end
			/** Draw hundred digit */
			else if (H_Pixel > 555 && H_Pixel < 565 && V_Pixel > 41 && V_Pixel < 59)
				begin
				case(CH1_BCD[11:8])
				4'h0: Font_Address <= V_Pixel + 36 + 690; 
				4'h1: Font_Address <= V_Pixel + 36 + 706;
				4'h2: Font_Address <= V_Pixel + 36 + 722;
				4'h3: Font_Address <= V_Pixel + 36 + 738;
				4'h4: Font_Address <= V_Pixel + 36 + 754;
				4'h5: Font_Address <= V_Pixel + 36 + 770;
				4'h6: Font_Address <= V_Pixel + 36 + 786;
				4'h7: Font_Address <= V_Pixel + 36 + 802;
				4'h8: Font_Address <= V_Pixel + 36 + 818;
				4'h9: Font_Address <= V_Pixel + 36 + 834;
				default: Font_Address <= V_Pixel + 36 + 690;
				endcase
				if (H_Pixel > 557 && H_Pixel < 567 && V_Pixel > 43 && V_Pixel < 61)
					begin
					if (Font_Out[13-H_Pixel[2:0]] == 1) 
						begin
						Red <= 8'h82;
						Green <= 8'h82;
						Blue <= 8'h82;
						end
					else
						begin
						Red <= 8'h00;
						Green <= 8'h00;
						Blue <= 8'h00;
						end
					end
				else
					begin
					Red <= 8'h00;
					Green <= 8'h00;
					Blue <= 8'h00;
					end
				end
			/** Draw ten digit */
			else if (H_Pixel > 567 && H_Pixel < 577 && V_Pixel > 41 && V_Pixel < 59)
				begin
				case(CH1_BCD[7:4])
				4'h0: Font_Address <= V_Pixel + 36 + 690; 
				4'h1: Font_Address <= V_Pixel + 36 + 706;
				4'h2: Font_Address <= V_Pixel + 36 + 722;
				4'h3: Font_Address <= V_Pixel + 36 + 738;
				4'h4: Font_Address <= V_Pixel + 36 + 754;
				4'h5: Font_Address <= V_Pixel + 36 + 770;
				4'h6: Font_Address <= V_Pixel + 36 + 786;
				4'h7: Font_Address <= V_Pixel + 36 + 802;
				4'h8: Font_Address <= V_Pixel + 36 + 818;
				4'h9: Font_Address <= V_Pixel + 36 + 834;
				default: Font_Address <= V_Pixel + 36 + 690;
				endcase
				if (H_Pixel > 569 && H_Pixel < 579 && V_Pixel > 43 && V_Pixel < 61)
					begin
					if (Font_Out[9-H_Pixel[2:0]] == 1) 
						begin
						Red <= 8'h82;
						Green <= 8'h82;
						Blue <= 8'h82;
						end
					else
						begin
						Red <= 8'h00;
						Green <= 8'h00;
						Blue <= 8'h00;
						end
					end
				else
					begin
					Red <= 8'h00;
					Green <= 8'h00;
					Blue <= 8'h00;
					end
				end
			/** Draw one digit */
			else if (H_Pixel > 579 && H_Pixel < 589 && V_Pixel > 41 && V_Pixel < 59)
				begin
				case(CH1_BCD[3:0])
				4'h0: Font_Address <= V_Pixel + 36 + 690; 
				4'h1: Font_Address <= V_Pixel + 36 + 706;
				4'h2: Font_Address <= V_Pixel + 36 + 722;
				4'h3: Font_Address <= V_Pixel + 36 + 738;
				4'h4: Font_Address <= V_Pixel + 36 + 754;
				4'h5: Font_Address <= V_Pixel + 36 + 770;
				4'h6: Font_Address <= V_Pixel + 36 + 786;
				4'h7: Font_Address <= V_Pixel + 36 + 802;
				4'h8: Font_Address <= V_Pixel + 36 + 818;
				4'h9: Font_Address <= V_Pixel + 36 + 834;
				default: Font_Address <= V_Pixel + 36 + 690;
				endcase
				if (H_Pixel > 581 && H_Pixel < 591 && V_Pixel > 43 && V_Pixel < 61)
					begin
					if (Font_Out[13-H_Pixel[2:0]] == 1) 
						begin
						Red <= 8'h82;
						Green <= 8'h82;
						Blue <= 8'h82;
						end
					else
						begin
						Red <= 8'h00;
						Green <= 8'h00;
						Blue <= 8'h00;
						end
					end
				else
					begin
					Red <= 8'h00;
					Green <= 8'h00;
					Blue <= 8'h00;
					end
				end
			/** Draw Hz string */
			else if (H_Pixel > 591 && H_Pixel < 609 && V_Pixel > 41 && V_Pixel < 59)
				begin
				String_Address <= V_Pixel - 44;
				if (H_Pixel > 593 && H_Pixel < 611 && V_Pixel > 43 && V_Pixel < 61)
					begin
					if (String_Data[17-H_Pixel[3:0]] == 1)
						begin
						Red <= 8'h82;
						Green <= 8'h82;
						Blue <= 8'h82;
						end
					else
						begin
						Red <= 8'h00;
						Green <= 8'h00;
						Blue <= 8'h00;
						end
					end
				else
					begin
					Red <= 8'h00;
					Green <= 8'h00;
					Blue <= 8'h00;
					end
				end
			/** Draw amplitude value for CH1 */
			/** Draw tens digit */
			else if (H_Pixel > 531 && H_Pixel < 541 && V_Pixel > 117 && V_Pixel < 135)
				begin
				case(CH1_Amplitude_BCD[15:12])
				4'h0: Font_Address <= V_Pixel + 36 + 612; 
				4'h1: Font_Address <= V_Pixel + 36 + 628;
				4'h2: Font_Address <= V_Pixel + 36 + 644;
				4'h3: Font_Address <= V_Pixel + 36 + 660;
				4'h4: Font_Address <= V_Pixel + 36 + 676;
				4'h5: Font_Address <= V_Pixel + 36 + 692;
				4'h6: Font_Address <= V_Pixel + 36 + 708;
				4'h7: Font_Address <= V_Pixel + 36 + 724;
				4'h8: Font_Address <= V_Pixel + 36 + 740;
				4'h9: Font_Address <= V_Pixel + 36 + 756;
				default: Font_Address <= V_Pixel + 36 + 612;
				endcase
				if (H_Pixel > 533 && H_Pixel < 543 && V_Pixel > 119 && V_Pixel < 137)
					begin
					if (Font_Out[13-H_Pixel[2:0]] == 1) 
						begin
						Red <= 8'h82;
						Green <= 8'h82;
						Blue <= 8'h82;
						end
					else
						begin
						Red <= 8'h00;
						Green <= 8'h00;
						Blue <= 8'h00;
						end
					end
				else
					begin
					Red <= 8'h00;
					Green <= 8'h00;
					Blue <= 8'h00;
					end
				end
			/** Draw ones digit */
			else if (H_Pixel > 543 && H_Pixel < 553 && V_Pixel > 117 && V_Pixel < 135)
				begin
				case(CH1_Amplitude_BCD[11:8])
				4'h0: Font_Address <= V_Pixel + 36 + 612; 
				4'h1: Font_Address <= V_Pixel + 36 + 628;
				4'h2: Font_Address <= V_Pixel + 36 + 644;
				4'h3: Font_Address <= V_Pixel + 36 + 660;
				4'h4: Font_Address <= V_Pixel + 36 + 676;
				4'h5: Font_Address <= V_Pixel + 36 + 692;
				4'h6: Font_Address <= V_Pixel + 36 + 708;
				4'h7: Font_Address <= V_Pixel + 36 + 724;
				4'h8: Font_Address <= V_Pixel + 36 + 740;
				4'h9: Font_Address <= V_Pixel + 36 + 756;
				default: Font_Address <= V_Pixel + 36 + 612;
				endcase
				if (H_Pixel > 545 && H_Pixel < 555 && V_Pixel > 119 && V_Pixel < 137)
					begin
					if (Font_Out[9-H_Pixel[2:0]] == 1) 
						begin
						Red <= 8'h82;
						Green <= 8'h82;
						Blue <= 8'h82;
						end
					else
						begin
						Red <= 8'h00;
						Green <= 8'h00;
						Blue <= 8'h00;
						end
					end
				else
					begin
					Red <= 8'h00;
					Green <= 8'h00;
					Blue <= 8'h00;
					end
				end
			/** Draw . char */
			else if (H_Pixel > 555 && H_Pixel < 565 && V_Pixel > 117 && V_Pixel < 135)
				begin
				Font_Address <= V_Pixel + 36 + 582; 
				if (H_Pixel > 557 && H_Pixel < 567 && V_Pixel > 119 && V_Pixel < 137)
					begin
					if (Font_Out[13-H_Pixel[2:0]] == 1) 
						begin
						Red <= 8'h82;
						Green <= 8'h82;
						Blue <= 8'h82;
						end
					else
						begin
						Red <= 8'h00;
						Green <= 8'h00;
						Blue <= 8'h00;
						end
					end
				else
					begin
					Red <= 8'h00;
					Green <= 8'h00;
					Blue <= 8'h00;
					end
				end
			/** Draw ones fraction digit */
			else if (H_Pixel > 567 && H_Pixel < 577 && V_Pixel > 117 && V_Pixel < 135)
				begin
				case(CH1_Amplitude_BCD[7:4])
				4'h0: Font_Address <= V_Pixel + 36 + 612; 
				4'h1: Font_Address <= V_Pixel + 36 + 628;
				4'h2: Font_Address <= V_Pixel + 36 + 644;
				4'h3: Font_Address <= V_Pixel + 36 + 660;
				4'h4: Font_Address <= V_Pixel + 36 + 676;
				4'h5: Font_Address <= V_Pixel + 36 + 692;
				4'h6: Font_Address <= V_Pixel + 36 + 708;
				4'h7: Font_Address <= V_Pixel + 36 + 724;
				4'h8: Font_Address <= V_Pixel + 36 + 740;
				4'h9: Font_Address <= V_Pixel + 36 + 756;
				default: Font_Address <= V_Pixel + 36 + 612;
				endcase
				if (H_Pixel > 569 && H_Pixel < 579 && V_Pixel > 119 && V_Pixel < 137)
					begin
					if (Font_Out[9-H_Pixel[2:0]] == 1) 
						begin
						Red <= 8'h82;
						Green <= 8'h82;
						Blue <= 8'h82;
						end
					else
						begin
						Red <= 8'h00;
						Green <= 8'h00;
						Blue <= 8'h00;
						end
					end
				else
					begin
					Red <= 8'h00;
					Green <= 8'h00;
					Blue <= 8'h00;
					end
				end
			/** Draw tens fraction digit */
			else if (H_Pixel > 579 && H_Pixel < 589 && V_Pixel > 117 && V_Pixel < 135)
				begin
				case(CH1_Amplitude_BCD[3:0])
				4'h0: Font_Address <= V_Pixel + 36 + 612; 
				4'h1: Font_Address <= V_Pixel + 36 + 628;
				4'h2: Font_Address <= V_Pixel + 36 + 644;
				4'h3: Font_Address <= V_Pixel + 36 + 660;
				4'h4: Font_Address <= V_Pixel + 36 + 676;
				4'h5: Font_Address <= V_Pixel + 36 + 692;
				4'h6: Font_Address <= V_Pixel + 36 + 708;
				4'h7: Font_Address <= V_Pixel + 36 + 724;
				4'h8: Font_Address <= V_Pixel + 36 + 740;
				4'h9: Font_Address <= V_Pixel + 36 + 756;
				default: Font_Address <= V_Pixel + 36 + 612;
				endcase
				if (H_Pixel > 581 && H_Pixel < 591 && V_Pixel > 119 && V_Pixel < 137)
					begin
					if (Font_Out[13-H_Pixel[2:0]] == 1) 
						begin
						Red <= 8'h82;
						Green <= 8'h82;
						Blue <= 8'h82;
						end
					else
						begin
						Red <= 8'h00;
						Green <= 8'h00;
						Blue <= 8'h00;
						end
					end
				else
					begin
					Red <= 8'h00;
					Green <= 8'h00;
					Blue <= 8'h00;
					end
				end
			/** Draw Vp-p string */
			else if (H_Pixel > 591 && H_Pixel < 625 && V_Pixel > 117 && V_Pixel < 135)
				begin
				Long_String_Address <= V_Pixel - 103;
				if (H_Pixel > 593 && H_Pixel < 627 && V_Pixel > 119 && V_Pixel < 137)
					begin
					if (Long_String_Data[153-H_Pixel[6:0]] == 1)
						begin
						Red <= 8'h82;
						Green <= 8'h82;
						Blue <= 8'h82;
						end
					else
						begin
						Red <= 8'h00;
						Green <= 8'h00;
						Blue <= 8'h00;
						end
					end
				else
					begin
					Red <= 8'h00;
					Green <= 8'h00;
					Blue <= 8'h00;
					end
				end
			/** Draw frequency value for CH2 */
			/** Draw ten_thous digit */
			else if (H_Pixel > 531 && H_Pixel < 541 && V_Pixel > 274 && V_Pixel < 292)
				begin
				case(CH2_BCD[19:16])
				4'h0: Font_Address <= V_Pixel + 36 + 457; 
				4'h1: Font_Address <= V_Pixel + 36 + 473;
				4'h2: Font_Address <= V_Pixel + 36 + 489;
				4'h3: Font_Address <= V_Pixel + 36 + 505;
				4'h4: Font_Address <= V_Pixel + 36 + 521;
				4'h5: Font_Address <= V_Pixel + 36 + 537;
				4'h6: Font_Address <= V_Pixel + 36 + 553;
				4'h7: Font_Address <= V_Pixel + 36 + 569;
				4'h8: Font_Address <= V_Pixel + 36 + 585;
				4'h9: Font_Address <= V_Pixel + 36 + 601;
				default: Font_Address <= V_Pixel + 36 + 457;
				endcase
				if (H_Pixel > 533 && H_Pixel < 543 && V_Pixel > 276 && V_Pixel < 294)
					begin
					if (Font_Out[13-H_Pixel[2:0]] == 1) 
						begin
						Red <= 8'h82;
						Green <= 8'h82;
						Blue <= 8'h82;
						end
					else
						begin
						Red <= 8'h00;
						Green <= 8'h00;
						Blue <= 8'h00;
						end
					end
				else
					begin
					Red <= 8'h00;
					Green <= 8'h00;
					Blue <= 8'h00;
					end
				end
			/** Draw thous digit */
			else if (H_Pixel > 543 && H_Pixel < 553 && V_Pixel > 274 && V_Pixel < 292)
				begin
				case(CH2_BCD[15:12])
				4'h0: Font_Address <= V_Pixel + 36 + 457; 
				4'h1: Font_Address <= V_Pixel + 36 + 473;
				4'h2: Font_Address <= V_Pixel + 36 + 489;
				4'h3: Font_Address <= V_Pixel + 36 + 505;
				4'h4: Font_Address <= V_Pixel + 36 + 521;
				4'h5: Font_Address <= V_Pixel + 36 + 537;
				4'h6: Font_Address <= V_Pixel + 36 + 553;
				4'h7: Font_Address <= V_Pixel + 36 + 569;
				4'h8: Font_Address <= V_Pixel + 36 + 585;
				4'h9: Font_Address <= V_Pixel + 36 + 601;
				default: Font_Address <= V_Pixel + 36 + 457;
				endcase
				if (H_Pixel > 545 && H_Pixel < 555 && V_Pixel > 276 && V_Pixel < 294)
					begin
					if (Font_Out[9-H_Pixel[2:0]] == 1) 
						begin
						Red <= 8'h82;
						Green <= 8'h82;
						Blue <= 8'h82;
						end
					else
						begin
						Red <= 8'h00;
						Green <= 8'h00;
						Blue <= 8'h00;
						end
					end
				else
					begin
					Red <= 8'h00;
					Green <= 8'h00;
					Blue <= 8'h00;
					end
				end
			/** Draw hundred digit */
			else if (H_Pixel > 555 && H_Pixel < 565 && V_Pixel > 274 && V_Pixel < 292)
				begin
				case(CH2_BCD[11:8])
				4'h0: Font_Address <= V_Pixel + 36 + 457; 
				4'h1: Font_Address <= V_Pixel + 36 + 473;
				4'h2: Font_Address <= V_Pixel + 36 + 489;
				4'h3: Font_Address <= V_Pixel + 36 + 505;
				4'h4: Font_Address <= V_Pixel + 36 + 521;
				4'h5: Font_Address <= V_Pixel + 36 + 537;
				4'h6: Font_Address <= V_Pixel + 36 + 553;
				4'h7: Font_Address <= V_Pixel + 36 + 569;
				4'h8: Font_Address <= V_Pixel + 36 + 585;
				4'h9: Font_Address <= V_Pixel + 36 + 601;
				default: Font_Address <= V_Pixel + 36 + 457;
				endcase
				if (H_Pixel > 557 && H_Pixel < 567 && V_Pixel > 276 && V_Pixel < 294)
					begin
					if (Font_Out[13-H_Pixel[2:0]] == 1) 
						begin
						Red <= 8'h82;
						Green <= 8'h82;
						Blue <= 8'h82;
						end
					else
						begin
						Red <= 8'h00;
						Green <= 8'h00;
						Blue <= 8'h00;
						end
					end
				else
					begin
					Red <= 8'h00;
					Green <= 8'h00;
					Blue <= 8'h00;
					end
				end
			/** Draw ten digit */
			else if (H_Pixel > 567 && H_Pixel < 577 && V_Pixel > 274 && V_Pixel < 292)
				begin
				case(CH2_BCD[7:4])
				4'h0: Font_Address <= V_Pixel + 36 + 457; 
				4'h1: Font_Address <= V_Pixel + 36 + 473;
				4'h2: Font_Address <= V_Pixel + 36 + 489;
				4'h3: Font_Address <= V_Pixel + 36 + 505;
				4'h4: Font_Address <= V_Pixel + 36 + 521;
				4'h5: Font_Address <= V_Pixel + 36 + 537;
				4'h6: Font_Address <= V_Pixel + 36 + 553;
				4'h7: Font_Address <= V_Pixel + 36 + 569;
				4'h8: Font_Address <= V_Pixel + 36 + 585;
				4'h9: Font_Address <= V_Pixel + 36 + 601;
				default: Font_Address <= V_Pixel + 36 + 457;
				endcase
				if (H_Pixel > 569 && H_Pixel < 579 && V_Pixel > 276 && V_Pixel < 294)
					begin
					if (Font_Out[9-H_Pixel[2:0]] == 1) 
						begin
						Red <= 8'h82;
						Green <= 8'h82;
						Blue <= 8'h82;
						end
					else
						begin
						Red <= 8'h00;
						Green <= 8'h00;
						Blue <= 8'h00;
						end
					end
				else
					begin
					Red <= 8'h00;
					Green <= 8'h00;
					Blue <= 8'h00;
					end
				end
			/** Draw one digit */
			else if (H_Pixel > 579 && H_Pixel < 589 && V_Pixel > 274 && V_Pixel < 292)
				begin
				case(CH2_BCD[3:0])
				4'h0: Font_Address <= V_Pixel + 36 + 457; 
				4'h1: Font_Address <= V_Pixel + 36 + 473;
				4'h2: Font_Address <= V_Pixel + 36 + 489;
				4'h3: Font_Address <= V_Pixel + 36 + 505;
				4'h4: Font_Address <= V_Pixel + 36 + 521;
				4'h5: Font_Address <= V_Pixel + 36 + 537;
				4'h6: Font_Address <= V_Pixel + 36 + 553;
				4'h7: Font_Address <= V_Pixel + 36 + 569;
				4'h8: Font_Address <= V_Pixel + 36 + 585;
				4'h9: Font_Address <= V_Pixel + 36 + 601;
				default: Font_Address <= V_Pixel + 36 + 457;
				endcase
				if (H_Pixel > 581 && H_Pixel < 591 && V_Pixel > 276 && V_Pixel < 294)
					begin
					if (Font_Out[13-H_Pixel[2:0]] == 1) 
						begin
						Red <= 8'h82;
						Green <= 8'h82;
						Blue <= 8'h82;
						end
					else
						begin
						Red <= 8'h00;
						Green <= 8'h00;
						Blue <= 8'h00;
						end
					end
				else
					begin
					Red <= 8'h00;
					Green <= 8'h00;
					Blue <= 8'h00;
					end
				end
			/** Draw Hz string */
			else if (H_Pixel > 591 && H_Pixel < 609 && V_Pixel > 274 && V_Pixel < 292)
				begin
				String_Address <= V_Pixel - 277;
				if (H_Pixel > 593 && H_Pixel < 611 && V_Pixel > 276 && V_Pixel < 294)
					begin
					if (String_Data[17-H_Pixel[3:0]] == 1)
						begin
						Red <= 8'h82;
						Green <= 8'h82;
						Blue <= 8'h82;
						end
					else
						begin
						Red <= 8'h00;
						Green <= 8'h00;
						Blue <= 8'h00;
						end
					end
				else
					begin
					Red <= 8'h00;
					Green <= 8'h00;
					Blue <= 8'h00;
					end
				end
			/** Draw amplitude value for CH2 */
			/** Draw tens digit */
			else if (H_Pixel > 531 && H_Pixel < 541 && V_Pixel > 350 && V_Pixel < 368)
				begin
				case(CH2_Amplitude_BCD[15:12])
				4'h0: Font_Address <= V_Pixel + 36 + 379; 
				4'h1: Font_Address <= V_Pixel + 36 + 395;
				4'h2: Font_Address <= V_Pixel + 36 + 411;
				4'h3: Font_Address <= V_Pixel + 36 + 427;
				4'h4: Font_Address <= V_Pixel + 36 + 443;
				4'h5: Font_Address <= V_Pixel + 36 + 459;
				4'h6: Font_Address <= V_Pixel + 36 + 475;
				4'h7: Font_Address <= V_Pixel + 36 + 491;
				4'h8: Font_Address <= V_Pixel + 36 + 507;
				4'h9: Font_Address <= V_Pixel + 36 + 523;
				default: Font_Address <= V_Pixel + 36 + 379;
				endcase
				if (H_Pixel > 533 && H_Pixel < 543 && V_Pixel > 352 && V_Pixel < 370)
					begin
					if (Font_Out[13-H_Pixel[2:0]] == 1) 
						begin
						Red <= 8'h82;
						Green <= 8'h82;
						Blue <= 8'h82;
						end
					else
						begin
						Red <= 8'h00;
						Green <= 8'h00;
						Blue <= 8'h00;
						end
					end
				else
					begin
					Red <= 8'h00;
					Green <= 8'h00;
					Blue <= 8'h00;
					end
				end
			/** Draw ones digit */
			else if (H_Pixel > 543 && H_Pixel < 553 && V_Pixel > 350 && V_Pixel < 368)
				begin
				case(CH2_Amplitude_BCD[11:8])
				4'h0: Font_Address <= V_Pixel + 36 + 379; 
				4'h1: Font_Address <= V_Pixel + 36 + 395;
				4'h2: Font_Address <= V_Pixel + 36 + 411;
				4'h3: Font_Address <= V_Pixel + 36 + 427;
				4'h4: Font_Address <= V_Pixel + 36 + 443;
				4'h5: Font_Address <= V_Pixel + 36 + 459;
				4'h6: Font_Address <= V_Pixel + 36 + 475;
				4'h7: Font_Address <= V_Pixel + 36 + 491;
				4'h8: Font_Address <= V_Pixel + 36 + 507;
				4'h9: Font_Address <= V_Pixel + 36 + 523;
				default: Font_Address <= V_Pixel + 36 + 379;
				endcase
				if (H_Pixel > 545 && H_Pixel < 555 && V_Pixel > 352 && V_Pixel < 370)
					begin
					if (Font_Out[9-H_Pixel[2:0]] == 1) 
						begin
						Red <= 8'h82;
						Green <= 8'h82;
						Blue <= 8'h82;
						end
					else
						begin
						Red <= 8'h00;
						Green <= 8'h00;
						Blue <= 8'h00;
						end
					end
				else
					begin
					Red <= 8'h00;
					Green <= 8'h00;
					Blue <= 8'h00;
					end
				end
			/** Draw . char */
			else if (H_Pixel > 555 && H_Pixel < 565 && V_Pixel > 350 && V_Pixel < 368)
				begin
				Font_Address <= V_Pixel + 36 + 347; 
				if (H_Pixel > 557 && H_Pixel < 567 && V_Pixel > 352 && V_Pixel < 370)
					begin
					if (Font_Out[13-H_Pixel[2:0]] == 1) 
						begin
						Red <= 8'h82;
						Green <= 8'h82;
						Blue <= 8'h82;
						end
					else
						begin
						Red <= 8'h00;
						Green <= 8'h00;
						Blue <= 8'h00;
						end
					end
				else
					begin
					Red <= 8'h00;
					Green <= 8'h00;
					Blue <= 8'h00;
					end
				end
			/** Draw ones fraction digit */
			else if (H_Pixel > 567 && H_Pixel < 577 && V_Pixel > 350 && V_Pixel < 368)
				begin
				case(CH2_Amplitude_BCD[7:4])
				4'h0: Font_Address <= V_Pixel + 36 + 379; 
				4'h1: Font_Address <= V_Pixel + 36 + 395;
				4'h2: Font_Address <= V_Pixel + 36 + 411;
				4'h3: Font_Address <= V_Pixel + 36 + 427;
				4'h4: Font_Address <= V_Pixel + 36 + 443;
				4'h5: Font_Address <= V_Pixel + 36 + 459;
				4'h6: Font_Address <= V_Pixel + 36 + 475;
				4'h7: Font_Address <= V_Pixel + 36 + 491;
				4'h8: Font_Address <= V_Pixel + 36 + 507;
				4'h9: Font_Address <= V_Pixel + 36 + 523;
				default: Font_Address <= V_Pixel + 36 + 379;
				endcase
				if (H_Pixel > 569 && H_Pixel < 579 && V_Pixel > 352 && V_Pixel < 370)
					begin
					if (Font_Out[9-H_Pixel[2:0]] == 1) 
						begin
						Red <= 8'h82;
						Green <= 8'h82;
						Blue <= 8'h82;
						end
					else
						begin
						Red <= 8'h00;
						Green <= 8'h00;
						Blue <= 8'h00;
						end
					end
				else
					begin
					Red <= 8'h00;
					Green <= 8'h00;
					Blue <= 8'h00;
					end
				end
			/** Draw tens fraction digit */
			else if (H_Pixel > 579 && H_Pixel < 589 && V_Pixel > 350 && V_Pixel < 368)
				begin
				case(CH2_Amplitude_BCD[3:0])
				4'h0: Font_Address <= V_Pixel + 36 + 379; 
				4'h1: Font_Address <= V_Pixel + 36 + 395;
				4'h2: Font_Address <= V_Pixel + 36 + 411;
				4'h3: Font_Address <= V_Pixel + 36 + 427;
				4'h4: Font_Address <= V_Pixel + 36 + 443;
				4'h5: Font_Address <= V_Pixel + 36 + 459;
				4'h6: Font_Address <= V_Pixel + 36 + 475;
				4'h7: Font_Address <= V_Pixel + 36 + 491;
				4'h8: Font_Address <= V_Pixel + 36 + 507;
				4'h9: Font_Address <= V_Pixel + 36 + 523;
				default: Font_Address <= V_Pixel + 36 + 379;
				endcase
				if (H_Pixel > 581 && H_Pixel < 591 && V_Pixel > 352 && V_Pixel < 370)
					begin
					if (Font_Out[13-H_Pixel[2:0]] == 1) 
						begin
						Red <= 8'h82;
						Green <= 8'h82;
						Blue <= 8'h82;
						end
					else
						begin
						Red <= 8'h00;
						Green <= 8'h00;
						Blue <= 8'h00;
						end
					end
				else
					begin
					Red <= 8'h00;
					Green <= 8'h00;
					Blue <= 8'h00;
					end
				end
			/** Draw Vp-p string */
			else if (H_Pixel > 591 && H_Pixel < 625 && V_Pixel > 350 && V_Pixel < 368)
				begin
				Long_String_Address <= V_Pixel - 336;
				if (H_Pixel > 593 && H_Pixel < 627 && V_Pixel > 352 && V_Pixel < 370)
					begin
					if (Long_String_Data[153-H_Pixel[6:0]] == 1)
						begin
						Red <= 8'h82;
						Green <= 8'h82;
						Blue <= 8'h82;
						end
					else
						begin
						Red <= 8'h00;
						Green <= 8'h00;
						Blue <= 8'h00;
						end
					end
				else
					begin
					Red <= 8'h00;
					Green <= 8'h00;
					Blue <= 8'h00;
					end
				end
			/** End of drawing digits */
			/** Draw the terminal horizontal line of Grid */
			else if ((V_Pixel == 11 || V_Pixel == 230) || (V_Pixel == 244 || V_Pixel == 463) && Priority == Priority_1)
				begin
				if (H_Pixel >= 18 && H_Pixel < 500)
					begin
					Red <= 8'h7F;
					Green <= 8'h7F;
					Blue <= 8'h7F;
					end
				else
					begin
					Red <= 8'h00;
					Green <= 8'h00;
					Blue <= 8'h00;
					end
				end
			else
				begin
				Address_Guide <= 0;
				Red <= 8'h00;
				Green <= 8'h00;
				Blue <= 8'h00;		
				end
			end
		/** Display Guide page */
		else
			begin
			Address_Fig_Freq <= 0;
			Address_Fig_AMP <= 0;
			if (V_Guide_enable && H_Guide_enable /*&& IgniteAddressing*/)
				begin
				Key_Fig <= 2;
				if (Address_Guide == 307199) Address_Guide <= 0; 
				else Address_Guide <= Address_Guide + 1;
				end
			end
		end
	end
//always @(Main_CLK)
//	begin
//	if (ScreenActiveStart_Flag) IgniteAddressing <= 1;
//	if (ScreenActiveFinish_Flag) IgniteAddressing <= 0;
//	end
endmodule 